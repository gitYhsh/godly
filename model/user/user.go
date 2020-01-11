package user

import (
	"errors"
	"godly/config"
	"godly/pkg/utils"
)

type User struct {
	UserId   string `gorm:"user_id" json:"userid"`
	Username string `gorm:"username" json:"username"`
	Nickname string `gorm:"nickname" json:"nickname"`
	DeptId   string `gorm:"dept_id" json:"deptid"`
	Status   string `gorm:"status" json:"status"`
}

func (userInfo *User) GetUserInfo() (string, error) {
	var db = config.GetDbCon()
	err := db.Table("t_user").Where("user_id=?", userInfo.Username).Find(&userInfo).Error

	if err != nil {
		return "", errors.New("select user error")
	}
	j := pkgutils.NewJWT()
	claims := pkgutils.CustomClaims{
		"username", userInfo.Nickname,
		pkgutils.Clmin(),
	}
	token, errotoken := j.CreateToken(claims)

	if errotoken != nil {
		return "", errors.New("create token error")
	}
	return token, nil

}
