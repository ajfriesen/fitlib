package main

import (
	"database/sql"
	"time"

	_ "github.com/mattn/go-sqlite3"
)

type ExerciseTrackingService struct {
	DB *sql.DB
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

	trackedExercise, err = e.TrackExercises(exerciseID, reps, notes)
	if err != nil {
		return ExerciseTracking{}, err
	}
	return trackedExercise, err
}

func (e *ExerciseTrackingService) GetTrackedExercises() ([]ExerciseTracking, error) {

	trackedExercises, err := e.GetTrackedExercises()
	if err != nil {
		return nil, err
	}

	return trackedExercises, nil

}
