package main

import (
	"fmt"
	"net/http"
	"strconv"

	"github.com/ajfriesen/fitlib/controllers"
	"github.com/ajfriesen/fitlib/models"
	"github.com/gin-gonic/gin"
)

func main() {

	r := gin.Default()
	r.LoadHTMLGlob("views/*")

	r.GET("/", func(c *gin.Context) {
		c.HTML(200, "index.html", gin.H{
			"title": "fitlib!",
		})
	})

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	// create a new exercise view and get the data from the post request from a html form

	r.GET("/add", func(c *gin.Context) {
		c.HTML(200, "addExercise.html", gin.H{})
	})

	r.POST("/exercise/:id/delete", func(c *gin.Context) {
		var exercise models.Exercise
		if err := models.DB.Where("id = ?", c.Param("id")).First(&exercise).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Record not found!"})
			return
		}
		models.DB.Delete(&exercise)

		c.Redirect(http.StatusSeeOther, "/exercises")
	})

	// Get exercise by id
	r.GET("/exercise/:id", func(c *gin.Context) {
		var exercise models.Exercise
		if err := models.DB.Where("id = ?", c.Param("id")).First(&exercise).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Record not found!"})
			return
		}

		exerciseMap := make(map[string]interface{})
		exerciseMap["ID"] = exercise.ID
		exerciseMap["Name"] = exercise.Name
		exerciseMap["Description"] = exercise.Description
		exerciseMap["Equipment"] = exercise.Equipment

		c.HTML(http.StatusOK, "exerciseDetail.html", gin.H{"exercise": exerciseMap})

	})

	r.GET("/exercise/:id/edit", func(c *gin.Context) {
		var exercise models.Exercise
		if err := models.DB.Where("id = ?", c.Param("id")).First(&exercise).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Record not found!"})
			return
		}

		// validate input
		var input models.Exercise
		if err := c.ShouldBind(&input); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		models.DB.Model(&exercise).Updates(input)

		c.HTML(http.StatusOK, "exerciseEdit.html", gin.H{"exercise": exercise})
	})

	// Update exercise by id
	r.POST("/exercise/:id/update", func(c *gin.Context) {
		var exercise models.Exercise
		if err := models.DB.Where("id = ?", c.Param("id")).First(&exercise).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Record not found!"})
			return
		}

		// validate input
		var input models.Exercise
		if err := c.ShouldBind(&input); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		models.DB.Model(&exercise).Updates(input)

		c.HTML(http.StatusOK, "exerciseAdd", gin.H{"data": exercise})

		// format exericse.ID to a string

		exerciseID := strconv.FormatUint(uint64(exercise.ID), 10)

		c.Redirect(http.StatusSeeOther, "/exercise/"+exerciseID)
	})

	r.GET("/exercises", func(c *gin.Context) {
		exercises := controllers.GetAllExercises()
		c.HTML(http.StatusOK, "exercises.html", gin.H{
			"exercises": exercises,
		})

	})

	r.POST("/add", func(c *gin.Context) {

		//validate input
		var input models.Exercise
		if err := c.ShouldBind(&input); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		// create exercise
		if result := models.DB.Create(&input); result.Error != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": result.Error.Error()})
			return
		}

		// controllers.CreateExercise(c)
		c.JSON(http.StatusOK, gin.H{"status": "Exercise created successfully"})

	})

	r.GET("/tracked", func(c *gin.Context) {
		exercises := controllers.GetAllDoneExercises()
		c.HTML(http.StatusOK, "tracked.html", gin.H{
			"exercises": exercises,
		})

		fmt.Printf("exercises: %v\n", exercises)

		// print all exerciseID from exercises
		for _, exercise := range exercises {
			fmt.Printf("exerciseID: %v\n", exercise.Exercise.Name)
		}

	})

	r.GET("/track", func(c *gin.Context) {
		exerciseList := controllers.GetAllExercises()
		c.HTML(200, "trackExercise.html", gin.H{"exerciseList": exerciseList})
	})

	r.POST("/track", func(c *gin.Context) {
		var input models.DoneExercise

		// parse form data into input

		if err := c.ShouldBind(&input); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		fmt.Printf("Input json: %v\n", input)

		// create exercise with input and save to db
		if result := models.DB.Create(&input); result.Error != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": result.Error.Error()})
			return
		}

		c.Redirect(http.StatusSeeOther, "/tracked")
	})

	r.POST("/tracked/:id/delete", func(c *gin.Context) {
		var exercise models.DoneExercise
		if err := models.DB.Where("id = ?", c.Param("id")).First(&exercise).Error; err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Record not found!"})
			return
		}
		models.DB.Delete(&exercise)

		c.Redirect(http.StatusSeeOther, "/tracked")
	})

	// func parseUint(str string) uint {
	// 	val, _ := strconv.ParseUint(str, 10, 0)
	// 	return uint(val)
	// }

	// create exercise

	models.ConnectDatabase() // new

	r.Run() // listen and serve on 0.0.0.0:8080
}
