-- +goose Up

-- Create the exercises table to store exercise information.
CREATE TABLE exercises (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create the equipment table to store information about exercise equipment.
CREATE TABLE equipment (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create a junction table to associate exercises with equipment.
CREATE TABLE exercise_equipment (
    id SERIAL PRIMARY KEY,
    exercise_id INT REFERENCES exercises(id),
    equipment_id INT REFERENCES equipment(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create a table to track exercises.
CREATE TABLE exercise_tracking (
    id SERIAL PRIMARY KEY,
    exercise_id INT REFERENCES exercises(id),
    date DATE,
    sets INT,
    reps INT,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
-- +goose Down
DROP TABLE exercise_tracking;
DROP TABLE exercise_equipment;
DROP TABLE exercises;
DROP TABLE equipment;
