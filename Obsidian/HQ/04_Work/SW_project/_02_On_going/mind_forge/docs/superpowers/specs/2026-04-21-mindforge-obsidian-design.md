# MindForge × Obsidian — Design Spec

**Date:** 2026-04-21  
**Status:** Approved  
**Approach:** File-Watcher Bridge (Approach A)

---

## 1. Objective

Build a local MindForge knowledge engine on the ASUS Ascent GX10 (GB10 / 128GB) where **Obsidian is the primary user interface and source of truth**. The user interacts entirely inside Obsidian — dropping URLs to learn, reading atomic claim notes, and querying the knowledge base — without touching a web app or terminal.

The system is **fully bidirectional**: the Obsidian vault drives the database, and the database writes back to the vault.

---

## 2. Design Decisions

| Decision | Choice | Rationale |
|---|---|---|
| Obsidian role | Full bidirectional sync | Vault is source of truth; DB is derived index |
| Trigger mechanism | Native Obsidian (inbox folder) | Zero context switching; no plugin dev required initially |
| Vault structure | Atomic notes — one claim = one `.md` file | Zettelkasten-style; Obsidian graph view works for free |
| Build approach | File-Watcher Bridge | Fastest path to working system; no TypeScript plugin dev |
| Starting point | From scratch (GX10 hardware + Obsidian vault) | No existing backend |

---

## 3. System Architecture

Two machines, one system:

```
┌─────────────────────────────────┐      LAN       ┌─────────────────────────────────────┐
│          Mac (your machine)      │ ◄────────────► │      ASUS GX10 (Ubuntu · 128GB)      │
│                                  │                │                                      │
│  Obsidian Vault                  │                │  LLM Layer (spark-vllm-docker)       │
│    MindForge/00_Inbox/           │                │    Qwen3-Coder-Next FP8 · :8000      │
│    MindForge/Topics/<pack>/      │                │    BGE-M3 embed service · :8001       │
│    MindForge/00_Status/          │                │    BGE-Reranker-v2-m3                 │
│    MindForge/Answers/            │                │                                      │
│                                  │                │  Application Layer (Docker Compose)   │
│  vault-bridge (Python)           │                │    FastAPI · :3001                   │
│    watchdog file watcher         │                │    Celery workers (async KAL)         │
│    calls GX10 FastAPI over LAN   │                │    LangGraph KAL state machine        │
│    receives webhooks             │                │    Redis (task queue + KAL state)     │
│    writes .md files back         │                │                                      │
│                                  │                │  Storage Layer                        │
│                                  │                │    PostgreSQL 16 + pgvector + pg_trgm │
│                                  │                │    MinIO / local fs (raw docs)        │
└─────────────────────────────────┘                └─────────────────────────────────────┘
```

---

## 4. Vault Folder Structure

```
MindForge/
├── 00_Inbox/          ← you drop files here to trigger actions
├── 00_Processed/      ← auto-moved after handling
├── 00_Failed/         ← moved here after all retries exhausted
├── 00_Status/         ← live KAL progress notes (one per job)
├── Topics/            ← distilled knowledge
│   ├── hermes-agent/
│   │   ├── _index.md  ← pack summary, links to all claims
│   │   ├── claim-3f9a2b.md
│   │   ├── claim-7c1d44.md
│   │   └── …
│   ├── vllm/
│   └── pgvector/
└── Answers/           ← Q&A responses
```

### Inbox Filename Conventions

The bridge detects intent from the filename prefix inside `00_Inbox/`:

| Filename pattern | Action |
|---|---|
| `learn-*.md` | File body contains a URL → triggers KAL learning |
| `?*.md` | File body contains a question → triggers Q&A query |

Processed files are moved to `00_Processed/`. Failed files (all retries exhausted) go to `00_Failed/`.

---

## 5. Note Schemas

### 5.1 Inbox Note (user-authored)

```markdown
learn-hermes-agent.md
─────────────────────
https://github.com/nousresearch/hermes-agent

Optional: any context or notes here
```

### 5.2 Atomic Claim Note (bridge-written)

