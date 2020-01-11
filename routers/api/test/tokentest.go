package tokentest

import (
	"godly/pkg/response"
	"godly/pkg/utils"

	"github.com/gin-gonic/gin"
)

func Login(c *gin.Context) {
	response := response.Gin{C: c}
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
	response.SuccessMsg(token, token1)

}

func Auton(c *gin.Context) {
	response := response.Gin{C: c}
	claims := c.MustGet("claims").(*pkgutils.CustomClaims)
	if claims != nil {
		response.SuccessMsg("", claims)
	}

}
