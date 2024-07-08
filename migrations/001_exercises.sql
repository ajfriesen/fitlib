-- +goose Up
-- +goose StatementBegin
-- Create the exercises table to store exercise information.
CREATE TABLE exercises (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP NOT NULL
)
strict;
-- +goose StatementEnd


-- +goose Down
-- +goose StatementBegin
DROP TABLE exercises;
-- +goose StatementEnd
