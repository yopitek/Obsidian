# MindForge Obsidian Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a local MindForge knowledge engine where dropping a URL into an Obsidian inbox note automatically triggers the GX10 Knowledge Acquisition Loop and writes atomic claim notes back into the vault.

**Architecture:** GX10 (Ubuntu, ASUS Ascent / DGX Spark) runs FastAPI + LangGraph KAL + PostgreSQL 16 (pgvector + pg_trgm) + Celery/Redis + spark-vllm-docker; Mac runs vault-bridge (Python watchdog) that monitors the Obsidian vault, calls GX10 REST API, and writes claim/status/answer .md notes back — polling-only, no push webhooks.

**Tech Stack:** Python 3.11, FastAPI, SQLAlchemy 2.0 (asyncpg), LangGraph 0.2, Celery 5, Redis 7, PostgreSQL 16 + pgvector + pg_trgm, sentence-transformers (BGE-M3), httpx, watchdog 4, python-frontmatter, trafilatura, Brave Search API, pytest-asyncio.

---

## File Map

### GX10 Backend (`gx10/`)

| File | Responsibility |
|---|---|
| `docker-compose.yml` | Postgres, pgvector, Redis, embedding service, API service |
| `.env.example` | All required env vars with safe defaults |
| `migrations/001_initial.sql` | Full schema: topic_packs, sources, claims, knowledge_edges, kal_jobs |
| `services/embedding/main.py` | BGE-M3 embed + BGE-Reranker FastAPI microservice |
| `services/embedding/requirements.txt` | sentence-transformers, fastapi, uvicorn |
| `services/embedding/Dockerfile` | ARM64 Python image, model download at build |
| `services/api/app/config.py` | pydantic-settings: db url, redis, embedding url, LLM url |
| `services/api/app/database.py` | async SQLAlchemy engine, `AsyncSession` dependency |
| `services/api/app/models.py` | ORM: TopicPack, Source, Claim, KnowledgeEdge, KALJob |
| `services/api/app/schemas.py` | Pydantic: LearnRequest, LearnResponse, JobStatus, ClaimOut, QueryRequest, QueryResponse |
| `services/api/app/main.py` | FastAPI app factory, router registration, lifespan |
| `services/api/app/tasks.py` | Celery app + `run_kal_task(job_id)` |
| `services/api/app/kal/prompts.py` | LLM prompt templates (extract, self_question, coverage, validate) |
| `services/api/app/kal/nodes.py` | 7 LangGraph nodes: fetch, extract_claims, self_question, coverage_check, search_expand, cross_validate, index |
| `services/api/app/kal/graph.py` | `KALState` TypedDict + `build_kal_graph()` |
| `services/api/app/routes/learn.py` | POST /learn, GET /learn/{id}/status, GET /learn/{id}/claims |
| `services/api/app/routes/query.py` | POST /query |
| `services/api/app/retrieval/pipeline.py` | `run_hfq_pipeline()` — 5-step HFQ retrieval |
| `services/api/app/retrieval/reranker.py` | `rerank(query, passages)` — calls embedding service |
| `services/api/requirements.txt` | fastapi, sqlalchemy, asyncpg, langgraph, celery, redis, httpx, trafilatura |
| `services/api/Dockerfile` | ARM64 Python image |
| `tests/test_kal_nodes.py` | Unit tests: fetch_node, extract_claims_node mocked |
| `tests/test_retrieval.py` | Unit tests: HFQ pipeline with mocked DB + reranker |
| `tests/test_routes.py` | Integration tests: POST /learn, GET status, POST /query |

### Mac vault-bridge (`vault-bridge/`)

| File | Responsibility |
|---|---|
| `config.py` | pydantic-settings: vault_path, gx10_url, brave_api_key, poll_interval |
| `client.py` | `MindForgeClient` (httpx): post_learn, get_status, get_claims, post_query |
| `inbox.py` | `parse_inbox_file()` → `LearnIntent \| QueryIntent \| None` |
| `watcher.py` | `InboxHandler` + `ClaimEditHandler` (watchdog FileSystemEventHandler) |
| `note_writer.py` | `write_claim_note`, `write_index_note`, `write_status_note`, `write_answer_note` |
| `poller.py` | `JobPoller`: polling loop per task_id, resume_inflight_jobs() on startup |
| `bridge.py` | Entry point: init config, start watcher + poller, resume in-flight jobs |
| `requirements.txt` | watchdog, httpx, python-frontmatter, pydantic-settings |
| `tests/test_inbox.py` | Unit: parse_inbox_file — learn URL, query, malformed |
| `tests/test_note_writer.py` | Unit: correct YAML frontmatter + body for each note type |
| `tests/test_poller.py` | Unit: poller state machine transitions (queued→round-1→done) |

---

## Task 1: Docker Compose + DB Schema

**Files:**
- Create: `gx10/docker-compose.yml`
- Create: `gx10/.env.example`
- Create: `gx10/migrations/001_initial.sql`

- [ ] **Step 1: Write `docker-compose.yml`**

```yaml
# gx10/docker-compose.yml
version: "3.9"

services:
  postgres:
    image: pgvector/pgvector:pg16
    restart: unless-stopped
    env_file: .env
    environment:
      POSTGRES_DB: mindforge
      POSTGRES_USER: mindforge
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    ports:
      - "5432:5432"
    volumes:
      - pg_data:/var/lib/postgresql/data
      - ./migrations:/docker-entrypoint-initdb.d

  redis:
    image: redis:7-alpine
    restart: unless-stopped
    ports:
      - "6379:6379"

  embedding:
    build: ./services/embedding
    restart: unless-stopped
    ports:
      - "8001:8001"
    environment:
      - HF_HOME=/models
    volumes:
      - hf_cache:/models
    deploy:
      resources:
        limits:
          memory: 6g

  api:
    build: ./services/api
    restart: unless-stopped
    env_file: .env
    ports:
      - "8000:8000"
    depends_on:
      - postgres
      - redis
      - embedding
    environment:
      DATABASE_URL: postgresql+asyncpg://mindforge:${POSTGRES_PASSWORD}@postgres:5432/mindforge
      REDIS_URL: redis://redis:6379/0
      EMBEDDING_URL: http://embedding:8001
      LLM_BASE_URL: ${LLM_BASE_URL}

  worker:
    build: ./services/api
    command: celery -A app.tasks worker --loglevel=info --concurrency=2
    restart: unless-stopped
    env_file: .env
    depends_on:
      - postgres
      - redis
      - embedding
    environment:
      DATABASE_URL: postgresql+asyncpg://mindforge:${POSTGRES_PASSWORD}@postgres:5432/mindforge
      REDIS_URL: redis://redis:6379/0
      EMBEDDING_URL: http://embedding:8001
      LLM_BASE_URL: ${LLM_BASE_URL}

volumes:
  pg_data:
  hf_cache:
```

- [ ] **Step 2: Write `.env.example`**

```bash
# gx10/.env.example
POSTGRES_PASSWORD=changeme
LLM_BASE_URL=http://localhost:8080/v1
BRAVE_API_KEY=
```

Copy to `.env` and fill in values: `cp .env.example .env`

- [ ] **Step 3: Write `migrations/001_initial.sql`**

```sql
-- gx10/migrations/001_initial.sql
CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE TABLE IF NOT EXISTS topic_packs (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug        TEXT NOT NULL UNIQUE,
    display_name TEXT NOT NULL,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS sources (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    url         TEXT NOT NULL UNIQUE,
    title       TEXT,
    fetched_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    raw_text    TEXT
);

CREATE TABLE IF NOT EXISTS claims (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    pack_id         UUID NOT NULL REFERENCES topic_packs(id),
    source_id       UUID REFERENCES sources(id),
    content         TEXT NOT NULL,
    source_span     TEXT,
    confidence      FLOAT NOT NULL DEFAULT 0.8,
    embedding       vector(1024),
    validated_at    TIMESTAMPTZ,
    fsrs_due        TIMESTAMPTZ NOT NULL DEFAULT now(),
    fsrs_stability  FLOAT NOT NULL DEFAULT 1.0,
    human_edited    BOOLEAN NOT NULL DEFAULT FALSE,
    deleted_at      TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS knowledge_edges (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    from_claim  UUID NOT NULL REFERENCES claims(id),
    to_claim    UUID NOT NULL REFERENCES claims(id),
    rel_type    TEXT NOT NULL DEFAULT 'supports',
    weight      FLOAT NOT NULL DEFAULT 1.0,
    UNIQUE(from_claim, to_claim, rel_type)
);

CREATE TABLE IF NOT EXISTS kal_jobs (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    source_url      TEXT NOT NULL,
    pack_id         UUID REFERENCES topic_packs(id),
    status          TEXT NOT NULL DEFAULT 'queued',
    current_round   INT NOT NULL DEFAULT 0,
    max_rounds      INT NOT NULL DEFAULT 5,
    questions       JSONB NOT NULL DEFAULT '[]',
    error_msg       TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- HNSW index for dense similarity search
CREATE INDEX IF NOT EXISTS claims_embedding_hnsw
    ON claims USING hnsw (embedding vector_cosine_ops)
    WITH (m = 16, ef_construction = 200);

-- Trigram index for sparse/keyword search
CREATE INDEX IF NOT EXISTS claims_content_trgm
    ON claims USING gin (content gin_trgm_ops);

-- FSR scheduling index
CREATE INDEX IF NOT EXISTS claims_fsrs_due
    ON claims (fsrs_due)
    WHERE deleted_at IS NULL;
```

- [ ] **Step 4: Verify schema syntax**

```bash
cd gx10
docker compose up postgres -d
sleep 5
docker compose exec postgres psql -U mindforge -d mindforge -c "\dt"
```

Expected output:
```
         List of relations
 Schema |      Name       | Type  |   Owner
--------+-----------------+-------+-----------
 public | claims          | table | mindforge
 public | kal_jobs        | table | mindforge
 public | knowledge_edges | table | mindforge
 public | sources         | table | mindforge
 public | topic_packs     | table | mindforge
```

- [ ] **Step 5: Commit**

```bash
git add gx10/docker-compose.yml gx10/.env.example gx10/migrations/001_initial.sql
git commit -m "feat(infra): docker-compose + postgres schema with pgvector+pg_trgm

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

---

## Task 2: BGE-M3 Embedding Service

**Files:**
- Create: `gx10/services/embedding/requirements.txt`
- Create: `gx10/services/embedding/Dockerfile`
- Create: `gx10/services/embedding/main.py`

- [ ] **Step 1: Write `requirements.txt`**

```
# gx10/services/embedding/requirements.txt
fastapi==0.111.0
uvicorn[standard]==0.29.0
sentence-transformers==3.0.1
torch==2.3.1
numpy==1.26.4
```

- [ ] **Step 2: Write `Dockerfile`**

```dockerfile
# gx10/services/embedding/Dockerfile
FROM python:3.11-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Pre-download models so they are baked in the image
RUN python -c "from sentence_transformers import SentenceTransformer, CrossEncoder; \
    SentenceTransformer('BAAI/bge-m3'); CrossEncoder('BAAI/bge-reranker-v2-m3')"

COPY main.py .
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8001"]
```

- [ ] **Step 3: Write `main.py`**

```python
# gx10/services/embedding/main.py
from __future__ import annotations
from contextlib import asynccontextmanager
from typing import Any

from fastapi import FastAPI
from pydantic import BaseModel
from sentence_transformers import CrossEncoder, SentenceTransformer

