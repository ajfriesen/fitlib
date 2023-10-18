package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/ajfriesen/fitlib/migrations"
	"github.com/jackc/pgx/v5/pgxpool"
	_ "github.com/jackc/pgx/v5/stdlib"
	"github.com/pressly/goose/v3"
)

func openDbConnectionPool(dsn string) (*pgxpool.Pool, error) {
	connectionPool, err := pgxpool.New(context.Background(), dsn)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
		return nil, err
	}

	return connectionPool, nil
}

func migrateDatabase(dsn string) {

	goose.SetBaseFS(migrations.FS)

	// Ensure that we remove the FS on the off chance some other part of our app uses goose for migrations and doesn't want to use our FS.
	defer func() {
		goose.SetBaseFS(nil)
	}()

	println("Opening DB")
	sql, err := goose.OpenDBWithDriver("pgx", dsn)
	if err != nil {
		log.Fatalf(err.Error())
	}

	println("Starting database migrations")
	// This is "." due to the migrations.FS from embed.
	err = goose.Up(sql, ".")
	if err != nil {
		log.Fatalf(err.Error())
	}

}
