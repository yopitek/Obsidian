-- gx10/migrations/002_indexes_and_constraints.sql
-- Additional indexes and constraints not included in the initial schema

-- claims: index on pack_id (core read-path filter)
CREATE INDEX IF NOT EXISTS claims_pack_id_idx ON claims(pack_id);

-- claims: index on source_id (non-null only)
CREATE INDEX IF NOT EXISTS claims_source_id_idx ON claims(source_id)
    WHERE source_id IS NOT NULL;

-- knowledge_edges: reverse-direction traversal (HFQ graph expansion)
CREATE INDEX IF NOT EXISTS knowledge_edges_to_claim_idx
    ON knowledge_edges(to_claim);

-- kal_jobs: partial index on status for active jobs
CREATE INDEX IF NOT EXISTS kal_jobs_status_idx ON kal_jobs(status)
    WHERE status NOT IN ('done', 'failed');

-- kal_jobs: add CHECK constraint on status values
-- Using DO block for compatibility with PG16
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint c
        JOIN pg_class t ON c.conrelid = t.oid
        JOIN pg_namespace n ON t.relnamespace = n.oid
        WHERE c.conname = 'kal_jobs_status_check'
          AND t.relname = 'kal_jobs'
          AND n.nspname = 'public'
    ) THEN
        ALTER TABLE kal_jobs
            ADD CONSTRAINT kal_jobs_status_check
            CHECK (status IN ('queued', 'processing', 'extracted', 'round-1', 'round-2', 'round-3', 'round-4', 'round-5', 'done', 'failed'));
    END IF;
END $$;

-- claims: range constraint on confidence column
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint c
        JOIN pg_class t ON c.conrelid = t.oid
        JOIN pg_namespace n ON t.relnamespace = n.oid
        WHERE c.conname = 'claims_confidence_check'
          AND t.relname = 'claims'
          AND n.nspname = 'public'
    ) THEN
        ALTER TABLE claims
            ADD CONSTRAINT claims_confidence_check
            CHECK (confidence BETWEEN 0.0 AND 1.0);
    END IF;
END $$;

-- knowledge_edges: positive weight constraint
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint c
        JOIN pg_class t ON c.conrelid = t.oid
        JOIN pg_namespace n ON t.relnamespace = n.oid
        WHERE c.conname = 'knowledge_edges_weight_check'
          AND t.relname = 'knowledge_edges'
          AND n.nspname = 'public'
    ) THEN
        ALTER TABLE knowledge_edges
            ADD CONSTRAINT knowledge_edges_weight_check
            CHECK (weight > 0);
    END IF;
END $$;
