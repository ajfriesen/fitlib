-- name: GetAllExercises :many
SELECT * FROM exercises;

-- name: InsertExercise :one
INSERT INTO exercises
(name, description, created_at, updated_at)
VALUES (?, ?, ?, ?)
RETURNING id;

-- name: InsertTrackedExercise :one
INSERT INTO exercise_tracking
(exercise_id, reps, notes)
VALUES (?, ?, ?)
RETURNING *;

-- name: GetTrackedExercises :one
SELECT et.*, e.name AS exercise_name
FROM exercise_tracking et
JOIN exercises e ON et.exercise_id = e.id;