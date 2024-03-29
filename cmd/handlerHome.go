package main

import (
	"fmt"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
)

func (app *application) homeHandler(w http.ResponseWriter, r *http.Request) {
	data := app.newTemplateData(r)

	exercises, err := app.exerciseService.GetAllExercises()
	if err != nil {
		app.serveError(w, r, err)
		return
	}
	data.Exercises = exercises
	app.renderTemplate(w, r, http.StatusOK, "home.html", data)
}

func (app *application) trackExerciseHandlerPost(w http.ResponseWriter, r *http.Request) {

	data := app.newTemplateData(r)

	exerciseIDURL := chi.URLParam(r, "id")

	println("exerciseIDURL: ", exerciseIDURL)

	err := r.ParseForm()
	if err != nil {
		app.clientError(w, http.StatusBadRequest)
		return
	}

	println("r.Form: ", r.Form)

	// reps := r.Form.Get("reps")

	if err != nil {
		app.clientError(w, http.StatusBadRequest)
		return
	}

	notes := r.Form.Get("notes")
	exerciseID, err := strconv.Atoi(r.Form.Get("id"))
	if err != nil {
		app.clientError(w, http.StatusBadRequest)
		return
	}

	reps, err := strconv.Atoi(r.Form.Get("reps"))
	if err != nil {
		app.clientError(w, http.StatusBadRequest)
		return
	}

	trackedExercise, err := app.ExerciseTrackingService.TrackExercises(exerciseID, reps, notes)
	if err != nil {
		app.serveError(w, r, err)
		return
	}

	fmt.Printf("trackedExercise: %v", trackedExercise)

	// formResponse := Response{
	// 	FormID:   formID,
	// 	Name:     r.Form.Get("name"),
	// 	LastName: r.Form.Get("last_name"),
	// }
	// fmt.Printf("FormResponse: %v \n", formResponse)

	// Somehow move the formResponse into a struct which represents the database layer:
	// In this case responseData

	// responseSQL := models.Response{
	// 	FormID:       formResponse.FormID,
	// 	QuestionID:   formResponse.QuestionID,
	// 	ResponseText: formResponse.Name,
	// }

	// fmt.Printf("responseSQL: %v \n", responseSQL)

	// err = app.formService.InsertResponse(responseSQL)
	// if err != nil {
	// 	app.serveError(w, err)
	// 	return

	println("reps: ", reps)
	println("notes: ", notes)
	println("exerciseID: ", exerciseID)

	app.renderTemplate(w, r, http.StatusOK, "home.html", data)

}

type exerciseCreateData struct {
	Name        string
	Description string
}

func (app *application) ExerciseCreate(w http.ResponseWriter, r *http.Request) {
	data := app.newTemplateData(r)
	data.Form = exerciseCreateData{}
	app.renderTemplate(w, r, http.StatusOK, "exercise-create.html", data)

}

func (app *application) ExerciseCreatePost(w http.ResponseWriter, r *http.Request) {

	data := app.newTemplateData(r)

	err := r.ParseForm()
	if err != nil {
		app.clientError(w, http.StatusBadRequest)
		return
	}

	var exercise Exercise

	exercise.Name = r.Form.Get("Name")
	exercise.Description = r.Form.Get("Description")

	exercise.ID, err = app.exerciseService.AddExercise(exercise)
	if err != nil {
		app.serveError(w, r, err)
		return
	}

	app.renderTemplate(w, r, http.StatusOK, "home.html", data)

}

func (app *application) ExerciseHistory(w http.ResponseWriter, r *http.Request) {
	data := app.newTemplateData(r)

	trackedExercises, err := app.ExerciseTrackingService.GetTrackedExercises()
	if err != nil {
		app.serveError(w, r, err)
	}

	data.TrackedExercises = trackedExercises

	println(trackedExercises)

	app.renderTemplate(w, r, http.StatusOK, "history.html", data)
}
