-- +goose Up
-- +goose StatementBegin
-- Create the exercises table to store exercise information.
CREATE TABLE exercises (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
-- +goose StatementEnd


-- +goose Down
-- +goose StatementBegin
DROP TABLE exercises;
-- +goose StatementEnd
