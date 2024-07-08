package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	"github.com/ajfriesen/fitlib/migrations"
	_ "github.com/mattn/go-sqlite3"
	"github.com/pressly/goose/v3"
)

func (app *application) openDBConnectionPool(dsn string) (*sql.DB, error) {
	db, err := sql.Open("sqlite3", dsn)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
		return nil, err
	}

	err = db.Ping()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Unable to ping the database: %v\n", err)
		return nil, err
	}

	return db, nil
}

func (app *application) migrateDatabase(dsn string) {

	goose.SetBaseFS(migrations.FS)

	// Ensure that we remove the FS on the off chance some other part of our app uses goose for migrations and doesn't want to use our FS.
	defer func() {
		goose.SetBaseFS(nil)
	}()

	println("Opening DB")
	sql, err := sql.Open("sqlite3", dsn)
	if err != nil {
		log.Fatalf(err.Error())
	}

	println("Starting database migrations")
	// This is "." due to the migrations.FS from embed.
	err = goose.Up(sql, ".")
	if err != nil {
		println("goose up failed", err)
		log.Fatalf(err.Error())
	}

}
