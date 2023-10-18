package controllers

import (
	"github.com/ajfriesen/fitlib/models"
)

type CreateExerciseInput struct {
	Name        string `json:"name" binding:"required"`
	Description string `json:"description" binding:"required"`
}

// Create exercise
func CreateExercise(input CreateExerciseInput) (models.Exercise, error) {
	exercise := models.Exercise{
		Name:        input.Name,
		Description: input.Description,
	}

	err := models.DB.Create(&exercise).Error
	return exercise, err
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

// find exercise by id
func FindExerciseByID(id string) (models.Exercise, error) {
	var exercise models.Exercise
	err := models.DB.First(&exercise, id).Error
	return exercise, err
}

// delete exercise by exercise struct
func DeleteExercise(exercise models.Exercise) error {
	err := models.DB.Delete(&exercise, exercise).Error
	return err
}

// update exercise by exercise struct and input struct
func UpdateExercise(exercise *models.Exercise, input *CreateExerciseInput) error {
	exercise.Name = input.Name
	exercise.Description = input.Description

	err := models.DB.Save(&exercise).Error
	return err
}
