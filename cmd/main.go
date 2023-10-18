package main

import (
	"flag"
	"html/template"
	"log"
	"net/http"
	"os"

	"github.com/go-chi/chi/middleware"
	"github.com/go-chi/chi/v5"
)

const templateDir = "./ui/html/"

type application struct {
	errorLog      *log.Logger
	infoLog       *log.Logger
	templateCache map[string]*template.Template
}

func main() {

	addr := flag.String("addr", "127.0.0.1:8080", "HTTP network address")
	staticDir := flag.String("static-dir", "./ui/static", "Path to static assets")
	// DSN is the PostgreSQL Data Source Name, Database Source Name.
	// Often the same as connection string.
	println("")
	// dsn := flag.String("dsn", "postgres://postgres:password@127.0.0.1:5555/plazet", "PostgreSQL data source name")
	// csrfKey := flag.String("csrf-key", defaultCsrfKey, "CSRF key. Must be 32 bytes long.")
	// csrfSecureBool := flag.Bool("csrf-secure", false, "CSRF secure bool. Defaults to false for development")
	flag.Parse()

	infoLog := log.New(os.Stdout, "INFO\t", log.Ldate|log.Ltime)
	errorLog := log.New(os.Stderr, "ERROR\t", log.Ldate|log.Ltime|log.Lshortfile)

	templateCache, err := newTemplateCache()
	if err != nil {
		errorLog.Fatal(err)
	}

	app := &application{
		infoLog:       infoLog,
		errorLog:      errorLog,
		templateCache: templateCache,
	}

	r := chi.NewRouter()
	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)
	r.Use(middleware.URLFormat)

	r.Get("/", app.homeHandler)

	staticFilesDir := http.Dir(*staticDir)
	fileServer(r, "/static", staticFilesDir)

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
