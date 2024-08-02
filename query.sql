-- name: GetAllExercises :many
SELECT * FROM exercises;

-- name: InsertExercise :one
INSERT INTO exercises
(name, description, created_at, updated_at)
VALUES (?, ?, ?, ?)
RETURNING id;

-- name: InsertTrackedExercise :one
INSERT INTO workout_logs
(exercise_id, timestamp, reps, time_seconds)
VALUES (?, ?, ?, ?)
RETURNING *;

-- name: GetTrackedExercises :one
SELECT et.*, e.name AS exercise_name
FROM workout_logs et
JOIN exercises e ON et.exercise_id = e.id;