```markdown
---
id: 3f9a2b
pack: hermes-agent
source_url: https://github.com/nousresearch/hermes-agent
source_span: [120, 310]
confidence: 0.94
validated_at: 2026-04-21
fsrs_due: 2026-05-03
human_edited: false
tags: [mindforge/claim, hermes-agent]
related: ["[[claim-7c1d44]]", "[[claim-2e88fa]]"]
---

Hermes Agent uses a structured tool-call format with explicit XML tags
to separate reasoning steps from action invocations.
```

### 5.3 Topic Pack Index (bridge-written)

```markdown
---
pack: hermes-agent
source_url: https://github.com/nousresearch/hermes-agent
claim_count: 38
converged: true
converged_at: 2026-04-21T03:05:22
kal_rounds: 2
fsrs_next_review: 2026-05-01
tags: [mindforge/pack]
---

## hermes-agent

> Learned from: https://github.com/nousresearch/hermes-agent  
> KAL converged in 2 rounds (38 claims).

[[claim-3f9a2b]] [[claim-7c1d44]] [[claim-2e88fa]] …
```

### 5.4 Status Note (bridge-written, continuously updated)

```markdown
---
task_id: celery-uuid
status: converged
source_url: https://github.com/nousresearch/hermes-agent
started_at: 2026-04-21T03:00:00
finished_at: 2026-04-21T03:05:22
rounds: 2
claim_count: 38
tags: [mindforge/status]
---

✅ **converged** — 38 claims written to [[Topics/hermes-agent/_index]]

| Round | Claims | Questions | Passed |
|-------|--------|-----------|--------|
| 1     | 38     | 3         | 0/3    |
| 2     | +12    | 3         | 3/3 ✅ |
```

Status progression: `🟡 queued` → `🔵 round-N` → `🟠 searching` → `✅ converged` / `⚠️ partial` / `❌ error`

### 5.5 Answer Note (bridge-written)

```markdown
---
query: "What is Hermes Agent?"
answered_at: 2026-04-21T03:10:00
sources: [claim-3f9a2b, claim-7c1d44]
tags: [mindforge/answer]
---

Hermes Agent is a structured tool-calling framework… [^1]

It separates reasoning from action invocations using XML tags… [^2]

[^1]: [[Topics/hermes-agent/claim-3f9a2b]]
[^2]: [[Topics/hermes-agent/claim-7c1d44]]
```

---

## 6. Sync Logic

### 6.1 Vault → DB (user edits a claim)

1. watchdog fires `FileModifiedEvent` on any `Topics/**/*.md`
2. **2-second debounce** — waits for Obsidian's auto-save to settle
3. Bridge parses frontmatter, extracts `id`
4. `UPDATE claims SET content=…, human_edited=true WHERE id=…`
5. `human_edited=true` is a permanent flag — KAL will never overwrite this claim on any future re-distillation

### 6.2 DB → Vault (KAL finishes)

The bridge uses **polling only** — GX10 never needs to know the Mac's IP.

1. Bridge enqueues a KAL job → receives `task_id`
2. Bridge polls `GET /learn/{task_id}/status` every 5s
3. When status is `converged` or `partial`: bridge fetches the full claim list via `GET /learn/{task_id}/claims`
4. Bridge writes atomic `claim-{uuid}.md` files into `Topics/{pack}/`
5. Bridge writes/updates `_index.md` for the pack
6. Bridge updates status note to `✅ converged`
7. Bridge moves inbox file to `00_Processed/`

### 6.3 Bridge Restart Recovery

On bridge startup, it reads all status notes in `00_Status/` with status `queued` or `round-N` — these represent jobs that were in-flight when the bridge last stopped. It resumes polling those `task_id` values immediately.

---

## 7. Conflict Resolution Rules

| Situation | Rule |
|---|---|
| KAL re-distills a topic with `human_edited=true` claims | Human claims are never overwritten; new KAL claims added alongside |
| User deletes a claim `.md` in Obsidian | Soft-delete in DB (`deleted_at` set). Never hard-delete — preserves citation integrity |
| Bridge offline when KAL finishes | GX10 Redis queues webhook; bridge drains on reconnect |
| Obsidian Sync conflict file detected | Bridge logs warning, leaves `.sync-conflict-…` files untouched for manual resolution |
| Brave Search quota exceeded | KAL falls back to single-round distillation; status note records `⚠️ no-search` |

---

## 8. Error Handling