_embed_model: SentenceTransformer | None = None
_rerank_model: CrossEncoder | None = None


@asynccontextmanager
async def lifespan(app: FastAPI):
    global _embed_model, _rerank_model
    _embed_model = SentenceTransformer("BAAI/bge-m3")
    _rerank_model = CrossEncoder("BAAI/bge-reranker-v2-m3")
    yield


app = FastAPI(lifespan=lifespan)


class EmbedRequest(BaseModel):
    texts: list[str]


class EmbedResponse(BaseModel):
    embeddings: list[list[float]]


class RerankRequest(BaseModel):
    query: str
    passages: list[str]


class RerankResponse(BaseModel):
    scores: list[float]


@app.post("/embed", response_model=EmbedResponse)
def embed(req: EmbedRequest) -> Any:
    assert _embed_model is not None
    vecs = _embed_model.encode(req.texts, normalize_embeddings=True)
    return {"embeddings": vecs.tolist()}


@app.post("/rerank", response_model=RerankResponse)
def rerank(req: RerankRequest) -> Any:
    assert _rerank_model is not None
    pairs = [[req.query, p] for p in req.passages]
    scores = _rerank_model.predict(pairs).tolist()
    return {"scores": scores}


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}
```

- [ ] **Step 4: Build and smoke-test**

```bash
cd gx10
docker compose build embedding
docker compose up embedding -d
sleep 10
curl -s -X POST http://localhost:8001/embed \
  -H "Content-Type: application/json" \
  -d '{"texts": ["hello world"]}' | python3 -c "import sys,json; d=json.load(sys.stdin); print('dims:', len(d['embeddings'][0]))"
```

Expected: `dims: 1024`

- [ ] **Step 5: Commit**

```bash
git add gx10/services/embedding/
git commit -m "feat(embedding): BGE-M3 embed + reranker microservice

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

---

## Task 3: FastAPI Scaffold (config, database, models, schemas, main)

**Files:**
- Create: `gx10/services/api/requirements.txt`
- Create: `gx10/services/api/Dockerfile`
- Create: `gx10/services/api/app/config.py`
- Create: `gx10/services/api/app/database.py`
- Create: `gx10/services/api/app/models.py`
- Create: `gx10/services/api/app/schemas.py`
- Create: `gx10/services/api/app/main.py`

- [ ] **Step 1: Write `requirements.txt`**

```
# gx10/services/api/requirements.txt
fastapi==0.111.0
uvicorn[standard]==0.29.0
sqlalchemy[asyncio]==2.0.30
asyncpg==0.29.0
pydantic-settings==2.2.1
celery[redis]==5.4.0
redis==5.0.4
langgraph==0.2.27
langchain-openai==0.1.8
httpx==0.27.0
trafilatura==1.9.0
pytest==8.2.0
pytest-asyncio==0.23.7
```

- [ ] **Step 2: Write `Dockerfile`**

```dockerfile
# gx10/services/api/Dockerfile
FROM python:3.11-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ app/
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
```

- [ ] **Step 3: Write `app/config.py`**

```python
# gx10/services/api/app/config.py
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    database_url: str = "postgresql+asyncpg://mindforge:changeme@localhost:5432/mindforge"
    redis_url: str = "redis://localhost:6379/0"
    embedding_url: str = "http://localhost:8001"
    llm_base_url: str = "http://localhost:8080/v1"
    llm_model: str = "qwen3-coder-next-fp8"
    brave_api_key: str = ""
    kal_max_rounds: int = 5

    model_config = SettingsConfigDict(env_file=".env", extra="ignore")


settings = Settings()
```

- [ ] **Step 4: Write `app/database.py`**

```python
# gx10/services/api/app/database.py
from collections.abc import AsyncGenerator

from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine

from app.config import settings

engine = create_async_engine(settings.database_url, echo=False)
AsyncSessionLocal = async_sessionmaker(engine, expire_on_commit=False)


async def get_db() -> AsyncGenerator[AsyncSession, None]:
    async with AsyncSessionLocal() as session:
        yield session
```

- [ ] **Step 5: Write `app/models.py`**

```python
# gx10/services/api/app/models.py
import uuid
from datetime import datetime

from pgvector.sqlalchemy import Vector
from sqlalchemy import Boolean, DateTime, Float, ForeignKey, Integer, String, Text
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
from sqlalchemy.sql import func


class Base(DeclarativeBase):
    pass


class TopicPack(Base):
    __tablename__ = "topic_packs"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    slug: Mapped[str] = mapped_column(String, unique=True, nullable=False)
    display_name: Mapped[str] = mapped_column(String, nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    claims: Mapped[list["Claim"]] = relationship("Claim", back_populates="pack")
    jobs: Mapped[list["KALJob"]] = relationship("KALJob", back_populates="pack")


class Source(Base):
    __tablename__ = "sources"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    url: Mapped[str] = mapped_column(Text, unique=True, nullable=False)
    title: Mapped[str | None] = mapped_column(Text)
    fetched_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    raw_text: Mapped[str | None] = mapped_column(Text)

    claims: Mapped[list["Claim"]] = relationship("Claim", back_populates="source")


class Claim(Base):
    __tablename__ = "claims"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    pack_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("topic_packs.id"), nullable=False)
    source_id: Mapped[uuid.UUID | None] = mapped_column(UUID(as_uuid=True), ForeignKey("sources.id"))
    content: Mapped[str] = mapped_column(Text, nullable=False)
    source_span: Mapped[str | None] = mapped_column(Text)
    confidence: Mapped[float] = mapped_column(Float, default=0.8)
    embedding: Mapped[list[float] | None] = mapped_column(Vector(1024))
    validated_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))
    fsrs_due: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    fsrs_stability: Mapped[float] = mapped_column(Float, default=1.0)
    human_edited: Mapped[bool] = mapped_column(Boolean, default=False)
    deleted_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())

    pack: Mapped["TopicPack"] = relationship("TopicPack", back_populates="claims")
    source: Mapped["Source | None"] = relationship("Source", back_populates="claims")


class KnowledgeEdge(Base):
    __tablename__ = "knowledge_edges"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    from_claim: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("claims.id"), nullable=False)
    to_claim: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("claims.id"), nullable=False)
    rel_type: Mapped[str] = mapped_column(String, default="supports")
    weight: Mapped[float] = mapped_column(Float, default=1.0)


class KALJob(Base):
    __tablename__ = "kal_jobs"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    source_url: Mapped[str] = mapped_column(Text, nullable=False)
    pack_id: Mapped[uuid.UUID | None] = mapped_column(UUID(as_uuid=True), ForeignKey("topic_packs.id"))
    status: Mapped[str] = mapped_column(String, default="queued")
    current_round: Mapped[int] = mapped_column(Integer, default=0)
    max_rounds: Mapped[int] = mapped_column(Integer, default=5)
    questions: Mapped[list] = mapped_column(JSONB, default=list)
    error_msg: Mapped[str | None] = mapped_column(Text)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())

    pack: Mapped["TopicPack | None"] = relationship("TopicPack", back_populates="jobs")
```

- [ ] **Step 6: Write `app/schemas.py`**

```python
# gx10/services/api/app/schemas.py
import uuid
from datetime import datetime

from pydantic import BaseModel, HttpUrl


class LearnRequest(BaseModel):
    url: str
    pack_slug: str
    max_rounds: int = 5


class LearnResponse(BaseModel):
    job_id: uuid.UUID
    status: str


class JobStatus(BaseModel):
    job_id: uuid.UUID
    status: str
    current_round: int
    max_rounds: int
    questions: list[str]
    error_msg: str | None = None


class ClaimOut(BaseModel):
    id: uuid.UUID
    content: str
    source_span: str | None
    confidence: float
    fsrs_due: datetime
    human_edited: bool

    class Config:
        from_attributes = True


class QueryRequest(BaseModel):
    query: str
    pack_slug: str | None = None
    top_k: int = 10


class QueryResponse(BaseModel):
    answer: str
    claims: list[ClaimOut]
    job_id: uuid.UUID | None = None
```

- [ ] **Step 7: Write `app/main.py`**

```python
# gx10/services/api/app/main.py
from contextlib import asynccontextmanager

from fastapi import FastAPI

from app.routes import learn, query


@asynccontextmanager
async def lifespan(app: FastAPI):
    yield


app = FastAPI(title="MindForge API", lifespan=lifespan)
app.include_router(learn.router, prefix="/learn", tags=["learn"])
app.include_router(query.router, prefix="/query", tags=["query"])


@app.get("/health")
async def health() -> dict[str, str]:
    return {"status": "ok"}
```

- [ ] **Step 8: Write failing test for schemas**

Create `gx10/services/api/tests/__init__.py` (empty).

```python
# gx10/services/api/tests/test_schemas.py
import uuid
from datetime import datetime, timezone

from app.schemas import ClaimOut, JobStatus, LearnRequest, LearnResponse


def test_learn_request_defaults():
    req = LearnRequest(url="https://example.com", pack_slug="physics")
    assert req.max_rounds == 5


def test_job_status_fields():
    job_id = uuid.uuid4()
    js = JobStatus(
        job_id=job_id,
        status="round-1",
        current_round=1,
        max_rounds=5,
        questions=["What is X?"],
    )
    assert js.error_msg is None


def test_claim_out_from_attributes():
    now = datetime.now(tz=timezone.utc)
    co = ClaimOut(
        id=uuid.uuid4(),
        content="Gravity attracts mass.",
        source_span="Para 3",
        confidence=0.9,
        fsrs_due=now,
        human_edited=False,
    )
    assert co.confidence == 0.9
```

- [ ] **Step 9: Run tests**

```bash
cd gx10/services/api
pip install -r requirements.txt
pytest tests/test_schemas.py -v
```

Expected:
```
PASSED tests/test_schemas.py::test_learn_request_defaults
PASSED tests/test_schemas.py::test_job_status_fields
PASSED tests/test_schemas.py::test_claim_out_from_attributes
3 passed
```

- [ ] **Step 10: Commit**

```bash
git add gx10/services/api/
git commit -m "feat(api): FastAPI scaffold — config, db, models, schemas, main

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

---

## Task 4: Celery + KAL Phase 1 Nodes (fetch + extract_claims)

**Files:**
- Create: `gx10/services/api/app/tasks.py`
- Create: `gx10/services/api/app/kal/__init__.py`
- Create: `gx10/services/api/app/kal/prompts.py`
- Create: `gx10/services/api/app/kal/nodes.py` (fetch + extract_claims only)

- [ ] **Step 1: Write `app/tasks.py`**

```python
# gx10/services/api/app/tasks.py
from celery import Celery

from app.config import settings

celery_app = Celery("mindforge", broker=settings.redis_url, backend=settings.redis_url)
celery_app.conf.task_serializer = "json"
celery_app.conf.result_serializer = "json"


@celery_app.task(name="run_kal_task")
def run_kal_task(job_id: str) -> None:
    import asyncio

    from app.kal.graph import run_kal_for_job

    asyncio.run(run_kal_for_job(job_id))
```

- [ ] **Step 2: Write `app/kal/prompts.py`**

```python
# gx10/services/api/app/kal/prompts.py

EXTRACT_CLAIMS_PROMPT = """\
You are a knowledge extraction engine. Given the following article text, extract a list of
self-contained, atomic factual claims. Each claim must:
- Be a single sentence stating one fact
- Be fully understandable without reading the article
- Not be an opinion, question, or instruction

Return ONLY a JSON array of strings. No explanation, no markdown.

Article:
{text}
"""

