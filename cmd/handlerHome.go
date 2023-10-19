package main

import "net/http"

func (app *application) homeHandler(w http.ResponseWriter, r *http.Request) {
	data := app.newTemplateData(r)

	exercises, err := app.exerciseService.GetAllExercises()
	if err != nil {
		app.serveError(w, err)
		return
	}
	data = &templateData{
		Exercises: exercises,
	}
	app.renderTemplate(w, http.StatusOK, "home.html", data)
}
