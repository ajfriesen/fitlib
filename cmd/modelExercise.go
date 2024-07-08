package main

import (
	"context"
	"database/sql"
	"time"

	database "github.com/ajfriesen/fitlib/cmd/queries"
)

type ExerciseService struct {
	Queries *database.Queries
}

type Exercise struct {
	ID          int       `db:"id"`
	Name        string    `db:"name"`
	Description string    `db:"description"`
	CreatedAt   time.Time `db:"created_at"`
	UpdatedAt   time.Time `db:"updated_at"`
}

func (f *ExerciseService) GetAllExercises() ([]database.Exercise, error) {

	var exercises []database.Exercise

	exercises, err := f.Queries.GetAllExercises(context.Background())
	if err != nil {
		return nil, err
	}

	return exercises, nil
}

func (f *ExerciseService) AddExercise(name string, description sql.NullString) (exerciseID int64, err error) {

	insertParams := database.InsertExerciseParams{
		Name:        name,
		Description: description,
	}

	exerciseID, err = f.Queries.InsertExercise(context.Background(), insertParams)
	if err != nil {
		return 0, err
	}

	return exerciseID, nil
}