SELF_QUESTION_PROMPT = """\
You are a Socratic knowledge auditor. Given the following claims about a topic, generate
exactly 3 follow-up questions whose answers would significantly deepen understanding.
Each question must be specific and answerable by a search engine.

Return ONLY a JSON array of 3 question strings.

Claims:
{claims_text}
"""

COVERAGE_CHECK_PROMPT = """\
Given the following question and the existing claims, decide if the claims already answer
the question sufficiently (score 0.0–1.0, where 1.0 = fully answered).

Return ONLY a JSON object: {{"score": 0.0, "reasoning": "..."}}

Question: {question}

Claims:
{claims_text}
"""

CROSS_VALIDATE_PROMPT = """\
You are a fact-checker. Given a new claim and the existing body of claims, decide if the
new claim is: "confirmed", "contradicted", or "unverified".

Return ONLY a JSON object: {{"verdict": "confirmed|contradicted|unverified", "reason": "..."}}

New claim: {new_claim}

Existing claims:
{existing_claims}
"""
```

- [ ] **Step 3: Write `app/kal/nodes.py` (fetch + extract_claims)**

```python
# gx10/services/api/app/kal/nodes.py
from __future__ import annotations

import json
import logging
import uuid
from typing import Any

import httpx
import trafilatura
from langchain_openai import ChatOpenAI
from sqlalchemy import select, update
from sqlalchemy.ext.asyncio import AsyncSession

from app.config import settings
from app.kal.prompts import (
    COVERAGE_CHECK_PROMPT,
    CROSS_VALIDATE_PROMPT,
    EXTRACT_CLAIMS_PROMPT,
    SELF_QUESTION_PROMPT,
)
from app.models import Claim, KALJob, Source, TopicPack

log = logging.getLogger(__name__)


def _llm() -> ChatOpenAI:
    return ChatOpenAI(
        base_url=settings.llm_base_url,
        api_key="not-used",
        model=settings.llm_model,
        temperature=0.0,
    )


async def _embed_texts(texts: list[str]) -> list[list[float]]:
    async with httpx.AsyncClient(timeout=60) as client:
        resp = await client.post(f"{settings.embedding_url}/embed", json={"texts": texts})
        resp.raise_for_status()
        return resp.json()["embeddings"]


async def fetch_node(state: dict[str, Any], db: AsyncSession) -> dict[str, Any]:
    """Download and clean article text from source_url."""
    job_id = state["job_id"]
    result = await db.execute(select(KALJob).where(KALJob.id == uuid.UUID(job_id)))
    job = result.scalar_one()

    # Check if source already exists
    result = await db.execute(select(Source).where(Source.url == job.source_url))
    source = result.scalar_one_or_none()

    if source is None or source.raw_text is None:
        async with httpx.AsyncClient(timeout=30) as client:
            resp = await client.get(job.source_url, follow_redirects=True)
            resp.raise_for_status()
            html = resp.text

        raw_text = trafilatura.extract(html, include_comments=False, include_tables=False) or ""
        title = trafilatura.extract_metadata(html)
        title_str = title.title if title and title.title else job.source_url

        if source is None:
            source = Source(url=job.source_url, title=title_str, raw_text=raw_text)
            db.add(source)
        else:
            source.raw_text = raw_text
            source.title = title_str
        await db.commit()
        await db.refresh(source)

    return {**state, "source_id": str(source.id), "raw_text": source.raw_text or ""}


async def extract_claims_node(state: dict[str, Any], db: AsyncSession) -> dict[str, Any]:
    """Ask LLM to extract atomic claims; embed and persist them."""
    job_id = state["job_id"]
    raw_text = state.get("raw_text", "")

    if not raw_text:
        return {**state, "new_claim_ids": []}

    prompt = EXTRACT_CLAIMS_PROMPT.format(text=raw_text[:12000])
    llm = _llm()
    response = llm.invoke(prompt)
    try:
        claims_text: list[str] = json.loads(response.content)
    except (json.JSONDecodeError, TypeError):
        log.warning("LLM returned non-JSON from extract_claims: %s", response.content[:200])
        claims_text = []

    if not claims_text:
        return {**state, "new_claim_ids": []}

    # Get pack
    result = await db.execute(select(KALJob).where(KALJob.id == uuid.UUID(job_id)))
    job = result.scalar_one()
    pack_id = job.pack_id

    # Embed all claims in one batch call
    embeddings = await _embed_texts(claims_text)

    new_ids: list[str] = []
    for text, emb in zip(claims_text, embeddings, strict=True):
        claim = Claim(
            pack_id=pack_id,
            source_id=uuid.UUID(state["source_id"]) if state.get("source_id") else None,
            content=text,
            embedding=emb,
            confidence=0.8,
        )
        db.add(claim)
        await db.flush()
        new_ids.append(str(claim.id))

    # Update job status
    await db.execute(
        update(KALJob)
        .where(KALJob.id == uuid.UUID(job_id))
        .values(status="extracted", current_round=0)
    )
    await db.commit()

    return {**state, "new_claim_ids": new_ids}
```

- [ ] **Step 4: Write failing test for fetch_node**

```python
# gx10/services/api/tests/test_kal_nodes.py
import uuid
from unittest.mock import AsyncMock, MagicMock, patch

import pytest

from app.kal.nodes import extract_claims_node, fetch_node


@pytest.mark.asyncio
async def test_fetch_node_creates_source():
    fake_html = "<html><body><article>Black holes warp spacetime.</article></body></html>"
    job_id = str(uuid.uuid4())
    pack_id = uuid.uuid4()

    mock_job = MagicMock()
    mock_job.source_url = "https://example.com/article"
    mock_job.pack_id = pack_id

    mock_db = AsyncMock()
    mock_db.execute.return_value.scalar_one.return_value = mock_job
    mock_db.execute.return_value.scalar_one_or_none.return_value = None

    with patch("httpx.AsyncClient") as mock_client_cls:
        mock_resp = AsyncMock()
        mock_resp.text = fake_html
        mock_resp.raise_for_status = MagicMock()
        mock_client_cls.return_value.__aenter__.return_value.get = AsyncMock(return_value=mock_resp)

        result = await fetch_node({"job_id": job_id}, mock_db)

    assert "raw_text" in result
    assert "source_id" in result


@pytest.mark.asyncio
async def test_extract_claims_node_persists_claims():
    job_id = str(uuid.uuid4())
    pack_id = uuid.uuid4()
    source_id = str(uuid.uuid4())

    mock_job = MagicMock()
    mock_job.pack_id = pack_id

    mock_db = AsyncMock()
    mock_db.execute.return_value.scalar_one.return_value = mock_job

    fake_claims = ["Black holes warp spacetime.", "Neutron stars are extremely dense."]
    fake_embeddings = [[0.1] * 1024, [0.2] * 1024]

    mock_llm_response = MagicMock()
    mock_llm_response.content = '["Black holes warp spacetime.", "Neutron stars are extremely dense."]'

    with patch("app.kal.nodes._llm") as mock_llm_factory, \
         patch("app.kal.nodes._embed_texts", new_callable=AsyncMock) as mock_embed:
        mock_llm = MagicMock()
        mock_llm.invoke.return_value = mock_llm_response
        mock_llm_factory.return_value = mock_llm
        mock_embed.return_value = fake_embeddings

        result = await extract_claims_node(
            {"job_id": job_id, "source_id": source_id, "raw_text": "Some article text."},
            mock_db,
        )

    assert len(result["new_claim_ids"]) == 2
```

- [ ] **Step 5: Run tests**

```bash
cd gx10/services/api
pytest tests/test_kal_nodes.py -v
```

Expected:
```
PASSED tests/test_kal_nodes.py::test_fetch_node_creates_source
PASSED tests/test_kal_nodes.py::test_extract_claims_node_persists_claims
2 passed
```

- [ ] **Step 6: Commit**

```bash
git add gx10/services/api/app/tasks.py gx10/services/api/app/kal/ gx10/services/api/tests/test_kal_nodes.py
git commit -m "feat(kal): Celery task + fetch_node + extract_claims_node

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

---

## Task 5: /learn Routes

**Files:**
- Create: `gx10/services/api/app/routes/__init__.py`
- Create: `gx10/services/api/app/routes/learn.py`

- [ ] **Step 1: Write `app/routes/learn.py`**

```python
# gx10/services/api/app/routes/learn.py
import uuid
from typing import Any

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.database import get_db
from app.models import Claim, KALJob, TopicPack
from app.schemas import ClaimOut, JobStatus, LearnRequest, LearnResponse
from app.tasks import run_kal_task

router = APIRouter()


async def _get_or_create_pack(slug: str, db: AsyncSession) -> TopicPack:
    result = await db.execute(select(TopicPack).where(TopicPack.slug == slug))
    pack = result.scalar_one_or_none()
    if pack is None:
        pack = TopicPack(slug=slug, display_name=slug.replace("-", " ").title())
        db.add(pack)
        await db.commit()
        await db.refresh(pack)
    return pack


@router.post("", response_model=LearnResponse)
async def post_learn(req: LearnRequest, db: AsyncSession = Depends(get_db)) -> Any:
    pack = await _get_or_create_pack(req.pack_slug, db)
    job = KALJob(
        source_url=req.url,
        pack_id=pack.id,
        max_rounds=req.max_rounds,
        status="queued",
    )
    db.add(job)
    await db.commit()
    await db.refresh(job)
    run_kal_task.delay(str(job.id))
    return LearnResponse(job_id=job.id, status="queued")


@router.get("/{job_id}/status", response_model=JobStatus)
async def get_status(job_id: uuid.UUID, db: AsyncSession = Depends(get_db)) -> Any:
    result = await db.execute(select(KALJob).where(KALJob.id == job_id))
    job = result.scalar_one_or_none()
    if job is None:
        raise HTTPException(status_code=404, detail="Job not found")
    return JobStatus(
        job_id=job.id,
        status=job.status,
        current_round=job.current_round,
        max_rounds=job.max_rounds,
        questions=job.questions or [],
        error_msg=job.error_msg,
    )


@router.get("/{job_id}/claims", response_model=list[ClaimOut])
async def get_claims(job_id: uuid.UUID, db: AsyncSession = Depends(get_db)) -> Any:
    result = await db.execute(select(KALJob).where(KALJob.id == job_id))
    job = result.scalar_one_or_none()
    if job is None:
        raise HTTPException(status_code=404, detail="Job not found")

    result = await db.execute(
        select(Claim)
        .where(Claim.pack_id == job.pack_id, Claim.deleted_at.is_(None))
        .order_by(Claim.created_at)
    )
    claims = result.scalars().all()
    return claims
```

- [ ] **Step 2: Write failing integration test**

