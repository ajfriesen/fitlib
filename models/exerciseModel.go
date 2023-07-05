package models

import (
	"time"

	"gorm.io/gorm"
)

type Equipment struct {
	gorm.Model
	ID         uint   `gorm:"primary_key"`
	Name       string `json:"name"`
	ExerciseID uint
}

type Exercise struct {
	gorm.Model
	ID           uint   `gorm:"primary_key"`
	Name         string `json:"name"`
	Description  string `json:"description"`
	Equipment    []*Equipment
	DoneExercise []*DoneExercise
}

type DoneExercise struct {
	gorm.Model
	ID          uint `gorm:"primary_key"`
	Date        time.Time
	Quantity    int64
	Weight      float64
	Color       string
	Duration    float64
	Comment     string
	ExerciseID  uint
	Exercise    Exercise
	EquipmentID uint
	Equipment   Equipment
}
