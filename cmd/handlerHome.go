package main

import "net/http"

func (app *application) homeHandler(w http.ResponseWriter, r *http.Request) {
	data := app.newTemplateData(r)
	app.renderTemplate(w, http.StatusOK, "home.html", data)
}
