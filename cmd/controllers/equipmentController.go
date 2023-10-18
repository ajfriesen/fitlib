package controllers

import (
	"github.com/ajfriesen/fitlib/models"
)

type CreateEquipmentInput struct {
	Name string `json:"name" binding:"required"`
}

func GetAllEquipment() []models.Equipment {
	var Equipments []models.Equipment
	models.DB.Find(&Equipments)
	return Equipments
}
