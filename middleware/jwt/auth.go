package jwt

import (
	"errors"
	"godly/pkg/response"

	"godly/pkg/utils"

	"github.com/gin-gonic/gin"
)

var (
	TokenExpired error = errors.New("Token is expired")
)

func JWTAuth() gin.HandlerFunc {

	return func(c *gin.Context) {
		response := response.Gin{C: c}

		token := c.Request.Header.Get("token")
		if token == "" {
			response.ErrorMsg("无权限访问", "")
			c.Abort()
			return
		}

		j := pkgutils.NewJWT()

		// parseToken 解析token包含的信息
		claims, err := j.ParseToken(token)
		if err != nil {
			if err == TokenExpired {
				response.ErrorMsg("授权已过期", "")
				c.Abort()
				return
			}
			response.ErrorMsg(err.Error(), "")
			c.Abort()
			return
		}
		// 继续交由下一个路由处理,并将解析出的信息传递下去
		c.Set("claims", claims)
	}
}