```python
# gx10/services/api/tests/test_routes.py
import uuid
from unittest.mock import AsyncMock, patch

import pytest
from fastapi.testclient import TestClient
from sqlalchemy.ext.asyncio import AsyncSession

from app.main import app
from app.models import KALJob, TopicPack


def test_post_learn_returns_job_id():
    mock_pack = TopicPack(id=uuid.uuid4(), slug="physics", display_name="Physics")
    mock_job = KALJob(id=uuid.uuid4(), source_url="https://example.com", pack_id=mock_pack.id, status="queued")

    async def override_get_db():
        mock_db = AsyncMock(spec=AsyncSession)
        mock_db.execute.return_value.scalar_one_or_none.side_effect = [mock_pack, None]
        mock_db.execute.return_value.scalar_one.return_value = mock_job
        yield mock_db

    with patch("app.routes.learn.run_kal_task") as mock_task:
        mock_task.delay = lambda *a, **kw: None
        app.dependency_overrides[__import__("app.database", fromlist=["get_db"]).get_db] = override_get_db
        client = TestClient(app)
        resp = client.post("/learn", json={"url": "https://example.com", "pack_slug": "physics"})

    app.dependency_overrides.clear()
    assert resp.status_code == 200
    data = resp.json()
    assert "job_id" in data
    assert data["status"] == "queued"


def test_get_status_404_for_missing_job():
    async def override_get_db():
        mock_db = AsyncMock(spec=AsyncSession)
        mock_db.execute.return_value.scalar_one_or_none.return_value = None
        yield mock_db

    app.dependency_overrides[__import__("app.database", fromlist=["get_db"]).get_db] = override_get_db
    client = TestClient(app)
    resp = client.get(f"/learn/{uuid.uuid4()}/status")
    app.dependency_overrides.clear()
    assert resp.status_code == 404
```

- [ ] **Step 3: Run tests**

```bash
cd gx10/services/api
pytest tests/test_routes.py -v
```

Expected:
```
PASSED tests/test_routes.py::test_post_learn_returns_job_id
PASSED tests/test_routes.py::test_get_status_404_for_missing_job
2 passed
```

- [ ] **Step 4: Commit**

```bash
git add gx10/services/api/app/routes/
git commit -m "feat(routes): POST /learn, GET /learn/{id}/status, GET /learn/{id}/claims

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

---

## Task 6: KAL Phase 2 Nodes (self_question + coverage_check + search_expand + cross_validate)

**Files:**
- Modify: `gx10/services/api/app/kal/nodes.py` — add 4 new nodes

- [ ] **Step 1: Add `self_question_node` to `nodes.py`**

Append to the bottom of `nodes.py`:

```python
async def self_question_node(state: dict[str, Any], db: AsyncSession) -> dict[str, Any]:
    """Generate 3 follow-up questions from existing claims."""
    job_id = state["job_id"]
    result = await db.execute(select(KALJob).where(KALJob.id == uuid.UUID(job_id)))
    job = result.scalar_one()

    result = await db.execute(
        select(Claim).where(Claim.pack_id == job.pack_id, Claim.deleted_at.is_(None))
    )
    claims = result.scalars().all()
    claims_text = "\n".join(f"- {c.content}" for c in claims[:50])

    prompt = SELF_QUESTION_PROMPT.format(claims_text=claims_text)
    llm = _llm()
    response = llm.invoke(prompt)
    try:
        questions: list[str] = json.loads(response.content)[:3]
    except (json.JSONDecodeError, TypeError):
        questions = []

    new_round = job.current_round + 1
    await db.execute(
        update(KALJob)
        .where(KALJob.id == uuid.UUID(job_id))
        .values(status=f"round-{new_round}", current_round=new_round, questions=questions)
    )
    await db.commit()

    return {**state, "questions": questions, "current_round": new_round}
```

- [ ] **Step 2: Add `coverage_check_node` to `nodes.py`**

```python
async def coverage_check_node(state: dict[str, Any], db: AsyncSession) -> dict[str, Any]:
    """For each open question, score how well existing claims answer it (0-1)."""
    job_id = state["job_id"]
    questions: list[str] = state.get("questions", [])

    if not questions:
        return {**state, "uncovered_questions": []}

    result = await db.execute(select(KALJob).where(KALJob.id == uuid.UUID(job_id)))
    job = result.scalar_one()
    result = await db.execute(
        select(Claim).where(Claim.pack_id == job.pack_id, Claim.deleted_at.is_(None))
    )
    claims = result.scalars().all()
    claims_text = "\n".join(f"- {c.content}" for c in claims[:50])

    llm = _llm()
    uncovered: list[str] = []
    for question in questions:
        prompt = COVERAGE_CHECK_PROMPT.format(question=question, claims_text=claims_text)
        response = llm.invoke(prompt)
        try:
            result_json = json.loads(response.content)
            score = float(result_json.get("score", 0))
        except (json.JSONDecodeError, TypeError, KeyError):
            score = 0.0
        if score < 0.7:
            uncovered.append(question)

    return {**state, "uncovered_questions": uncovered}
```

- [ ] **Step 3: Add `search_expand_node` to `nodes.py`**

```python
async def search_expand_node(state: dict[str, Any], db: AsyncSession) -> dict[str, Any]:
    """Search Brave for uncovered questions; fetch top result and extract new claims."""
    uncovered: list[str] = state.get("uncovered_questions", [])
    if not uncovered or not settings.brave_api_key:
        return {**state, "search_claim_ids": []}

    result = await db.execute(select(KALJob).where(KALJob.id == uuid.UUID(state["job_id"])))
    job = result.scalar_one()

    new_ids: list[str] = []
    async with httpx.AsyncClient(timeout=15) as client:
        for question in uncovered[:3]:
            resp = await client.get(
                "https://api.search.brave.com/res/v1/web/search",
                headers={"Accept": "application/json", "X-Subscription-Token": settings.brave_api_key},
                params={"q": question, "count": 3},
            )
            if resp.status_code != 200:
                continue

            hits = resp.json().get("web", {}).get("results", [])
            for hit in hits[:1]:
                url = hit.get("url", "")
                if not url:
                    continue
                try:
                    page_resp = await client.get(url, follow_redirects=True)
                    raw_text = trafilatura.extract(page_resp.text) or ""
                except Exception:
                    continue

                if len(raw_text) < 200:
                    continue

                llm = _llm()
                prompt = EXTRACT_CLAIMS_PROMPT.format(text=raw_text[:8000])
                llm_resp = llm.invoke(prompt)
                try:
                    new_claims: list[str] = json.loads(llm_resp.content)
                except (json.JSONDecodeError, TypeError):
                    continue

                if not new_claims:
                    continue

                # Upsert source
                src_result = await db.execute(select(Source).where(Source.url == url))
                source = src_result.scalar_one_or_none()
                if source is None:
                    source = Source(url=url, raw_text=raw_text)
                    db.add(source)
                    await db.flush()

                embeddings = await _embed_texts(new_claims)
                for text, emb in zip(new_claims, embeddings, strict=True):
                    claim = Claim(
                        pack_id=job.pack_id,
                        source_id=source.id,
                        content=text,
                        embedding=emb,
                        confidence=0.75,
                    )
                    db.add(claim)
                    await db.flush()
                    new_ids.append(str(claim.id))

    await db.commit()
    return {**state, "search_claim_ids": new_ids}
```

- [ ] **Step 4: Add `cross_validate_node` to `nodes.py`**

```python
async def cross_validate_node(state: dict[str, Any], db: AsyncSession) -> dict[str, Any]:
    """LLM cross-check new claims against existing body; mark contradicted claims."""
    new_ids: list[str] = state.get("search_claim_ids", []) + state.get("new_claim_ids", [])
    if not new_ids:
        return state

    result = await db.execute(select(KALJob).where(KALJob.id == uuid.UUID(state["job_id"])))
    job = result.scalar_one()

    # Existing validated claims as reference corpus
    result = await db.execute(
        select(Claim)
        .where(
            Claim.pack_id == job.pack_id,
            Claim.id.notin_([uuid.UUID(i) for i in new_ids]),
            Claim.deleted_at.is_(None),
        )
        .limit(30)
    )
    existing_claims = result.scalars().all()
    existing_text = "\n".join(f"- {c.content}" for c in existing_claims)

    if not existing_text:
        return state

    llm = _llm()
    for claim_id in new_ids[:10]:  # cap to avoid excessive LLM calls
        result = await db.execute(select(Claim).where(Claim.id == uuid.UUID(claim_id)))
        claim = result.scalar_one_or_none()
        if claim is None or claim.human_edited:
            continue

        prompt = CROSS_VALIDATE_PROMPT.format(
            new_claim=claim.content, existing_claims=existing_text
        )
        resp = llm.invoke(prompt)
        try:
            verdict_json = json.loads(resp.content)
            verdict = verdict_json.get("verdict", "unverified")
        except (json.JSONDecodeError, TypeError):
            verdict = "unverified"

        if verdict == "contradicted":
            claim.confidence = max(0.0, claim.confidence - 0.3)
        elif verdict == "confirmed":
            claim.confidence = min(1.0, claim.confidence + 0.1)

        from datetime import datetime, timezone
        claim.validated_at = datetime.now(tz=timezone.utc)

    await db.commit()
    return state


async def index_node(state: dict[str, Any], db: AsyncSession) -> dict[str, Any]:
    """Mark job done."""
    job_id = state["job_id"]
    await db.execute(
        update(KALJob).where(KALJob.id == uuid.UUID(job_id)).values(status="done")
    )
    await db.commit()
    return {**state, "status": "done"}
```

- [ ] **Step 5: Run all kal node tests**

```bash
cd gx10/services/api
pytest tests/test_kal_nodes.py -v
```

Expected: `2 passed` (new nodes tested in next task)

- [ ] **Step 6: Commit**

```bash
git add gx10/services/api/app/kal/nodes.py
git commit -m "feat(kal): add self_question, coverage_check, search_expand, cross_validate, index nodes

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

---

## Task 7: LangGraph KAL Graph Assembly

**Files:**
- Create: `gx10/services/api/app/kal/graph.py`

- [ ] **Step 1: Write `app/kal/graph.py`**

```python
# gx10/services/api/app/kal/graph.py
from __future__ import annotations

import uuid
from typing import TypedDict, Any

from langgraph.graph import END, StateGraph
from sqlalchemy import select

from app.config import settings
from app.database import AsyncSessionLocal
from app.kal.nodes import (
    cross_validate_node,
    extract_claims_node,
    fetch_node,
    index_node,
    search_expand_node,
    self_question_node,
    coverage_check_node,
)
from app.models import KALJob


class KALState(TypedDict):
    job_id: str
    source_id: str
    raw_text: str
    new_claim_ids: list[str]
    questions: list[str]
    uncovered_questions: list[str]
    search_claim_ids: list[str]
    current_round: int
    status: str


def _should_loop(state: KALState) -> str:
    """Decide whether to do another self-question round or finish."""
    uncovered = state.get("uncovered_questions", [])
    current_round = state.get("current_round", 0)
    max_rounds = 5  # read from job at runtime; default here is fine

    if uncovered and current_round < max_rounds:
        return "search"
    return "done"


def build_kal_graph() -> StateGraph:
    graph = StateGraph(KALState)

    # Register nodes (each node signature is (state, db) — wrapped below)
    graph.add_node("fetch", _wrap(fetch_node))
    graph.add_node("extract", _wrap(extract_claims_node))
    graph.add_node("self_question", _wrap(self_question_node))
    graph.add_node("coverage_check", _wrap(coverage_check_node))
    graph.add_node("search_expand", _wrap(search_expand_node))
    graph.add_node("cross_validate", _wrap(cross_validate_node))
    graph.add_node("index", _wrap(index_node))

    graph.set_entry_point("fetch")
    graph.add_edge("fetch", "extract")
    graph.add_edge("extract", "self_question")
    graph.add_edge("self_question", "coverage_check")
    graph.add_conditional_edges(
        "coverage_check",
        _should_loop,
        {"search": "search_expand", "done": "index"},
    )
    graph.add_edge("search_expand", "cross_validate")
    graph.add_edge("cross_validate", "self_question")
    graph.add_edge("index", END)

    return graph.compile()


def _wrap(node_fn):
    """Wrap async node functions to inject an AsyncSession from the pool."""
    async def wrapped(state: KALState) -> KALState:
        async with AsyncSessionLocal() as db:
            return await node_fn(state, db)
    return wrapped


async def run_kal_for_job(job_id: str) -> None:
    """Entry point called by Celery task."""
    import asyncio
    from sqlalchemy import update

    async with AsyncSessionLocal() as db:
        result = await db.execute(select(KALJob).where(KALJob.id == uuid.UUID(job_id)))
        job = result.scalar_one_or_none()
        if job is None:
            return

        max_rounds = job.max_rounds

    graph = build_kal_graph()
    initial_state: KALState = {
        "job_id": job_id,
        "source_id": "",
        "raw_text": "",
        "new_claim_ids": [],
        "questions": [],
        "uncovered_questions": [],
        "search_claim_ids": [],
        "current_round": 0,
        "status": "queued",
    }

    try:
        await graph.ainvoke(initial_state)
    except Exception as exc:
        async with AsyncSessionLocal() as db:
            from sqlalchemy import update
            await db.execute(
                update(KALJob)
                .where(KALJob.id == uuid.UUID(job_id))
                .values(status="failed", error_msg=str(exc))
            )
            await db.commit()
        raise
```