| Failure | Recovery |
|---|---|
| GX10 unreachable | 3× exponential backoff → write `❌` status note → move to `00_Failed/` |
| KAL hits `max_rounds` without convergence | Write `⚠️ partial` status note; partial claims still written to vault |
| vLLM OOM / crash | Celery retries 3× → error webhook → status note updated |
| Bridge crashes mid-write | Files are written atomically per note; on restart bridge re-polls all in-flight `task_id` values from status notes |

---

## 9. FastAPI Endpoints (GX10)

| Method | Path | Purpose |
|---|---|---|
| `POST` | `/learn` | Enqueue KAL job; returns `task_id` |
| `GET` | `/learn/{task_id}/status` | Poll KAL progress (bridge polls every 5s) |
| `POST` | `/query` | Synchronous Q&A via HFQ pipeline |
| `GET` | `/learn/{task_id}/claims` | Fetch all claims after convergence |
| `GET` | `/bridge/pending` | (removed — polling-only model, no push webhooks) |

---

## 10. GX10 Stack (Docker Compose)

**LLM layer** (spark-vllm-docker, separate managed container):
- Qwen3-Coder-Next FP8 via `run-recipe.sh qwen3-coder-next-fp8 --solo`
- BGE-M3 + BGE-Reranker-v2-m3 via sentence-transformers microservice

**Application layer** (Docker Compose):
- PostgreSQL 16 + pgvector + pg_trgm
- Redis 7
- FastAPI (`:3001`)
- Celery worker (2 concurrency)
- BGE-M3 embedding service (`:8001`)

**Memory budget** (128GB unified):

| Component | Allocation |
|---|---|
| OS + Docker overhead | ~10 GB |
| Qwen3-Coder-Next FP8 weights | ~38 GB |
| vLLM KV cache | ~25 GB |
| BGE-M3 + Reranker | ~5 GB |
| PostgreSQL | ~6 GB |
| Redis + App | ~3 GB |
| **Headroom** | **~41 GB** |

Use `--gpu-memory-utilization 0.75` (96GB) to leave safe headroom.

---

## 11. Phased Build Order

### Phase 1 — GX10 LLM Stack
- Build spark-vllm-docker image
- Run Qwen3-Coder-Next FP8 recipe (`./run-recipe.sh qwen3-coder-next-fp8 --solo`)
- Stand up PostgreSQL + pgvector + pg_trgm (Docker)
- Stand up BGE-M3 embedding service
- **Milestone:** `curl http://gx10:8000/v1/models` returns model list

### Phase 2 — Minimal KAL
- FastAPI + Celery + Redis
- LangGraph 2-node pipeline: `[fetch] → [extract_claims]`
- Store claims in PostgreSQL with embeddings
- **Milestone:** `POST /learn {"url":"…"}` → claims appear in DB

### Phase 3 — vault-bridge (Mac)
- Python watchdog on `MindForge/` vault folder
- Inbox detection → call GX10 `/learn` → write claim `.md` files back
- Status note polling every 5s
- **Milestone:** Drop `learn-*.md` in Obsidian → atomic claim notes appear in `Topics/`

### Phase 4 — Full KAL Loop
- Self-questioning node (generate 3 test questions)
- Coverage check node (can existing claims answer them?)
- Brave Search web expansion
- Cross-validation second pass (different temperature / prompt)
- **Milestone:** Multi-round convergence on a real GitHub repo

### Phase 5 — Retrieval & Query
- HFQ 5-step pipeline: Pack Routing → Hybrid Retrieval → BGE Reranker → Graph Expansion → Citation Assembly
- `POST /query` → LLM generates grounded answer
- Bridge writes answer notes to `Answers/` with wikilink citations
- FSRS freshness scoring and review scheduling
- **Milestone:** Drop `?what-is-hermes-agent.md` → `Answers/` note appears with citations

---

## 12. Out of Scope (this spec)

- Obsidian custom TypeScript plugin (deferred to a future spec)
- Mobile Obsidian sync (use Obsidian Sync or iCloud; bridge runs on Mac only)
- n8n integration (not needed for core flow; can be added as an additional trigger source later)
- Multi-user / shared vault
- Cloud LLM primary path (cloud Claude is cross-validation only, low frequency)
