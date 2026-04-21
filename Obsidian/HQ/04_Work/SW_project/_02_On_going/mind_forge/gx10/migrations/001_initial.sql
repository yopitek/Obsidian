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

-- HNSW index for dense similarity search (partial: skip unembedded rows)
CREATE INDEX IF NOT EXISTS claims_embedding_hnsw
    ON claims USING hnsw (embedding vector_cosine_ops)
    WITH (m = 16, ef_construction = 200)
    WHERE embedding IS NOT NULL;

-- Trigram index for sparse/keyword search
CREATE INDEX IF NOT EXISTS claims_content_trgm
    ON claims USING gin (content gin_trgm_ops);

-- FSR scheduling index
CREATE INDEX IF NOT EXISTS claims_fsrs_due
    ON claims (fsrs_due)
    WHERE deleted_at IS NULL;
