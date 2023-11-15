package main

import (
	"context"
	"fmt"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
)

type ExerciseService struct {
	DB *pgxpool.Pool
}

type Exercise struct {
	ID          int       `db:"id"`
	Name        string    `db:"name"`
	Description string    `db:"description"`
	CreatedAt   time.Time `db:"created_at"`
	UpdatedAt   time.Time `db:"updated_at"`
}

func (f *ExerciseService) GetAllExercises() ([]Exercise, error) {
	sql := `SELECT * FROM exercises`

	rows, err := f.DB.Query(context.Background(), sql)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var exercises []Exercise

	exercises, err = pgx.CollectRows(rows, pgx.RowToStructByName[Exercise])
	if err != nil {
		fmt.Printf("CollectRows error: %v", err)
		return nil, err
	}
	return exercises, nil
}

func (f *ExerciseService) AddExercise(exercise Exercise) (exerciseID int, err error) {
	sql := `INSERT INTO exercises
			(name, description, created_at, updated_at)
			VALUES (@name, @description, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
			RETURNING id`

	args := pgx.NamedArgs{
		"name":        exercise.Name,
		"description": exercise.Description,
	}

	err = f.DB.QueryRow(context.Background(), sql, args).Scan(&exerciseID)
	if err != nil {
		return 0, err
	}

	return exerciseID, nil
}
