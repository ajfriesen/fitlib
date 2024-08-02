-- +goose Up
-- +goose StatementBegin
-- Create a table to track exercises.
CREATE TABLE workout_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    exercise_id INT REFERENCES exercises(id) NOT NULL,
    timestamp TEXT DEFAULT CURRENT_TIMESTAMP NOT NULL,
    reps INT,
    time_seconds INT
)
strict;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE workout_logs;
-- +goose StatementEnd