- [ ] **Step 2: Smoke test graph compiles**

```bash
cd gx10/services/api
python -c "from app.kal.graph import build_kal_graph; g = build_kal_graph(); print('nodes:', list(g.nodes))"
```

Expected:
```
nodes: ['fetch', 'extract', 'self_question', 'coverage_check', 'search_expand', 'cross_validate', 'index', '__start__']
```

- [ ] **Step 3: Commit**

```bash
git add gx10/services/api/app/kal/graph.py
git commit -m "feat(kal): LangGraph KAL graph wiring — self-question loop + conditional routing

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

---

## Task 8: HFQ Retrieval Pipeline + POST /query

**Files:**
- Create: `gx10/services/api/app/retrieval/__init__.py`
- Create: `gx10/services/api/app/retrieval/pipeline.py`
- Create: `gx10/services/api/app/routes/query.py`

- [ ] **Step 1: Write `retrieval/pipeline.py`**

```python
# gx10/services/api/app/retrieval/pipeline.py
from __future__ import annotations

import uuid
from typing import Any

import httpx
from sqlalchemy import func, select, text
from sqlalchemy.ext.asyncio import AsyncSession

from app.config import settings
from app.models import Claim, KnowledgeEdge, TopicPack


async def _get_query_embedding(query: str) -> list[float]:
    async with httpx.AsyncClient(timeout=30) as client:
        resp = await client.post(
            f"{settings.embedding_url}/embed",
            json={"texts": [query]},
        )
        resp.raise_for_status()
        return resp.json()["embeddings"][0]


async def _rerank(query: str, claims: list[Claim]) -> list[Claim]:
    if len(claims) <= 1:
        return claims
    passages = [c.content for c in claims]
    async with httpx.AsyncClient(timeout=30) as client:
        resp = await client.post(
            f"{settings.embedding_url}/rerank",
            json={"query": query, "passages": passages},
        )
        resp.raise_for_status()
        scores = resp.json()["scores"]

    scored = sorted(zip(claims, scores, strict=True), key=lambda x: x[1], reverse=True)
    return [c for c, _ in scored]


async def run_hfq_pipeline(
    query: str,
    db: AsyncSession,
    pack_slug: str | None = None,
    top_k: int = 10,
) -> list[Claim]:
    """
    5-step HFQ retrieval:
    1. Pack routing (optional slug filter)
    2. Dense + sparse hybrid search
    3. BGE reranker
    4. 2-hop graph expansion
    5. Deduplicate + return top_k
    """
    # Step 1: Pack routing
    pack_filter = None
    if pack_slug:
        result = await db.execute(select(TopicPack).where(TopicPack.slug == pack_slug))
        pack = result.scalar_one_or_none()
        if pack:
            pack_filter = pack.id

    # Step 2a: Dense similarity search (HNSW)
    query_emb = await _get_query_embedding(query)
    emb_literal = "[" + ",".join(str(x) for x in query_emb) + "]"

    dense_q = (
        select(Claim)
        .where(Claim.deleted_at.is_(None), Claim.embedding.is_not(None))
        .order_by(text(f"embedding <=> '{emb_literal}'::vector"))
        .limit(top_k * 2)
    )
    if pack_filter:
        dense_q = dense_q.where(Claim.pack_id == pack_filter)

    dense_result = await db.execute(dense_q)
    dense_claims = list(dense_result.scalars().all())

    # Step 2b: Sparse trigram search
    sparse_q = (
        select(Claim)
        .where(Claim.deleted_at.is_(None), func.similarity(Claim.content, query) > 0.1)
        .order_by(func.similarity(Claim.content, query).desc())
        .limit(top_k)
    )
    if pack_filter:
        sparse_q = sparse_q.where(Claim.pack_id == pack_filter)

    sparse_result = await db.execute(sparse_q)
    sparse_claims = list(sparse_result.scalars().all())

    # Merge and deduplicate by id
    seen: set[uuid.UUID] = set()
    merged: list[Claim] = []
    for c in dense_claims + sparse_claims:
        if c.id not in seen:
            seen.add(c.id)
            merged.append(c)

    # Step 3: Rerank
    reranked = await _rerank(query, merged[: top_k * 3])

    # Step 4: 2-hop graph expansion
    seed_ids = {c.id for c in reranked[:top_k]}
    hop1_result = await db.execute(
        select(Claim)
        .join(KnowledgeEdge, KnowledgeEdge.to_claim == Claim.id)
        .where(KnowledgeEdge.from_claim.in_(seed_ids), Claim.deleted_at.is_(None))
        .limit(top_k)
    )
    hop1 = list(hop1_result.scalars().all())

    for c in hop1:
        if c.id not in seen:
            seen.add(c.id)
            reranked.append(c)

    # Step 5: Deduplicate + trim
    return reranked[:top_k]
```

- [ ] **Step 2: Write `routes/query.py`**

```python
# gx10/services/api/app/routes/query.py
from typing import Any

from fastapi import APIRouter, Depends
from langchain_openai import ChatOpenAI
from sqlalchemy.ext.asyncio import AsyncSession

from app.config import settings
from app.database import get_db
from app.retrieval.pipeline import run_hfq_pipeline
from app.schemas import ClaimOut, QueryRequest, QueryResponse

router = APIRouter()

ANSWER_PROMPT = """\
You are a precise knowledge assistant. Using ONLY the provided claims, answer the question.
If the claims don't contain enough information, say so.

Question: {question}

Claims:
{claims}

Answer (cite claim numbers in brackets):
"""


@router.post("", response_model=QueryResponse)
async def post_query(req: QueryRequest, db: AsyncSession = Depends(get_db)) -> Any:
    claims = await run_hfq_pipeline(req.query, db, pack_slug=req.pack_slug, top_k=req.top_k)

    if not claims:
        return QueryResponse(answer="No relevant claims found.", claims=[])

    claims_text = "\n".join(f"[{i+1}] {c.content}" for i, c in enumerate(claims))
    prompt = ANSWER_PROMPT.format(question=req.query, claims=claims_text)

    llm = ChatOpenAI(
        base_url=settings.llm_base_url,
        api_key="not-used",
        model=settings.llm_model,
        temperature=0.0,
    )
    response = llm.invoke(prompt)
    answer = response.content

    return QueryResponse(
        answer=answer,
        claims=[ClaimOut.model_validate(c) for c in claims],
    )
```

- [ ] **Step 3: Write failing retrieval test**

```python
# gx10/services/api/tests/test_retrieval.py
import uuid
from datetime import datetime, timezone
from unittest.mock import AsyncMock, MagicMock, patch

import pytest

from app.models import Claim
from app.retrieval.pipeline import run_hfq_pipeline


@pytest.mark.asyncio
async def test_hfq_returns_empty_list_on_no_results():
    mock_db = AsyncMock()
    mock_db.execute.return_value.scalars.return_value.all.return_value = []
    mock_db.execute.return_value.scalar_one_or_none.return_value = None

    with patch("app.retrieval.pipeline._get_query_embedding", new_callable=AsyncMock) as mock_emb, \
         patch("app.retrieval.pipeline._rerank", new_callable=AsyncMock) as mock_rerank:
        mock_emb.return_value = [0.1] * 1024
        mock_rerank.return_value = []

        result = await run_hfq_pipeline("What is a black hole?", mock_db)

    assert result == []


@pytest.mark.asyncio
async def test_hfq_deduplicates_dense_and_sparse():
    now = datetime.now(tz=timezone.utc)
    claim_id = uuid.uuid4()
    pack_id = uuid.uuid4()
    fake_claim = Claim(
        id=claim_id,
        pack_id=pack_id,
        content="Black holes warp spacetime.",
        confidence=0.9,
        fsrs_due=now,
        human_edited=False,
    )

    call_count = 0

    async def fake_execute(query):
        nonlocal call_count
        call_count += 1
        mock_result = MagicMock()
        mock_result.scalars.return_value.all.return_value = [fake_claim]
        mock_result.scalar_one_or_none.return_value = None
        return mock_result

    mock_db = AsyncMock()
    mock_db.execute.side_effect = fake_execute

    with patch("app.retrieval.pipeline._get_query_embedding", new_callable=AsyncMock) as mock_emb, \
         patch("app.retrieval.pipeline._rerank", new_callable=AsyncMock) as mock_rerank:
        mock_emb.return_value = [0.1] * 1024
        mock_rerank.return_value = [fake_claim]

        result = await run_hfq_pipeline("black holes", mock_db, top_k=5)

    # Should only appear once despite being in both dense and sparse results
    assert len([c for c in result if c.id == claim_id]) == 1
```

- [ ] **Step 4: Run retrieval tests**

```bash
cd gx10/services/api
pytest tests/test_retrieval.py -v
```

Expected:
```
PASSED tests/test_retrieval.py::test_hfq_returns_empty_list_on_no_results
PASSED tests/test_retrieval.py::test_hfq_deduplicates_dense_and_sparse
2 passed
```

- [ ] **Step 5: Commit**

```bash
git add gx10/services/api/app/retrieval/ gx10/services/api/app/routes/query.py gx10/services/api/tests/test_retrieval.py
git commit -m "feat(retrieval): HFQ 5-step pipeline + POST /query endpoint

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

---

## Task 9: vault-bridge Config, Client, Inbox Parser

**Files:**
- Create: `vault-bridge/requirements.txt`
- Create: `vault-bridge/config.py`
- Create: `vault-bridge/client.py`
- Create: `vault-bridge/inbox.py`
- Create: `vault-bridge/tests/__init__.py`
- Create: `vault-bridge/tests/test_inbox.py`

- [ ] **Step 1: Write `requirements.txt`**

```
# vault-bridge/requirements.txt
watchdog==4.0.1
httpx==0.27.0
python-frontmatter==1.1.0
pydantic-settings==2.2.1
pytest==8.2.0
pytest-asyncio==0.23.7
```

- [ ] **Step 2: Write `config.py`**

