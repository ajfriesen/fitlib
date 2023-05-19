package controllers

import (
	"net/http"

	"github.com/ajfriesen/fitlib/models"
	"github.com/gin-gonic/gin"
)

type CreateExerciseInput struct {
	Name        string `json:"name" binding:"required"`
	Description string `json:"description" binding:"required"`
}

// Create exercise function with html post form
func CreateExercise(c *gin.Context) {
	//validate input
	var input models.Exercise
	if err := c.Bind(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	exercise := models.Exercise{Name: input.Name, Description: input.Description}
	models.DB.Create(&exercise)

	c.JSON(http.StatusOK, gin.H{"data": exercise})
}

func GetAllExercises() []models.Exercise {
	var exercises []models.Exercise
	models.DB.Find(&exercises)
	return exercises
}

// get all doneEcercises and order them by created at
func GetAllDoneExercises() []models.DoneExercise {
	var doneExercises []models.DoneExercise
	models.DB.Order("created_at desc").Preload("Exercise").Find(&doneExercises)
	return doneExercises
}
