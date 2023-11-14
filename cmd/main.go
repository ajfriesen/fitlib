package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/ajfriesen/fitlib/cmd/build"
	"github.com/ajfriesen/fitlib/templates"
	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
)

type application struct {
	errorLog                *log.Logger
	infoLog                 *log.Logger
	exerciseService         *ExerciseService
	ExerciseTrackingService *ExerciseTrackingService
}

func main() {

	fmt.Println("build.Time:\t", build.BuildTime)

	addr := flag.String("addr", "127.0.0.1:8080", "HTTP network address")
	// DSN is the PostgreSQL Data Source Name, Database Source Name.
	// Often the same as connection string.
	println("")
	dsn := flag.String("dsn", "postgres://postgres:password@127.0.0.1:5555/fitlib", "PostgreSQL data source name")
	// csrfKey := flag.String("csrf-key", defaultCsrfKey, "CSRF key. Must be 32 bytes long.")
	// csrfSecureBool := flag.Bool("csrf-secure", false, "CSRF secure bool. Defaults to false for development")
	flag.Parse()

	infoLog := log.New(os.Stdout, "INFO\t", log.Ldate|log.Ltime)
	errorLog := log.New(os.Stderr, "ERROR\t", log.Ldate|log.Ltime|log.Lshortfile)

	db, err := openDBConnectionPool(*dsn)
	if err != nil {
		fmt.Printf("Unable to connect to database: %v\n", err)
		os.Exit(1)
	}

	app := &application{
		infoLog:                 infoLog,
		errorLog:                errorLog,
		exerciseService:         &ExerciseService{DB: db},
		ExerciseTrackingService: &ExerciseTrackingService{DB: db},
	}

	// Ping the database to check if the connection is working
	connection, err := db.Acquire(context.Background())
	if err != nil {
		fmt.Printf("Unable to acquire connection: %v\n", err)
		os.Exit(1)
	}
	migrateDatabase(*dsn)
	defer connection.Release()
	defer db.Close()

	r := chi.NewRouter()
	r.Use(middleware.Logger)
	// r.Use(middleware.Recoverer)

	r.Get("/", app.homeHandler)
	r.Post("/track/{id}", app.trackExerciseHandlerPost)

	r.Get("/exercise/create", app.ExerciseCreate)
	r.Post("/exercise/create", app.ExerciseCreatePost)

	fileServer := http.FileServer(http.FS(templates.Templates))

	r.Handle("/static/*", http.StripPrefix("/static", fileServer))

	httpServer := &http.Server{
		Addr:     *addr,
		ErrorLog: errorLog,
		Handler:  r,
	}

	infoLog.Printf("Starting server on %s", *addr)
	err = httpServer.ListenAndServe()
	if err != nil {
		errorLog.Fatal(err)
	}

}
