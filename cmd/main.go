package main

import (
	"flag"
	"fmt"
	"log/slog"
	"net/http"
	"os"

	"github.com/ajfriesen/fitlib/cmd/build"
	database "github.com/ajfriesen/fitlib/cmd/queries"
	"github.com/ajfriesen/fitlib/templates"
	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	"github.com/joho/godotenv"
)

type application struct {
	logger                  *slog.Logger
	exerciseService         *ExerciseService
	ExerciseTrackingService *ExerciseTrackingService
	queries                 *database.Queries
}

func main() {

	fmt.Println("build.Time:\t", build.BuildTime)

	logger := slog.New(slog.NewTextHandler(os.Stdout, nil))

	addr := flag.String("addr", "127.0.0.1:8080", "HTTP network address")
	// DSN is the PostgreSQL Data Source Name, Database Source Name.
	// Often the same as connection string.
	println("")
	// csrfKey := flag.String("csrf-key", defaultCsrfKey, "CSRF key. Must be 32 bytes long.")
	// csrfSecureBool := flag.Bool("csrf-secure", false, "CSRF secure bool. Defaults to false for development")
	envFilePath := flag.String("envFilePath", ".env", "Filepath the .env")
	err := godotenv.Load(*envFilePath)
	if err != nil {
		logger.Error("Serror loading .env file", err)
	}
	dsn := os.Getenv("DSN")
	println("DSN from main:", dsn)
	flag.Parse()

	app := &application{
		logger: logger,
	}

	logger.Info("connect to database")

	// Ping the database to check if the connection is working
	conn, err := app.openDBConnectionPool(dsn)
	if err != nil {
		app.logger.Error("Unable to connect to database: %v\n", err)
		os.Exit(1)
	}
	defer conn.Close()

	queries := database.New(conn)

	app.queries = queries
	app.exerciseService = &ExerciseService{Queries: queries}

	app.migrateDatabase(dsn)

	r := chi.NewRouter()
	r.Use(middleware.Logger)
	// r.Use(middleware.Recoverer)

	r.Get("/", app.homeHandler)
	r.Post("/track/{id}", app.trackExerciseHandlerPost)

	r.Get("/exercise/create", app.ExerciseCreate)
	r.Post("/exercise/create", app.ExerciseCreatePost)

	r.Get("/history", app.ExerciseHistory)

	fileServer := http.FileServer(http.FS(templates.Templates))

	r.Handle("/static/*", http.StripPrefix("/static", fileServer))

	httpServer := &http.Server{
		Addr:    *addr,
		Handler: r,
	}

	logger.Info("starting server", "addr", *addr)
	err = httpServer.ListenAndServe()
	if err != nil {
		logger.Error("error starting server", err.Error())
		os.Exit(1)

	}

}
