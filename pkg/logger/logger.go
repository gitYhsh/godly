package logger

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"time"

	"github.com/sirupsen/logrus"
)

/**
 日志,目前还没有想好怎么定义
**/
var loggger = logrus.New()

func init() {
	loggger.Out = os.Stdout

	loggger.Formatter = &logrus.JSONFormatter{
		TimestampFormat: "2006-01-02 15:04:05",
	}
	loggger.SetLevel(logrus.InfoLevel)
	//创建一个hook，将日志存储路径输入进去
	_, err := os.Stat("d:/golog.log")

	if os.IsNotExist(err) {
		os.Create("d:/golog.log")
	}
	hook := NewHook("d:/golog.log")
	loggger.AddHook(hook)

}

type errorInfo struct {
	Time     string      `json:"time"`
	Message  interface{} `json:"message"`
	Filename string      `json:"filename"`
	Line     int         `json:"line"`
	Funcname string      `json:"funcname"`
}

func loggerStout(errMsg interface{}) string {
	// 当前时间
	currentTime := time.Now().Format("2006-01-02 15:04:05")

	// 定义 文件名、行号、方法名
	fileName, line, functionName := "?", 0, "?"

	pc, fileName, line, ok := runtime.Caller(2)
	if ok {
		functionName = runtime.FuncForPC(pc).Name()
		functionName = filepath.Ext(functionName)
		functionName = strings.TrimPrefix(functionName, ".")
	}

	var msg = errorInfo{
		Time:     currentTime,
		Message:  errMsg,
		Filename: fileName,
		Line:     line,
		Funcname: functionName,
	}

	jsons, errs := json.Marshal(msg)

	if errs != nil {
		fmt.Println("json marshal error:", errs)
	}

	return string(jsons)
}

func LoggerInfo(data interface{}) {

	dataMsg := loggerStout(data)

	loggger.WithFields(logrus.Fields{
		"data": "log日志",
	}).Info(dataMsg)
}
func LoggerError(data interface{}) {
	loggger.WithFields(logrus.Fields{
		"data": "测试",
	}).Error(data)
}
