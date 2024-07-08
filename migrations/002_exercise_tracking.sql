-- +goose Up
-- +goose StatementBegin
-- Create a table to track exercises.
CREATE TABLE workout_logs (
    id SERIAL PRIMARY KEY,
    exercise_id INT REFERENCES exercises(id) NOT NULL,
    date TEXT DEFAULT CURRENT_TIMESTAMP,
    timestamp TEXT DEFAULT CURRENT_TIMESTAMP,
    reps INT,
    notes TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE workout_logs;
-- +goose StatementEnd
