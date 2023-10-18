package main

import (
	"bytes"
	"fmt"
	"html/template"
	"net/http"
	"path/filepath"
)

// FormData is an interface that we can use to pass data to our html templates
// This was any. But with any we could not pass a struct to the template and iterate over it.
// So we created this interface
type FormData interface{}

// templateData is a strcut to hold the data that we want to pass to our html templates like a list of users
type templateData struct {
	// Studios         []*models.Studio
	// Studio          *models.Studio
	// User            *models.User
	Form            FormData
	CSRFToken       string
	IsAuthenticated bool
	ResetToken      string
}

// handle the home page and render the home template
func (app *application) renderTemplate(w http.ResponseWriter, status int, page string, data interface{}) {

	templates, ok := app.templateCache[page]
	if !ok {
		err := fmt.Errorf("the template %s does not exist", page)
		app.serveError(w, err)
		return
	}

	// Create a buffer so we can catch any errors from the template rendering
	buffer := new(bytes.Buffer)

	println("renderTemplate: page: ", page)

	// Write the template to the buffer, instead of straight to the http.ResponseWriter.
	err := templates.ExecuteTemplate(buffer, "base", data)
	if err != nil {
		app.serveError(w, err)
		return
	}

	w.WriteHeader(status)

	// Write the buffer to the http.ResponseWriter
	buffer.WriteTo(w)

}

func newTemplateCache() (map[string]*template.Template, error) {
	cache := map[string]*template.Template{}

	pages, err := filepath.Glob(templateDir + "*.html")
	if err != nil {
		return nil, err
	}

	for _, page := range pages {
		// Extract filename
		name := filepath.Base(page)

		files := []string{
			templateDir + "base.html",
			// templateDir + "partials/navbar.html",
			page,
		}

		//Parse files into templates
		ts, err := template.ParseFiles(files...)
		if err != nil {
			return nil, err
		}

		cache[name] = ts
	}

	return cache, nil

}
