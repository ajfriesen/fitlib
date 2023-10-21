-- +goose Up
-- +goose StatementBegin
-- Create a table to track exercises.
CREATE TABLE exercise_tracking (
    id SERIAL PRIMARY KEY,
    exercise_id INT REFERENCES exercises(id) NOT NULL,
    date DATE DEFAULT CURRENT_DATE,
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    reps INT,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()-- +goose StatementEnd
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE exercise_tracking;
-- +goose StatementEnd
