package main

import (
	"context"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

type ExerciseTrackingService struct {
	DB *pgxpool.Pool
}

type ExerciseTracking struct {
	ID         int       `db:"id"`
	ExerciseID int       `db:"exercise_id"`
	Date       time.Time `db:"date"`
	timestamp  time.Time `db:"timestamp"`
	reps       int       `db:"reps"`
	notes      string    `db:"notes"`
	CreatedAt  time.Time `db:"created_at"`
	UpdatedAt  time.Time `db:"updated_at"`
}

func (e *ExerciseTrackingService) TrackExercises(exerciseID int, reps int, notes string) (trackedExercise ExerciseTracking, err error) {
	sql := `INSERT INTO exercise_tracking
		(exercise_id, reps, notes)
		VALUES (@exerciseID, @reps, @notes)
		RETURNING id, exercise_id, date, timestamp, reps, notes, created_at, updated_at`

	args := pgx.NamedArgs{
		"exerciseID": exerciseID,
		"reps":       reps,
		"notes":      notes,
	}

	err = e.DB.QueryRow(context.Background(), sql, args).Scan(
		&trackedExercise.ID,
		&trackedExercise.ExerciseID,
		&trackedExercise.Date,
		&trackedExercise.timestamp,
		&trackedExercise.reps,
		&trackedExercise.notes,
		&trackedExercise.CreatedAt,
		&trackedExercise.UpdatedAt,
	)

	return trackedExercise, err

	// row, err := f.DB.Query(context.Background(), sql, args)
	// if err != nil {
	// 	return nil, err
	// }
	// defer row.Close()

	// trackedExercise, err = pgx.CollectRows(rows, pgx.RowToStructByName[ExerciseTracking])
	// if err != nil {
	// 	fmt.Printf("CollectRows error: %v", err)
	// 	return nil, err
	// }
	// return id, nil
}
