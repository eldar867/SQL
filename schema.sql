CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    role VARCHAR(20) CHECK (role IN ('analyst', 'admin')) NOT NULL DEFAULT 'analyst',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE datasets (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    filename VARCHAR(255) NOT NULL,
    file_size_kb INTEGER CHECK (file_size_kb > 0),
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending'
);

CREATE TABLE columns (
    id SERIAL PRIMARY KEY,
    dataset_id INTEGER NOT NULL REFERENCES datasets(id) ON DELETE CASCADE,
    column_name VARCHAR(100) NOT NULL,
    detected_type VARCHAR(50),
    anonymization_method VARCHAR(50),
    is_processed BOOLEAN DEFAULT FALSE,
    UNIQUE(dataset_id, column_name)
);

CREATE TABLE processing_sessions (
    id SERIAL PRIMARY KEY,
    dataset_id INTEGER NOT NULL REFERENCES datasets(id) ON DELETE CASCADE,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP,
    rows_processed INTEGER DEFAULT 0,
    status VARCHAR(20) DEFAULT 'running'
);
