-- +goose Up
-- +goose StatementBegin
INSERT INTO exercises (
    name,
    description,
    created_at,
    updated_at
    )
    VALUES (
        'Pull Ups',
        'Hochziehen an Ringen',
        NOW(),
        NOW()
);

INSERT INTO exercises (
    name,
    description,
    created_at,
    updated_at
    )
    VALUES (
        'Push Ups',
        'Liegestütze',
        NOW(),
        NOW()
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DELETE FROM exercises ;
-- +goose StatementEnd
