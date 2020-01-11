package response

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type Gin struct {
	C *gin.Context
}

type Response struct {
	Code int         `json:"code"`
	Msg  string      `json:"msg"`
	Data interface{} `json:"data"`
}

func (g *Gin) SuccessMsg(errMsg string, data interface{}) {
	g.C.JSON(http.StatusOK, Response{
		Code: 200,
		Msg:  errMsg,
		Data: data,
	})
	g.C.Abort()
	return
}
func (g *Gin) ErrorMsg(errMsg string, data interface{}) {
	g.C.JSON(http.StatusOK, Response{
		Code: 500,
		Msg:  errMsg,
		Data: data,
	})
	g.C.Abort()
	return
}
