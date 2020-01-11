package tokentest

import (
	"godly/model/user"
	"godly/pkg/logger"
	"godly/pkg/response"

	"github.com/gin-gonic/gin"
)

type LoginDemo struct {
	User     string `form:"user"   binding:"required"`
	Password string `form:"password"  binding:"required"`
}

func Login(c *gin.Context) {
	res := response.Gin{C: c}
	var json LoginDemo
	if err := c.ShouldBind(&json); err != nil {
		res.ErrorMsg("", err.Error())
		return
	}

	users := user.User{Username: json.User}
	token, errse := users.GetUserInfo()
	if errse != nil {
		res.ErrorMsg("", errse.Error())
		logger.LoggerInfo(errse.Error())
		return
	}
	res.SuccessMsg(token, users)

}

func Auton(c *gin.Context) {
	response := response.Gin{C: c}
	// claims := c.MustGet("claims").(*pkgutils.CustomClaims)
	// if claims != nil {
	response.SuccessMsg("", "")
	//}

}
