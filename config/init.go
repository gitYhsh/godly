package config

import (
	"os"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/gomodule/redigo/redis"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"github.com/joho/godotenv"
)

var redisClient *redis.Pool

var dbConnect *gorm.DB

func GetRedisCon() redis.Conn {
	return redisClient.Get()
}
func GetDbCon() *gorm.DB {
	return dbConnect
}

func initDatabase() {
	godotenv.Load()

	connString := os.Getenv("database")

	MaxIdleStr := os.Getenv("database.MaxIdleConns")
	MaxIdle64, _ := strconv.ParseInt(MaxIdleStr, 10, 0)
	MaxIdleConns := int(MaxIdle64)

	MaxOpenStr := os.Getenv("database.MaxOpenConns")
	MaxOpen64, _ := strconv.ParseInt(MaxOpenStr, 10, 0)
	MaxOpenConns := int(MaxOpen64)

	db, err := gorm.Open("mysql", connString)
	db.LogMode(true)
	// Error
	if err != nil {
		panic(err)
	}

	if gin.Mode() == "release" {
		db.LogMode(false)
	}
	//设置连接池
	//空闲
	db.DB().SetMaxIdleConns(MaxIdleConns)
	//打开
	db.DB().SetMaxOpenConns(MaxOpenConns)
	//超时
	db.DB().SetConnMaxLifetime(time.Second * 30)

	dbConnect = db

}

func initRedis() {
	godotenv.Load()

	server := os.Getenv("redis.host")
	password := os.Getenv("redis.password")

	dbstr := os.Getenv("redis.db")
	dbint64, _ := strconv.ParseInt(dbstr, 10, 0)
	db := int(dbint64)
	redisClient = &redis.Pool{
		MaxIdle:     3,
		IdleTimeout: 240 * time.Second,
		Dial: func() (redis.Conn, error) {
			c, err := redis.Dial("tcp", server, redis.DialDatabase(db))
			if err != nil {
				return nil, err
			}
			if password != "" {
				_, err := c.Do("AUTH", password)
				if err != nil {
					c.Close()
					return nil, err
				}
			}
			return c, err
		},
		TestOnBorrow: func(c redis.Conn, t time.Time) error {
			_, err := c.Do("PING")
			return err
		},
	}
}

func Init() {
	initRedis()
	initDatabase()
}
