-- Cloud memory tables for Supabase

CREATE TABLE IF NOT EXISTS cloud_memory (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id TEXT NOT NULL,
    memory_type TEXT NOT NULL,
    content TEXT NOT NULL,
    embedding VECTOR(1536),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    indexed BOOLEAN DEFAULT FALSE,
    checksum TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS cloud_memory_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id TEXT NOT NULL,
    operation TEXT NOT NULL,
    memory_id UUID REFERENCES cloud_memory(id) ON DELETE SET NULL,
    details JSONB,
    created_at TIMESTAMP DEFAULT NOW(),
    version INT DEFAULT 1
);

CREATE INDEX idx_cloud_memory_session ON cloud_memory(session_id);
CREATE INDEX idx_cloud_memory_type ON cloud_memory(memory_type);
CREATE INDEX idx_cloud_memory_created ON cloud_memory(created_at DESC);
CREATE INDEX idx_cloud_memory_log_session ON cloud_memory_log(session_id);
CREATE INDEX idx_cloud_memory_log_created ON cloud_memory_log(created_at DESC);

-- Row-level security (optional but recommended)
ALTER TABLE cloud_memory ENABLE ROW LEVEL SECURITY;
ALTER TABLE cloud_memory_log ENABLE ROW LEVEL SECURITY;
