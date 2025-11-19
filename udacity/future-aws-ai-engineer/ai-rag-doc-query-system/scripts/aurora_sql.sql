"CREATE EXTENSION IF NOT EXISTS vector;"
"CREATE SCHEMA IF NOT EXISTS bedrock_integration;",
"DO $$ BEGIN CREATE ROLE bedrock_user LOGIN; EXCEPTION WHEN duplicate_object THEN RAISE NOTICE 'Role already exists'; END $$;",
"GRANT ALL ON SCHEMA bedrock_integration to bedrock_user;",
"SET SESSION AUTHORIZATION bedrock_user;",
"""
CREATE TABLE IF NOT EXISTS bedrock_integration.bedrock_kb (
    id uuid PRIMARY KEY,
    embedding vector(1536),
    chunks text,
    metadata json
);
""",
"CREATE INDEX IF NOT EXISTS bedrock_kb_embedding_idx ON bedrock_integration.bedrock_kb USING hnsw (embedding vector_cosine_ops);",
-- Create a GIN index on the chunks column for full-text search new api
"""
CREATE INDEX IF NOT EXISTS bedrock_kb_chunks_gin_idx
ON bedrock_integration.bedrock_kb
USING gin (to_tsvector('simple', chunks));
"""




-- QUERY BUILDER SCRIPT FOR AURORA POSTGRESQL WITH PGVECTOR AND BEDROCK INTEGRATION

-- -- Enable pgvector extension (requires appropriate privileges)
-- CREATE EXTENSION IF NOT EXISTS vector;

-- -- Create schema for Bedrock integration
-- CREATE SCHEMA IF NOT EXISTS bedrock_integration;

-- -- Create role if it doesn't already exist
-- DO $$ BEGIN CREATE ROLE bedrock_user LOGIN; EXCEPTION WHEN duplicate_object THEN RAISE NOTICE 'Role already exists'; END $$;

-- -- Grant schema privileges to the role
-- GRANT ALL ON SCHEMA bedrock_integration TO bedrock_user;

-- -- (Optional) Run the rest of the session as bedrock_user
-- -- This may require superuser/rds_superuser privileges
-- SET SESSION AUTHORIZATION bedrock_user;

-- -- Create the table to store embeddings and chunks
-- CREATE TABLE IF NOT EXISTS bedrock_integration.bedrock_kb (
--     id uuid PRIMARY KEY,
--     embedding vector(1536),
--     chunks text,
--     metadata json
-- );

-- -- Create an HNSW index on the embedding column using cosine distance
-- CREATE INDEX IF NOT EXISTS bedrock_kb_embedding_idx
-- ON bedrock_integration.bedrock_kb
-- USING hnsw (embedding vector_cosine_ops);

-- NOTE: AWS scriptting environment

-- If CREATE EXTENSION or CREATE ROLE fails with a permission error, that means your Query Editor connection user isn’t a superuser / rds_superuser.

-- You may need to run those lines as the master user, or have your instructor/lab already set them up.

-- If SET SESSION AUTHORIZATION bedrock_user; errors, just comment it out and rerun from the CREATE TABLE part down._

