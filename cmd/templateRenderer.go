package main

import (
	"bytes"
	"html/template"
	"net/http"

	"github.com/ajfriesen/fitlib/templates"
)

// FormData is an interface that we can use to pass data to our html templates
// This was any. But with any we could not pass a struct to the template and iterate over it.
// So we created this interface
type FormData interface{}

// templateData is a strcut to hold the data that we want to pass to our html templates like a list of users
type templateData struct {
	Exercises []Exercise
	// Studio          *models.Studio
	// User            *models.User
	Form            FormData
	CSRFToken       string
	IsAuthenticated bool
	ResetToken      string
}

// handle the home page and render the home template
func (app *application) renderTemplate(w http.ResponseWriter, r *http.Request, status int, page string, data interface{}) {

	// Parse the template files from the embed.FS
	templates, err := template.ParseFS(
		templates.Templates,
		"html/base.html",
		"html/partials/navbar.html",
		"html/"+page,
	)
	if err != nil {
		app.serveError(w, r, err)
		return
	}

	// Create a buffer so we can catch any errors from the template rendering
	buffer := new(bytes.Buffer)

	println("renderTemplate: page: ", page)

	// Write the template to the buffer, instead of straight to the http.ResponseWriter.
	err = templates.ExecuteTemplate(buffer, "base", data)
	if err != nil {
		app.serveError(w, r, err)
		return
	}

	w.WriteHeader(status)

	// Write the buffer to the http.ResponseWriter
	buffer.WriteTo(w)

}
