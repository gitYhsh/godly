package logger

import (
	"os"

	"github.com/sirupsen/logrus"
)

/**
 日志,目前还没有想好怎么定义
**/

var log = logrus.New()

func init() {
	log.Out = os.Stdout

	log.Formatter = &logrus.JSONFormatter{
		TimestampFormat: "2006-01-02 15:04:05",
	}
	log.SetLevel(logrus.InfoLevel)

}

func LoggerInfo(data interface{}) {
	log.WithFields(logrus.Fields{
		"data": "测试",
	}).Info(data)
}
func LoggerError(data interface{}) {
	log.WithFields(logrus.Fields{
		"data": "测试",
	}).Error(data)
}
