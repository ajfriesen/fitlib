-- +goose Up
-- +goose StatementBegin
-- Create a table to track exercises.
CREATE TABLE exercise_tracking (
    id SERIAL PRIMARY KEY,
    exercise_id INT REFERENCES exercises(id) NOT NULL,
    date DATE DEFAULT CURRENT_DATE,
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    reps INT,
    duration_seconds interval, -- You can use INT for seconds or minutes, or you can use a separate column for duration in minutes
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()-- +goose StatementEnd
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE exercise_tracking;
-- +goose StatementEnd
