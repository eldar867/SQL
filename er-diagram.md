erDiagram
    USERS ||--o{ DATASETS : "владелец (1:N)"
    DATASETS ||--o{ COLUMNS_META : "содержит столбцы (1:N)"
    DATASETS ||--o{ PROCESSING_SESSIONS : "обрабатывается в (1:N)"

    USERS {
        int id PK
        varchar username UK
        varchar role
        timestamp created_at
    }
    DATASETS {
        int id PK
        int user_id FK
        varchar filename
        int file_size_kb
        timestamp uploaded_at
        varchar status
    }
    COLUMNS_META {
        int id PK
        int dataset_id FK
        varchar column_name
        varchar detected_type
        varchar anonymization_method
        boolean is_processed
    }
    PROCESSING_SESSIONS {
        int id PK
        int dataset_id FK
        timestamp started_at
        timestamp completed_at
        int rows_processed
        varchar status
    }
