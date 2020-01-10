package tokentest

import (
	"godly/pkg/response"
	"godly/pkg/utils"

	"github.com/gin-gonic/gin"
)

type LoginDemo struct {
	User     string `form:"user"   binding:"required"`
	Password string `form:"password"  binding:"required"`
}

func Login(c *gin.Context) {
	response := response.Gin{C: c}
	var json LoginDemo
	if err := c.ShouldBind(&json); err != nil {
		response.ErrorMsg("", err)
		return
	}

	j := pkgutils.NewJWT()
	claims := pkgutils.CustomClaims{
		"11111", "杨洪升",
		pkgutils.Clmin(),
	}

	token, err := j.CreateToken(claims)

	if err != nil {
		response.ErrorMsg(err.Error(), "")
		return
	}
	response.SuccessMsg(token, "")

}

func Auton(c *gin.Context) {
	response := response.Gin{C: c}
	claims := c.MustGet("claims").(*pkgutils.CustomClaims)
	if claims != nil {
		response.SuccessMsg("", claims)
	}

}
