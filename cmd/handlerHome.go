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
		app.serveError(w, err)
		return
	}
	data = &templateData{
		Exercises: exercises,
	}
	app.renderTemplate(w, http.StatusOK, "home.html", data)
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
		app.serveError(w, err)
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

	app.renderTemplate(w, http.StatusOK, "home.html", data)

}