```python
# vault-bridge/config.py
from pathlib import Path

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    vault_path: Path = Path.home() / "Documents" / "Obsidian" / "MindForge"
    gx10_url: str = "http://gx10.local:8000"
    poll_interval: float = 5.0
    max_retries: int = 3

    model_config = SettingsConfigDict(env_file=".env", extra="ignore")


settings = Settings()
```

- [ ] **Step 3: Write `client.py`**

```python
# vault-bridge/client.py
from __future__ import annotations

import uuid
from dataclasses import dataclass, field

import httpx

from config import settings


@dataclass
class JobStatus:
    job_id: str
    status: str
    current_round: int
    max_rounds: int
    questions: list[str] = field(default_factory=list)
    error_msg: str | None = None


@dataclass
class ClaimData:
    id: str
    content: str
    source_span: str | None
    confidence: float
    fsrs_due: str
    human_edited: bool


class MindForgeClient:
    def __init__(self, base_url: str | None = None) -> None:
        self._base = base_url or settings.gx10_url

    def post_learn(self, url: str, pack_slug: str, max_rounds: int = 5) -> str:
        """Submit a URL for KAL processing. Returns job_id."""
        with httpx.Client(timeout=15) as client:
            resp = client.post(
                f"{self._base}/learn",
                json={"url": url, "pack_slug": pack_slug, "max_rounds": max_rounds},
            )
            resp.raise_for_status()
            return resp.json()["job_id"]

    def get_status(self, job_id: str) -> JobStatus:
        with httpx.Client(timeout=10) as client:
            resp = client.get(f"{self._base}/learn/{job_id}/status")
            resp.raise_for_status()
            data = resp.json()
            return JobStatus(
                job_id=data["job_id"],
                status=data["status"],
                current_round=data["current_round"],
                max_rounds=data["max_rounds"],
                questions=data.get("questions", []),
                error_msg=data.get("error_msg"),
            )

    def get_claims(self, job_id: str) -> list[ClaimData]:
        with httpx.Client(timeout=15) as client:
            resp = client.get(f"{self._base}/learn/{job_id}/claims")
            resp.raise_for_status()
            return [
                ClaimData(
                    id=c["id"],
                    content=c["content"],
                    source_span=c.get("source_span"),
                    confidence=c["confidence"],
                    fsrs_due=c["fsrs_due"],
                    human_edited=c["human_edited"],
                )
                for c in resp.json()
            ]

    def post_query(self, query: str, pack_slug: str | None = None, top_k: int = 10) -> dict:
        with httpx.Client(timeout=30) as client:
            resp = client.post(
                f"{self._base}/query",
                json={"query": query, "pack_slug": pack_slug, "top_k": top_k},
            )
            resp.raise_for_status()
            return resp.json()
```

- [ ] **Step 4: Write `inbox.py`**

```python
# vault-bridge/inbox.py
from __future__ import annotations

import re
from dataclasses import dataclass
from pathlib import Path

import frontmatter

# URL regex — matches http(s) URLs
_URL_RE = re.compile(r"https?://[^\s\"'<>]+", re.IGNORECASE)


@dataclass
class LearnIntent:
    url: str
    pack_slug: str
    max_rounds: int = 5
    note_path: Path | None = None


@dataclass
class QueryIntent:
    query: str
    pack_slug: str | None
    note_path: Path | None = None


def parse_inbox_file(path: Path) -> LearnIntent | QueryIntent | None:
    """
    Parse an inbox .md file and return a LearnIntent or QueryIntent.

    Rules:
    - filename starts with "learn-"  → LearnIntent (first URL in body)
    - filename starts with "?"       → QueryIntent (body = query text)
    - Otherwise                      → None (ignored)
    """
    name = path.stem  # filename without extension

    try:
        post = frontmatter.load(str(path))
    except Exception:
        return None

    if name.startswith("learn-"):
        pack_slug = post.metadata.get("pack", "general")
        max_rounds = int(post.metadata.get("max_rounds", 5))
        # Find first URL in body
        match = _URL_RE.search(post.content)
        if not match:
            return None
        return LearnIntent(
            url=match.group(0),
            pack_slug=pack_slug,
            max_rounds=max_rounds,
            note_path=path,
        )

    if name.startswith("?"):
        query = post.content.strip()
        if not query:
            return None
        pack_slug = post.metadata.get("pack") or None
        return QueryIntent(query=query, pack_slug=pack_slug, note_path=path)

    return None
```

- [ ] **Step 5: Write failing tests**

```python
# vault-bridge/tests/test_inbox.py
import textwrap
from pathlib import Path

import pytest

from inbox import LearnIntent, QueryIntent, parse_inbox_file


def test_learn_intent_from_learn_prefix(tmp_path: Path):
    note = tmp_path / "learn-blackholes.md"
    note.write_text(textwrap.dedent("""\
        ---
        pack: astrophysics
        max_rounds: 3
        ---
        Please learn from: https://en.wikipedia.org/wiki/Black_hole
    """))
    result = parse_inbox_file(note)
    assert isinstance(result, LearnIntent)
    assert result.url == "https://en.wikipedia.org/wiki/Black_hole"
    assert result.pack_slug == "astrophysics"
    assert result.max_rounds == 3


def test_learn_intent_default_pack(tmp_path: Path):
    note = tmp_path / "learn-test.md"
    note.write_text("https://example.com/article\n")
    result = parse_inbox_file(note)
    assert isinstance(result, LearnIntent)
    assert result.pack_slug == "general"
    assert result.max_rounds == 5


def test_query_intent_from_question_prefix(tmp_path: Path):
    note = tmp_path / "?what-is-dark-matter.md"
    note.write_text(textwrap.dedent("""\
        ---
        pack: astrophysics
        ---
        What exactly is dark matter and why can't we see it?
    """))
    result = parse_inbox_file(note)
    assert isinstance(result, QueryIntent)
    assert "dark matter" in result.query
    assert result.pack_slug == "astrophysics"


def test_unknown_prefix_returns_none(tmp_path: Path):
    note = tmp_path / "random-note.md"
    note.write_text("Just a regular note.\n")
    result = parse_inbox_file(note)
    assert result is None


def test_learn_without_url_returns_none(tmp_path: Path):
    note = tmp_path / "learn-empty.md"
    note.write_text("No URL here, just text.\n")
    result = parse_inbox_file(note)
    assert result is None
```

- [ ] **Step 6: Run tests**

```bash
cd vault-bridge
pip install -r requirements.txt
pytest tests/test_inbox.py -v
```

Expected:
```
PASSED tests/test_inbox.py::test_learn_intent_from_learn_prefix
PASSED tests/test_inbox.py::test_learn_intent_default_pack
PASSED tests/test_inbox.py::test_query_intent_from_question_prefix
PASSED tests/test_inbox.py::test_unknown_prefix_returns_none
PASSED tests/test_inbox.py::test_learn_without_url_returns_none
5 passed
```

- [ ] **Step 7: Commit**

```bash
git add vault-bridge/requirements.txt vault-bridge/config.py vault-bridge/client.py vault-bridge/inbox.py vault-bridge/tests/
git commit -m "feat(bridge): config + client + inbox parser

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

---

## Task 10: vault-bridge Note Writer

**Files:**
- Create: `vault-bridge/note_writer.py`
- Create: `vault-bridge/tests/test_note_writer.py`

- [ ] **Step 1: Write failing tests first**

```python
# vault-bridge/tests/test_note_writer.py
import uuid
from datetime import datetime, timezone
from pathlib import Path

import frontmatter
import pytest

from client import ClaimData
from note_writer import write_claim_note, write_index_note, write_status_note, write_answer_note


def _make_claim(content: str = "Black holes warp spacetime.") -> ClaimData:
    return ClaimData(
        id=str(uuid.uuid4()),
        content=content,
        source_span="Para 3",
        confidence=0.87,
        fsrs_due=datetime.now(tz=timezone.utc).isoformat(),
        human_edited=False,
    )


def test_write_claim_note_creates_file(tmp_path: Path):
    claim = _make_claim()
    note_path = write_claim_note(
        claim=claim,
        pack_slug="astrophysics",
        source_url="https://example.com/article",
        vault_path=tmp_path,
    )
    assert note_path.exists()
    post = frontmatter.load(str(note_path))
    assert post.metadata["id"] == claim.id
    assert post.metadata["pack"] == "astrophysics"
    assert post.metadata["confidence"] == 0.87
    assert post.metadata["human_edited"] is False
    assert "Black holes" in post.content


def test_write_claim_note_sets_correct_directory(tmp_path: Path):
    claim = _make_claim()
    note_path = write_claim_note(
        claim=claim,
        pack_slug="physics",
        source_url="https://example.com",
        vault_path=tmp_path,
    )
    assert note_path.parent == tmp_path / "Topics" / "physics"


def test_write_status_note_creates_file(tmp_path: Path):
    job_id = str(uuid.uuid4())
    note_path = write_status_note(
        job_id=job_id,
        status="round-2",
        current_round=2,
        max_rounds=5,
        questions=["What is dark matter?", "Why can't we see it?"],
        vault_path=tmp_path,
    )
    assert note_path.exists()
    post = frontmatter.load(str(note_path))
    assert post.metadata["status"] == "round-2"
    assert "round" in post.content.lower() or "question" in post.content.lower()


def test_write_answer_note_creates_file(tmp_path: Path):
    note_path = write_answer_note(
        query="What is dark matter?",
        answer="Dark matter is an invisible form of matter [1][2].",
        claim_ids=["abc-123", "def-456"],
        vault_path=tmp_path,
    )
    assert note_path.exists()
    text = note_path.read_text()
    assert "Dark matter" in text


def test_write_index_note_creates_file(tmp_path: Path):
    claim_paths = [
        tmp_path / "Topics" / "astro" / "claim-a.md",
        tmp_path / "Topics" / "astro" / "claim-b.md",
    ]
    for p in claim_paths:
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text("claim")

    note_path = write_index_note(
        pack_slug="astro",
        claim_paths=claim_paths,
        vault_path=tmp_path,
    )
    assert note_path.exists()
    text = note_path.read_text()
    assert "claim-a" in text
    assert "claim-b" in text
```

- [ ] **Step 2: Run tests — expect FAIL (module not found)**

```bash
cd vault-bridge
pytest tests/test_note_writer.py -v 2>&1 | head -20
```

Expected: `ModuleNotFoundError: No module named 'note_writer'`

- [ ] **Step 3: Write `note_writer.py`**

```python
# vault-bridge/note_writer.py
from __future__ import annotations

import re
import uuid
from datetime import datetime, timezone
from pathlib import Path

import frontmatter

from client import ClaimData


def _slugify(text: str) -> str:
    """Convert text to a safe filename slug."""
    text = text.lower()
    text = re.sub(r"[^\w\s-]", "", text)
    text = re.sub(r"[\s_-]+", "-", text)
    return text.strip("-")[:60]


def write_claim_note(
    claim: ClaimData,
    pack_slug: str,
    source_url: str,
    vault_path: Path,
) -> Path:
    """Write an atomic claim .md to Topics/<pack>/<claim-id>.md."""
    dest_dir = vault_path / "Topics" / pack_slug
    dest_dir.mkdir(parents=True, exist_ok=True)
    dest = dest_dir / f"{claim.id}.md"

    post = frontmatter.Post(
        claim.content,
        id=claim.id,
        pack=pack_slug,
        source_url=source_url,
        source_span=claim.source_span,
        confidence=claim.confidence,
        validated_at=None,
        fsrs_due=claim.fsrs_due,
        human_edited=claim.human_edited,
        tags=[pack_slug],
        related=[],
    )
    dest.write_text(frontmatter.dumps(post))
    return dest


