-- gx10/migrations/002_indexes_and_constraints.sql
-- Additional indexes and constraints not included in the initial schema

-- claims: index on pack_id (core read-path filter)
CREATE INDEX IF NOT EXISTS claims_pack_id_idx ON claims(pack_id);

-- claims: index on source_id (non-null only)
CREATE INDEX IF NOT EXISTS claims_source_id_idx ON claims(source_id)
    WHERE source_id IS NOT NULL;

-- kal_jobs: partial index on status for active jobs
CREATE INDEX IF NOT EXISTS kal_jobs_status_idx ON kal_jobs(status)
    WHERE status IN ('queued', 'processing');

-- kal_jobs: add CHECK constraint on status values
-- Using DO block for compatibility with PG16
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'kal_jobs_status_check'
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
        SELECT 1 FROM pg_constraint WHERE conname = 'claims_confidence_check'
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
        SELECT 1 FROM pg_constraint WHERE conname = 'knowledge_edges_weight_check'
    ) THEN
        ALTER TABLE knowledge_edges
            ADD CONSTRAINT knowledge_edges_weight_check
            CHECK (weight > 0);
    END IF;
END $$;
