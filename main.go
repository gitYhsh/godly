package main

import (
	config "godly/config"
	"godly/routers"
)

func main() {
	/**初始化配置**/
	config.Init()
	routersInit := routers.InitRouter()

	routersInit.Run(":8089")
}