def write_status_note(
    job_id: str,
    status: str,
    current_round: int,
    max_rounds: int,
    questions: list[str],
    vault_path: Path,
) -> Path:
    """Write/update a KAL progress note to 00_Status/<job_id>.md."""
    dest_dir = vault_path / "00_Status"
    dest_dir.mkdir(parents=True, exist_ok=True)
    dest = dest_dir / f"{job_id}.md"

    qs_section = ""
    if questions:
        qs_section = "\n## Open Questions\n" + "\n".join(f"- {q}" for q in questions)

    post = frontmatter.Post(
        f"**KAL Progress** | Round {current_round}/{max_rounds}{qs_section}",
        job_id=job_id,
        status=status,
        current_round=current_round,
        max_rounds=max_rounds,
        updated_at=datetime.now(tz=timezone.utc).isoformat(),
    )
    dest.write_text(frontmatter.dumps(post))
    return dest


def write_answer_note(
    query: str,
    answer: str,
    claim_ids: list[str],
    vault_path: Path,
) -> Path:
    """Write a Q&A answer note to Answers/<slug>.md."""
    dest_dir = vault_path / "Answers"
    dest_dir.mkdir(parents=True, exist_ok=True)
    slug = _slugify(query)
    dest = dest_dir / f"{slug}.md"

    refs = "\n".join(f"- [[Topics/{cid}]]" for cid in claim_ids)
    body = f"{answer}\n\n## Sources\n{refs}"

    post = frontmatter.Post(
        body,
        query=query,
        created_at=datetime.now(tz=timezone.utc).isoformat(),
        tags=["answer"],
    )
    dest.write_text(frontmatter.dumps(post))
    return dest


def write_index_note(
    pack_slug: str,
    claim_paths: list[Path],
    vault_path: Path,
) -> Path:
    """Write/update _index.md for a TopicPack."""
    dest_dir = vault_path / "Topics" / pack_slug
    dest_dir.mkdir(parents=True, exist_ok=True)
    dest = dest_dir / "_index.md"

    links = "\n".join(f"- [[Topics/{pack_slug}/{p.stem}]]" for p in sorted(claim_paths))
    body = f"# {pack_slug.replace('-', ' ').title()}\n\n{links}"

    post = frontmatter.Post(
        body,
        pack=pack_slug,
        updated_at=datetime.now(tz=timezone.utc).isoformat(),
    )
    dest.write_text(frontmatter.dumps(post))
    return dest
```

- [ ] **Step 4: Run tests**

```bash
cd vault-bridge
pytest tests/test_note_writer.py -v
```

Expected:
```
PASSED tests/test_note_writer.py::test_write_claim_note_creates_file
PASSED tests/test_note_writer.py::test_write_claim_note_sets_correct_directory
PASSED tests/test_note_writer.py::test_write_status_note_creates_file
PASSED tests/test_note_writer.py::test_write_answer_note_creates_file
PASSED tests/test_note_writer.py::test_write_index_note_creates_file
5 passed
```

- [ ] **Step 5: Commit**

```bash
git add vault-bridge/note_writer.py vault-bridge/tests/test_note_writer.py
git commit -m "feat(bridge): note_writer — claim, status, answer, index notes

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

---

## Task 11: vault-bridge Poller + Watcher + Entry Point

**Files:**
- Create: `vault-bridge/poller.py`
- Create: `vault-bridge/watcher.py`
- Create: `vault-bridge/bridge.py`
- Create: `vault-bridge/tests/test_poller.py`

- [ ] **Step 1: Write failing poller tests**

```python
# vault-bridge/tests/test_poller.py
import uuid
from pathlib import Path
from unittest.mock import MagicMock, call, patch

import pytest

from client import ClaimData, JobStatus
from poller import JobPoller


def _status(status: str, round_: int = 0) -> JobStatus:
    return JobStatus(
        job_id=str(uuid.uuid4()),
        status=status,
        current_round=round_,
        max_rounds=5,
        questions=[],
    )


def test_poller_writes_status_on_each_round(tmp_path: Path):
    job_id = str(uuid.uuid4())

    status_sequence = [
        _status("round-1", 1),
        _status("round-2", 2),
        _status("done", 2),
    ]
    claim_data = [
        ClaimData(id=str(uuid.uuid4()), content="Fact A", source_span=None,
                  confidence=0.9, fsrs_due="2026-01-01T00:00:00Z", human_edited=False)
    ]

    mock_client = MagicMock()
    mock_client.get_status.side_effect = status_sequence
    mock_client.get_claims.return_value = claim_data

    written_statuses = []

    def fake_write_status(job_id, status, current_round, max_rounds, questions, vault_path):
        written_statuses.append(status)
        return tmp_path / "00_Status" / f"{job_id}.md"

    with patch("poller.write_status_note", side_effect=fake_write_status), \
         patch("poller.write_claim_note", return_value=tmp_path / "claim.md"), \
         patch("poller.write_index_note", return_value=tmp_path / "index.md"), \
         patch("time.sleep"):
        poller = JobPoller(
            client=mock_client,
            vault_path=tmp_path,
            pack_slug="physics",
            source_url="https://example.com",
            poll_interval=0,
        )
        poller.run(job_id)

    assert "round-1" in written_statuses
    assert "done" in written_statuses
    assert mock_client.get_claims.called


def test_poller_handles_failed_job(tmp_path: Path):
    job_id = str(uuid.uuid4())
    failed_status = JobStatus(
        job_id=job_id,
        status="failed",
        current_round=1,
        max_rounds=5,
        questions=[],
        error_msg="LLM timeout",
    )
    mock_client = MagicMock()
    mock_client.get_status.return_value = failed_status

    with patch("poller.write_status_note", return_value=tmp_path / "s.md"), \
         patch("time.sleep"):
        poller = JobPoller(
            client=mock_client,
            vault_path=tmp_path,
            pack_slug="physics",
            source_url="https://example.com",
            poll_interval=0,
        )
        poller.run(job_id)

    # Status note written for failed state; no claims fetched
    assert not mock_client.get_claims.called
```

- [ ] **Step 2: Run tests — expect FAIL**

```bash
cd vault-bridge
pytest tests/test_poller.py -v 2>&1 | head -10
```

Expected: `ModuleNotFoundError: No module named 'poller'`

- [ ] **Step 3: Write `poller.py`**

```python
# vault-bridge/poller.py
from __future__ import annotations

import logging
import time
from pathlib import Path

from client import ClaimData, MindForgeClient
from config import settings
from note_writer import write_claim_note, write_index_note, write_status_note

log = logging.getLogger(__name__)

_TERMINAL_STATUSES = {"done", "failed"}


class JobPoller:
    def __init__(
        self,
        client: MindForgeClient,
        vault_path: Path,
        pack_slug: str,
        source_url: str,
        poll_interval: float | None = None,
    ) -> None:
        self._client = client
        self._vault_path = vault_path
        self._pack_slug = pack_slug
        self._source_url = source_url
        self._poll_interval = poll_interval if poll_interval is not None else settings.poll_interval

    def run(self, job_id: str) -> None:
        """Poll GX10 for job_id until terminal status, writing notes each round."""
        log.info("Polling job %s", job_id)
        while True:
            try:
                status = self._client.get_status(job_id)
            except Exception as exc:
                log.warning("Poll error for %s: %s", job_id, exc)
                time.sleep(self._poll_interval)
                continue

            log.info("Job %s status=%s round=%d/%d", job_id, status.status, status.current_round, status.max_rounds)

            write_status_note(
                job_id=job_id,
                status=status.status,
                current_round=status.current_round,
                max_rounds=status.max_rounds,
                questions=status.questions,
                vault_path=self._vault_path,
            )

            if status.status == "done":
                self._write_claims(job_id)
                break

            if status.status == "failed":
                log.error("Job %s failed: %s", job_id, status.error_msg)
                self._move_to_failed(job_id)
                break

            time.sleep(self._poll_interval)

    def _write_claims(self, job_id: str) -> None:
        try:
            claims = self._client.get_claims(job_id)
        except Exception as exc:
            log.error("Failed to fetch claims for job %s: %s", job_id, exc)
            return

        written_paths = []
        for claim in claims:
            path = write_claim_note(
                claim=claim,
                pack_slug=self._pack_slug,
                source_url=self._source_url,
                vault_path=self._vault_path,
            )
            written_paths.append(path)
            log.info("Wrote claim note: %s", path)

        if written_paths:
            write_index_note(
                pack_slug=self._pack_slug,
                claim_paths=written_paths,
                vault_path=self._vault_path,
            )

    def _move_to_failed(self, job_id: str) -> None:
        status_note = self._vault_path / "00_Status" / f"{job_id}.md"
        if status_note.exists():
            dest = self._vault_path / "00_Failed" / f"{job_id}.md"
            dest.parent.mkdir(parents=True, exist_ok=True)
            status_note.rename(dest)
```

- [ ] **Step 4: Write `watcher.py`**

```python
# vault-bridge/watcher.py
from __future__ import annotations

import logging
import threading
import time
from pathlib import Path

from watchdog.events import FileCreatedEvent, FileModifiedEvent, FileSystemEventHandler
from watchdog.observers import Observer

from client import MindForgeClient
from config import settings
from inbox import LearnIntent, QueryIntent, parse_inbox_file
from note_writer import write_answer_note, write_status_note
from poller import JobPoller

log = logging.getLogger(__name__)


class InboxHandler(FileSystemEventHandler):
    """Watch 00_Inbox/ for new .md files and dispatch KAL or query jobs."""

    def __init__(self, client: MindForgeClient, vault_path: Path) -> None:
        self._client = client
        self._vault_path = vault_path
        self._debounce: dict[str, float] = {}

    def on_created(self, event) -> None:
        if event.is_directory:
            return
        path = Path(event.src_path)
        if path.suffix != ".md":
            return
        self._handle(path)

    def _handle(self, path: Path) -> None:
        now = time.time()
        key = str(path)
        if now - self._debounce.get(key, 0) < 2.0:
            return
        self._debounce[key] = now

        intent = parse_inbox_file(path)
        if intent is None:
            return

        # Move to 00_Processed immediately
        processed = self._vault_path / "00_Processed" / path.name
        processed.parent.mkdir(parents=True, exist_ok=True)
        path.rename(processed)

        if isinstance(intent, LearnIntent):
            log.info("Dispatching KAL for %s", intent.url)
            try:
                job_id = self._client.post_learn(intent.url, intent.pack_slug, intent.max_rounds)
                write_status_note(
                    job_id=job_id,
                    status="queued",
                    current_round=0,
                    max_rounds=intent.max_rounds,
                    questions=[],
                    vault_path=self._vault_path,
                )
                t = threading.Thread(
                    target=_run_poller,
                    args=(self._client, self._vault_path, intent.pack_slug, intent.url, job_id),
                    daemon=True,
                )
                t.start()
            except Exception as exc:
                log.error("Failed to post learn request: %s", exc)

        elif isinstance(intent, QueryIntent):
            log.info("Running query: %s", intent.query)
            try:
                result = self._client.post_query(
                    query=intent.query,
                    pack_slug=intent.pack_slug,
                )
                claim_ids = [c["id"] for c in result.get("claims", [])]
                write_answer_note(
                    query=intent.query,
                    answer=result.get("answer", ""),
                    claim_ids=claim_ids,
                    vault_path=self._vault_path,
                )
            except Exception as exc:
                log.error("Query failed: %s", exc)


class ClaimEditHandler(FileSystemEventHandler):
    """Watch Topics/**/*.md for edits; skip _index.md and human_edited=true notes."""

    def __init__(self, client: MindForgeClient, vault_path: Path) -> None:
        self._client = client
        self._vault_path = vault_path
        self._debounce: dict[str, float] = {}

    def on_modified(self, event) -> None:
        if event.is_directory:
            return
        path = Path(event.src_path)
        if path.suffix != ".md" or path.stem == "_index":
            return
        now = time.time()
        key = str(path)
        if now - self._debounce.get(key, 0) < 2.0:
            return
        self._debounce[key] = now
        log.debug("Claim modified: %s (human_edited will be synced on next full cycle)", path)


def _run_poller(
    client: MindForgeClient, vault_path: Path, pack_slug: str, source_url: str, job_id: str
) -> None:
    poller = JobPoller(client=client, vault_path=vault_path, pack_slug=pack_slug, source_url=source_url)
    poller.run(job_id)
```

