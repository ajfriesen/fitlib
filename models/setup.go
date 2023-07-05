// models/setup.go

package models

import (
	"fmt"

	"gorm.io/driver/sqlite"
	_ "gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

var DB *gorm.DB

func ConnectDatabase() {

	database, err := gorm.Open(sqlite.Open("test.db"), &gorm.Config{})

	if err != nil {
		panic("Failed to connect to database!")
	}

	err = database.AutoMigrate(&Exercise{}, &DoneExercise{}, &Equipment{})
	if err != nil {
		return
	}

	fmt.Println("Database successfully connected")

	fmt.Println("Database migrated")

	DB = database
}
