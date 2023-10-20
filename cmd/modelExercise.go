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