- [ ] **Step 5: Write `bridge.py`**

```python
# vault-bridge/bridge.py
"""
MindForge vault-bridge entry point.

Usage:
    cd vault-bridge
    python bridge.py
"""
from __future__ import annotations

import logging
import signal
import sys
import time
from pathlib import Path

import frontmatter
from watchdog.observers import Observer

from client import MindForgeClient
from config import settings
from watcher import ClaimEditHandler, InboxHandler

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(name)s %(message)s")
log = logging.getLogger(__name__)


def resume_inflight_jobs(client: MindForgeClient, vault_path: Path) -> None:
    """On startup, resume any jobs that were queued or in-progress before last shutdown."""
    import threading
    from poller import JobPoller

    status_dir = vault_path / "00_Status"
    if not status_dir.exists():
        return

    for note_path in status_dir.glob("*.md"):
        try:
            post = frontmatter.load(str(note_path))
            job_id = post.metadata.get("job_id")
            status = post.metadata.get("status", "")
        except Exception:
            continue

        if not job_id or status in ("done", "failed"):
            continue

        # Try to discover pack_slug from existing claim notes
        pack_slug = "general"
        source_url = ""
        for topic_dir in (vault_path / "Topics").iterdir() if (vault_path / "Topics").exists() else []:
            pack_slug = topic_dir.name
            break

        log.info("Resuming in-flight job %s (status=%s)", job_id, status)
        t = threading.Thread(
            target=_resume_poller,
            args=(client, vault_path, pack_slug, source_url, job_id),
            daemon=True,
        )
        t.start()


def _resume_poller(client: MindForgeClient, vault_path: Path, pack_slug: str, source_url: str, job_id: str) -> None:
    from poller import JobPoller
    poller = JobPoller(client=client, vault_path=vault_path, pack_slug=pack_slug, source_url=source_url)
    try:
        poller.run(job_id)
    except Exception as exc:
        log.error("Resume poller for %s failed: %s", job_id, exc)


def main() -> None:
    vault_path = settings.vault_path
    vault_path.mkdir(parents=True, exist_ok=True)
    for sub in ["00_Inbox", "00_Processed", "00_Failed", "00_Status", "Topics", "Answers"]:
        (vault_path / sub).mkdir(exist_ok=True)

    log.info("Vault path: %s", vault_path)
    log.info("GX10 URL: %s", settings.gx10_url)

    client = MindForgeClient()

    # Resume in-flight jobs from last session
    resume_inflight_jobs(client, vault_path)

    observer = Observer()
    observer.schedule(InboxHandler(client, vault_path), str(vault_path / "00_Inbox"), recursive=False)
    observer.schedule(ClaimEditHandler(client, vault_path), str(vault_path / "Topics"), recursive=True)
    observer.start()

    log.info("vault-bridge running. Drop learn-*.md or ?*.md into %s/00_Inbox/", vault_path)

    def shutdown(sig, frame):
        log.info("Shutting down...")
        observer.stop()
        sys.exit(0)

    signal.signal(signal.SIGINT, shutdown)
    signal.signal(signal.SIGTERM, shutdown)

    while True:
        time.sleep(1)


if __name__ == "__main__":
    main()
```

- [ ] **Step 6: Run poller tests**

```bash
cd vault-bridge
pytest tests/test_poller.py -v
```

Expected:
```
PASSED tests/test_poller.py::test_poller_writes_status_on_each_round
PASSED tests/test_poller.py::test_poller_handles_failed_job
2 passed
```

- [ ] **Step 7: Run all vault-bridge tests**

```bash
cd vault-bridge
pytest tests/ -v
```

Expected:
```
PASSED tests/test_inbox.py::test_learn_intent_from_learn_prefix
PASSED tests/test_inbox.py::test_learn_intent_default_pack
PASSED tests/test_inbox.py::test_query_intent_from_question_prefix
PASSED tests/test_inbox.py::test_unknown_prefix_returns_none
PASSED tests/test_inbox.py::test_learn_without_url_returns_none
PASSED tests/test_note_writer.py::test_write_claim_note_creates_file
PASSED tests/test_note_writer.py::test_write_claim_note_sets_correct_directory
PASSED tests/test_note_writer.py::test_write_status_note_creates_file
PASSED tests/test_note_writer.py::test_write_answer_note_creates_file
PASSED tests/test_note_writer.py::test_write_index_note_creates_file
PASSED tests/test_poller.py::test_poller_writes_status_on_each_round
PASSED tests/test_poller.py::test_poller_handles_failed_job
12 passed
```

- [ ] **Step 8: Commit**

```bash
git add vault-bridge/poller.py vault-bridge/watcher.py vault-bridge/bridge.py vault-bridge/tests/test_poller.py
git commit -m "feat(bridge): poller + watcher + bridge entry point + restart recovery

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

---

## Task 12: End-to-End Integration Test (Staging Smoke Test)

This task requires GX10 services running. Run on the GX10 itself.

**Files:**
- Create: `gx10/tests/test_e2e.py`

- [ ] **Step 1: Start all GX10 services**

```bash
cd gx10
docker compose up -d
sleep 15
docker compose ps
```

Expected: all services show `running` or `healthy`.

- [ ] **Step 2: Verify embedding service**

```bash
curl -s -X POST http://localhost:8001/embed \
  -H "Content-Type: application/json" \
  -d '{"texts": ["test embedding"]}' | python3 -c "import sys,json; d=json.load(sys.stdin); print('OK, dims:', len(d['embeddings'][0]))"
```

Expected: `OK, dims: 1024`

- [ ] **Step 3: Verify API health**

```bash
curl -s http://localhost:8000/health
```

Expected: `{"status":"ok"}`

- [ ] **Step 4: Write `tests/test_e2e.py`**

```python
# gx10/tests/test_e2e.py
"""
End-to-end smoke test. Requires all docker compose services running.
Run with: pytest tests/test_e2e.py -v --timeout=120
"""
import time

import httpx
import pytest

BASE = "http://localhost:8000"
EMBED_BASE = "http://localhost:8001"


def test_health():
    resp = httpx.get(f"{BASE}/health")
    assert resp.status_code == 200
    assert resp.json()["status"] == "ok"


def test_embed_returns_1024_dims():
    resp = httpx.post(f"{EMBED_BASE}/embed", json={"texts": ["hello world"]}, timeout=30)
    assert resp.status_code == 200
    dims = len(resp.json()["embeddings"][0])
    assert dims == 1024


def test_rerank_returns_scores():
    resp = httpx.post(
        f"{EMBED_BASE}/rerank",
        json={"query": "black holes", "passages": ["Black holes warp spacetime.", "Cats eat mice."]},
        timeout=30,
    )
    assert resp.status_code == 200
    scores = resp.json()["scores"]
    assert len(scores) == 2
    # First passage should score higher
    assert scores[0] > scores[1]


def test_post_learn_and_poll_status():
    """Submit a real URL and confirm job_id is returned with 'queued' status."""
    resp = httpx.post(
        f"{BASE}/learn",
        json={"url": "https://en.wikipedia.org/wiki/Black_hole", "pack_slug": "e2e-test"},
        timeout=15,
    )
    assert resp.status_code == 200
    data = resp.json()
    assert "job_id" in data
    assert data["status"] == "queued"

    job_id = data["job_id"]

    # Poll for up to 60s until status transitions away from 'queued'
    for _ in range(12):
        time.sleep(5)
        status_resp = httpx.get(f"{BASE}/learn/{job_id}/status", timeout=10)
        assert status_resp.status_code == 200
        status = status_resp.json()["status"]
        if status not in ("queued",):
            break

    assert status in ("extracted", "round-1", "done", "failed"), f"Unexpected status: {status}"


def test_post_query_returns_answer():
    """Query against any existing claims (may be empty if no prior learn run)."""
    resp = httpx.post(
        f"{BASE}/query",
        json={"query": "What are black holes?", "top_k": 5},
        timeout=30,
    )
    assert resp.status_code == 200
    data = resp.json()
    assert "answer" in data
    assert isinstance(data["claims"], list)
```

- [ ] **Step 5: Run e2e tests**

```bash
cd gx10
pip install pytest httpx
pytest tests/test_e2e.py -v --timeout=120
```

Expected (with LLM running):
```
PASSED tests/test_e2e.py::test_health
PASSED tests/test_e2e.py::test_embed_returns_1024_dims
PASSED tests/test_e2e.py::test_rerank_returns_scores
PASSED tests/test_e2e.py::test_post_learn_and_poll_status
PASSED tests/test_e2e.py::test_post_query_returns_answer
5 passed
```

- [ ] **Step 6: Start vault-bridge on Mac**

```bash
cd vault-bridge
# set VAULT_PATH and GX10_URL in .env
echo "VAULT_PATH=$HOME/Documents/Obsidian/MindForge" > .env
echo "GX10_URL=http://<GX10_IP>:8000" >> .env
python bridge.py
```

- [ ] **Step 7: Drop a test inbox note**

In Obsidian (or Finder), create `00_Inbox/learn-blackholes.md`:

```markdown
---
pack: astrophysics
max_rounds: 3
---
https://en.wikipedia.org/wiki/Black_hole
```

Expected observable behaviour:
1. bridge logs `Dispatching KAL for https://en.wikipedia.org/wiki/Black_hole`
2. `00_Status/<job_id>.md` appears in vault (visible in Obsidian)
3. Status note updates as rounds progress
4. `Topics/astrophysics/<uuid>.md` claim notes appear when done
5. `Topics/astrophysics/_index.md` lists all claim wikilinks

- [ ] **Step 8: Commit**

```bash
git add gx10/tests/test_e2e.py
git commit -m "test(e2e): end-to-end smoke test for GX10 API + embedding + vault-bridge flow

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

---

## GX10 First-Run Checklist

Before running for the first time on the GX10:

1. **Start vLLM** (in a separate terminal):
   ```bash
   cd /path/to/spark-vllm-docker
   ./run-recipe.sh qwen3-coder-next-fp8 --solo
   ```
   Verify: `curl http://localhost:8080/v1/models`

2. **Copy `.env`** and set `POSTGRES_PASSWORD`, `LLM_BASE_URL=http://host.docker.internal:8080/v1`, `BRAVE_API_KEY`

3. **Build and start**:
   ```bash
   docker compose build
   docker compose up -d
   ```

4. **Check memory**:
   ```bash
   free -h
   # Should show ~40GB+ free with model loaded
   ```
