package routers

import (
	"godly/middleware/jwt"
	"godly/routers/api/test"

	"github.com/gin-gonic/gin"
)

func InitRouter() *gin.Engine {
	r := gin.New()
	r.Use(gin.Logger())
	r.Use(gin.Recovery())
	apiNoAuth := r.Group("/api")
	{
		/**不需要token**/
		apiNoAuth.GET("login", tokentest.Login)
	}

	apiAuth := r.Group("/Auth/api")
	apiAuth.Use(jwt.JWTAuth())
	{
		/**
			需要token 认证
		**/
		apiAuth.GET("isvailde", tokentest.Auton)

	}
	return r
}
