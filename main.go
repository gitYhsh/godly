package main

import (
	"fmt"
	config "godly/config"

	"godly/middleware"

	"github.com/gin-gonic/gin"
)

func main() {

	r := gin.Default()

	r.Use(middleware.LoggerToFile())

	/**初始化配置**/
	config.Init()

	// var data = "1111"
	// errpr := utils.StringSet("accdess", data)

	// fmt.Println("设置的数据:", errpr)

	// var token string
	// err := utils.StringGet("accdess_token", &token)
	// if err == nil {
	// 	//fmt.Println("获取的数据:", token)
	// }

	type Users struct {
		Userid   string `gorm:"user_id"`
		Username string `gorm:"username"`
		Nickname string `gorm:"nickname"`
	}
	var usersde Users

	Db := config.GetDbCon()

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
		Db.Table("t_user").First(&usersde, "user_id=?", "0101695108880048494")
		fmt.Println("获取的数据:", usersde.Nickname)
	})
	r.Run()
}
