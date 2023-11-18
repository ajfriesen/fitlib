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
	ID           int `db:"id"`
	ExerciseID   int `db:"exercise_id"`
	ExerciseName string
	Date         time.Time `db:"date"`
	Timestamp    time.Time `db:"timestamp"`
	Reps         int       `db:"reps"`
	Notes        string    `db:"notes"`
	CreatedAt    time.Time `db:"created_at"`
	UpdatedAt    time.Time `db:"updated_at"`
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
		&trackedExercise.Timestamp,
		&trackedExercise.Reps,
		&trackedExercise.Notes,
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

func (e *ExerciseTrackingService) GetTrackedExercises() ([]ExerciseTracking, error) {
	// sql := `SELECT * FROM exercise_tracking`
	sql := `SELECT et.*, e.name AS exercise_name
			FROM exercise_tracking et
			JOIN exercises e ON et.exercise_id = e.id`
	// (exercise_id, reps, notes)
	// VALUES (@exerciseID, @reps, @notes)`

	// args := pgx.NamedArgs{
	// 	"exerciseID": exerciseID,
	// 	"reps":       reps,
	// 	"notes":      notes,
	// }

	rows, err := e.DB.Query(context.Background(), sql)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	trackedExerciseList := []ExerciseTracking{}

	for rows.Next() {
		trackedExercise := ExerciseTracking{}
		err = rows.Scan(
			&trackedExercise.ID,
			&trackedExercise.ExerciseID,
			&trackedExercise.Date,
			&trackedExercise.Timestamp,
			&trackedExercise.Reps,
			&trackedExercise.Notes,
			&trackedExercise.CreatedAt,
			&trackedExercise.UpdatedAt,
			&trackedExercise.ExerciseName,
		)
		if err != nil {
			return nil, err
		}
		trackedExerciseList = append(trackedExerciseList, trackedExercise)
	}

	return trackedExerciseList, nil

}
