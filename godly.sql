/*
Navicat MariaDB Data Transfer

Source Server         : mdb_204_3308
Source Server Version : 100313
Source Host           : 192.168.8.204:3308
Source Database       : godly

Target Server Type    : MariaDB
Target Server Version : 100313
File Encoding         : 65001

Date: 2020-01-08 17:35:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_dept
-- ----------------------------
DROP TABLE IF EXISTS `t_dept`;
CREATE TABLE `t_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门ID',
  `parent_id` bigint(20) NOT NULL COMMENT '上级部门ID',
  `dept_name` varchar(100) NOT NULL COMMENT '部门名称',
  `dept_status` varchar(255) NOT NULL DEFAULT '' COMMENT '是不是基础部门 0 否 1是 基础部门不能删除',
  `dept_type` varchar(255) NOT NULL DEFAULT '' COMMENT '是不是作为一级部门显示 0否，1是',
  `dept_del` varchar(255) NOT NULL DEFAULT '' COMMENT '部门是否删除了 0 否 1是',
  `dept_director` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '部门主管id',
  `dept_creattime` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8 COMMENT='部门';

-- ----------------------------
-- Records of t_dept
-- ----------------------------
INSERT INTO `t_dept` VALUES ('1', '0', '顶级公司', '1', '0', '0', 0x2C, '2019-11-09 09:08:18');
INSERT INTO `t_dept` VALUES ('2', '1', '默认部门(同步钉钉)', '1', '0', '0', 0x313532383435323035392D313132393931363032, '2019-11-06 16:56:00');
INSERT INTO `t_dept` VALUES ('74', '1', '总经办', '0', '1', '0', '', '2019-11-23 13:30:13');
INSERT INTO `t_dept` VALUES ('75', '1', '职能管理部门', '0', '0', '0', null, '2019-11-23 13:30:14');
INSERT INTO `t_dept` VALUES ('76', '1', '技术开发', '0', '1', '0', 0x3039303936393436303131383934313531383436, '2019-11-23 13:30:19');
INSERT INTO `t_dept` VALUES ('77', '1', '教学教务部门', '0', '1', '0', '', '2019-11-23 13:30:20');
INSERT INTO `t_dept` VALUES ('78', '1', 'PPC运营事业部', '0', '1', '0', '', '2019-11-23 13:30:22');
INSERT INTO `t_dept` VALUES ('79', '1', '平台运行中心', '0', '1', '0', '', '2019-11-23 13:30:23');
INSERT INTO `t_dept` VALUES ('80', '1', '新媒体运营中心', '0', '1', '0', '', '2019-11-23 13:30:24');
INSERT INTO `t_dept` VALUES ('81', '1', '市场运营中心', '0', '1', '0', '', '2019-11-05 14:49:05');
INSERT INTO `t_dept` VALUES ('82', '81', '聚学U', '0', '0', '1', '', '2019-11-05 14:53:44');
INSERT INTO `t_dept` VALUES ('83', '1', '技术开发部', '0', '0', '0', null, '2019-11-09 17:12:09');
INSERT INTO `t_dept` VALUES ('84', '1', '测试部门', '0', '0', '1', null, '2019-11-12 15:16:12');
INSERT INTO `t_dept` VALUES ('85', '83', '技术开发一部', '0', '0', '0', null, '2019-11-12 15:17:12');
INSERT INTO `t_dept` VALUES ('86', '81', '运营中心1', '0', '0', '0', null, '2019-11-12 15:36:12');
INSERT INTO `t_dept` VALUES ('87', '1', '测试', '0', '0', '1', null, '2019-11-12 15:54:12');
INSERT INTO `t_dept` VALUES ('88', '1', '111', '0', '0', '1', null, '2019-11-12 15:55:12');
INSERT INTO `t_dept` VALUES ('89', '1', '技术测试11', '0', '1', '0', null, '2019-11-29 10:40:29');
INSERT INTO `t_dept` VALUES ('90', '75', '1213', '0', '0', '0', null, '2019-11-29 11:29:29');
INSERT INTO `t_dept` VALUES ('91', '1', '技术1', '0', '0', '0', null, '2019-12-26 14:07:26');

-- ----------------------------
-- Table structure for t_job
-- ----------------------------
DROP TABLE IF EXISTS `t_job`;
CREATE TABLE `t_job` (
  `JOB_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `BEAN_NAME` varchar(100) NOT NULL COMMENT 'spring bean名称',
  `METHOD_NAME` varchar(100) NOT NULL COMMENT '方法名',
  `PARAMS` varchar(200) DEFAULT NULL COMMENT '参数',
  `CRON_EXPRESSION` varchar(100) NOT NULL COMMENT 'cron表达式',
  `STATUS` char(2) NOT NULL COMMENT '任务状态  0：正常  1：暂停',
  `REMARK` varchar(200) DEFAULT NULL COMMENT '备注',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`JOB_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_job
-- ----------------------------
INSERT INTO `t_job` VALUES ('2', 'testTask', 'test1', '', '0/10 * * * * ?', '1', '测试定时器', '2019-11-12 17:06:23');
INSERT INTO `t_job` VALUES ('3', 'synchDingTalk', 'init_DingTalkUser', '', '0/30 * * * * ?', '1', '同步钉钉数据', '2019-11-13 09:28:26');
INSERT INTO `t_job` VALUES ('4', 'targetWorkTask', 'updataWork', '', '0/10 * * * * ?', '0', null, '2019-12-31 08:50:11');

-- ----------------------------
-- Table structure for t_job_log
-- ----------------------------
DROP TABLE IF EXISTS `t_job_log`;
CREATE TABLE `t_job_log` (
  `LOG_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `JOB_ID` bigint(20) NOT NULL COMMENT '任务id',
  `BEAN_NAME` varchar(100) NOT NULL COMMENT 'spring bean名称',
  `METHOD_NAME` varchar(100) NOT NULL COMMENT '方法名',
  `PARAMS` varchar(200) DEFAULT NULL COMMENT '参数',
  `STATUS` char(2) NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `ERROR` text DEFAULT NULL COMMENT '失败信息',
  `TIMES` decimal(11,0) DEFAULT NULL COMMENT '耗时(单位：毫秒)',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`LOG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=42284 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for t_log
-- ----------------------------
DROP TABLE IF EXISTS `t_log`;
CREATE TABLE `t_log` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `USERNAME` varchar(50) DEFAULT '' COMMENT '操作用户或者ip',
  `OPERATION` text DEFAULT NULL COMMENT '操作内容',
  `TIME` decimal(11,0) DEFAULT NULL COMMENT '耗时',
  `METHOD` text DEFAULT NULL COMMENT '操作方法',
  `PARAMS` text DEFAULT NULL COMMENT '方法参数',
  `IP` varchar(64) DEFAULT NULL COMMENT '操作者IP',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `LOCATION` varchar(25) DEFAULT '' COMMENT '操作地点',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=78061 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_log
-- ----------------------------

-- ----------------------------
-- Table structure for t_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu` (
  `MENU_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单/按钮ID',
  `PARENT_ID` bigint(20) NOT NULL COMMENT '上级菜单ID',
  `MENU_NAME` varchar(50) NOT NULL COMMENT '菜单/按钮名称',
  `URL` varchar(100) DEFAULT NULL COMMENT '菜单URL',
  `PATH` varchar(255) DEFAULT '',
  `PERMS` text DEFAULT NULL COMMENT '权限标识',
  `ICON` varchar(50) DEFAULT NULL COMMENT '图标',
  `TYPE` char(2) NOT NULL COMMENT '类型 0菜单 1按钮',
  `ORDER_NUM` char(1) NOT NULL DEFAULT '\0' COMMENT '是否有子菜单 1:下拉 2：有子菜单 不显示  3：没有子菜单4：子菜单栏列表',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFY_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`MENU_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=238 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO `t_menu` VALUES ('1', '0', '系统设置', 'layout/index', 'system', '', 'fa  fa-sitemap', '0', '2', '2019-11-30 09:52:44', '2018-12-30 09:23:56');
INSERT INTO `t_menu` VALUES ('2', '1', '通讯录管理', 'system/connect', 'connect', '', 'fa fa-2x fa-maxcdn', '0', '3', '2019-11-30 09:53:44', null);
INSERT INTO `t_menu` VALUES ('3', '0', '首页', 'layout/index', 'taskIndex', null, 'fa fa-home', '0', '2', '2019-11-01 09:13:12', null);
INSERT INTO `t_menu` VALUES ('4', '0', '目标管理', 'layout/index', 'target', null, 'fa fa-envelope-open', '0', '1', '2019-11-02 09:55:29', null);
INSERT INTO `t_menu` VALUES ('5', '1', '菜单管理', 'system/menu', 'menu', '', 'fa fa-2x fa-sliders', '0', '3', '2019-11-30 09:54:01', '2018-04-25 09:01:30');
INSERT INTO `t_menu` VALUES ('6', '4', '工作目标', 'target/worktg', 'worktg', null, 'fa fa-window-close-o', '0', '3', '2019-11-03 09:57:10', null);
INSERT INTO `t_menu` VALUES ('7', '4', '周期性工作', 'target/periodtg', 'target/periodtg', null, 'fa fa-graduation-cap', '0', '3', '2019-11-04 09:58:54', null);
INSERT INTO `t_menu` VALUES ('8', '4', '任务审核确认', 'target/taskconfire', 'taskconfire', null, 'fa fa-recycle', '0', '3', '2019-11-05 09:58:54', null);
INSERT INTO `t_menu` VALUES ('9', '4', '工作监督管理', 'target/worksuper', 'worksuper', '', 'fa  fa-map-o', '0', '3', '2019-11-06 10:01:58', null);
INSERT INTO `t_menu` VALUES ('10', '4', '任务模板配置', 'target/taskmodal', 'taskmodal', null, 'fa  fa-qrcode', '0', '3', '2019-11-07 10:02:47', null);
INSERT INTO `t_menu` VALUES ('11', '0', '工作计划', 'layout/index', 'workplan', null, 'fa fa-ravelry', '0', '3', '2019-11-08 10:03:37', null);
INSERT INTO `t_menu` VALUES ('12', '0', '制度管理', 'layout/index', 'manage', null, 'fa fa-paper-plane', '0', '1', '2019-11-09 10:06:10', null);
INSERT INTO `t_menu` VALUES ('13', '12', '公司通式制度', 'manage/compny', 'compny', null, 'fa  fa-cogs', '0', '3', '2019-11-10 10:07:35', null);
INSERT INTO `t_menu` VALUES ('14', '12', '部门交接规范', 'manage/starant', 'starant', null, 'fa fa-commenting', '0', '3', '2019-11-11 10:08:41', null);
INSERT INTO `t_menu` VALUES ('15', '12', '部门工作规范', 'manage/dept', 'dept', null, 'fa fa-cloud-download', '0', '3', '2019-11-12 10:09:30', null);
INSERT INTO `t_menu` VALUES ('16', '12', '执行监督管理', 'manage/implent', 'implent', null, 'fa fa-bar-chart', '0', '3', '2019-11-13 10:10:37', null);
INSERT INTO `t_menu` VALUES ('17', '0', '反馈管理', 'layout/index', 'fallback', null, 'fa fa-rss-square', '0', '1', '2019-11-14 10:11:57', null);
INSERT INTO `t_menu` VALUES ('18', '17', '反馈首页', 'fallback/index', 'index', null, 'fa fa-caret-square-o-right', '0', '3', '2019-11-15 10:13:29', null);
INSERT INTO `t_menu` VALUES ('19', '17', '工作任务反馈', 'fallback/worktask', 'worktask', null, 'fa fa-american-sign-language-interpreting', '0', '3', '2019-11-16 10:14:17', null);
INSERT INTO `t_menu` VALUES ('20', '17', '制度执行反馈', 'fallback/sysmanage', 'sysmanage', null, 'fa fa-asterisk', '0', '3', '2019-11-17 10:15:23', null);
INSERT INTO `t_menu` VALUES ('21', '17', '部门问题反馈', 'fallback/dept', 'dept', null, 'fa fa-address-book', '0', '3', '2019-11-18 10:16:15', null);
INSERT INTO `t_menu` VALUES ('22', '17', '企业问题反馈', 'fallback/compny', 'compny', null, 'fa fa-anchor', '0', '3', '2019-11-19 10:17:06', null);
INSERT INTO `t_menu` VALUES ('23', '0', '考核管理', 'layout/index', 'assess', null, 'fa fa-server', '0', '1', '2019-11-20 10:18:35', null);
INSERT INTO `t_menu` VALUES ('24', '23', '考核首页', 'assess/index', 'index', null, 'fa fa-briefcase', '0', '3', '2019-11-21 10:19:28', null);
INSERT INTO `t_menu` VALUES ('25', '23', '考核方案公示', 'assess/progpublic', 'progpublic', null, 'fa fa-calendar-minus-o', '0', '3', '2019-11-22 10:20:50', null);
INSERT INTO `t_menu` VALUES ('26', '23', '考核成绩公示', 'assess/achivpublic', 'achivpublic', null, 'fa fa-eye-slash', '0', '3', '2019-11-23 10:22:05', null);
INSERT INTO `t_menu` VALUES ('27', '1', '基础设置', 'system/basicconfig', 'basicconfig', null, 'fa fa-database', '0', '3', '2019-11-30 10:27:31', null);
INSERT INTO `t_menu` VALUES ('28', '1', '定时任务', 'system/timetask', 'timetask', null, 'fa fa-file-audio-o', '0', '3', '2019-11-30 10:29:14', null);
INSERT INTO `t_menu` VALUES ('29', '0', '通知管理', 'layout/index', 'notice', null, 'fa fa-rocket', '0', '0', '2019-11-01 09:20:52', null);
INSERT INTO `t_menu` VALUES ('32', '0', '总结管理', 'layout/index', 'summary', null, 'fa fa-rocket', '0', '1', '2019-11-21 11:34:59', null);
INSERT INTO `t_menu` VALUES ('33', '0', '培训管理', 'layout/index', 'train', null, 'fa fa-universal-access', '0', '1', '2019-11-20 11:36:24', null);
INSERT INTO `t_menu` VALUES ('34', '0', '数据分析', 'layout/index', 'data', null, 'fa fa-window-restore', '0', '1', '2019-11-22 11:37:46', null);
INSERT INTO `t_menu` VALUES ('35', '25', '添加绩效方案按钮', null, '', 'prog:add', '', '1', '0', '2019-11-23 09:58:12', null);
INSERT INTO `t_menu` VALUES ('36', '26', '绩效核算', null, '', 'achive:sum', '', '1', '0', '2019-11-23 10:00:02', null);
INSERT INTO `t_menu` VALUES ('37', '25', '查看所有部门绩效方案', null, '', 'prog:all', '', '1', '0', '2019-11-23 15:40:41', null);
INSERT INTO `t_menu` VALUES ('38', '6', '创建目标', null, '', 'add:target', null, '1', '0', '2019-12-13 14:27:58', null);
INSERT INTO `t_menu` VALUES ('39', '2', '查询所有的部门', null, '', 'view:allDept', null, '1', '0', '2019-12-14 10:25:16', null);
INSERT INTO `t_menu` VALUES ('40', '7', '周期工作提审按钮', null, '', 'perplan:commit', null, '1', '0', '2019-12-17 09:33:25', null);
INSERT INTO `t_menu` VALUES ('41', '16', '发布执行管理按钮', null, '', 'implement:add', null, '1', '0', '2019-12-17 17:44:56', null);
INSERT INTO `t_menu` VALUES ('42', '16', '执行岗操作', null, '', 'implement:zhi', null, '1', '0', '2019-12-23 16:02:15', null);
INSERT INTO `t_menu` VALUES ('43', '16', '执行删除', null, '', 'imp:del', null, '1', '0', '2019-12-23 16:12:45', null);
INSERT INTO `t_menu` VALUES ('44', '13', '导入和记录', null, '', 'com:imp', null, '1', '0', '2019-12-23 16:21:28', null);
INSERT INTO `t_menu` VALUES ('45', '14', '部门交接规范导入', null, '', 'dept:imp', null, '1', '0', '2019-12-23 16:22:56', null);
INSERT INTO `t_menu` VALUES ('46', '15', '部门规范', null, '', 'dept:impgui', null, '1', '0', '2019-12-23 16:23:58', null);
INSERT INTO `t_menu` VALUES ('47', '18', '删除反馈', null, '', 'feed:del', null, '1', '0', '2019-12-26 08:39:27', null);
INSERT INTO `t_menu` VALUES ('48', '11', '列表上级或主管按钮', null, '', 'isAuth:true', null, '1', '0', '2019-12-26 11:18:54', null);

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `ROLE_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `ROLE_NAME` varchar(100) NOT NULL COMMENT '角色名称',
  `ROLE_TYPE` varchar(255) DEFAULT '' COMMENT '是否是自定义角色 0 否 1是',
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('5', '管理员', '0');
INSERT INTO `t_role` VALUES ('6', '主管', '0');
INSERT INTO `t_role` VALUES ('7', '普通员工', '0');
INSERT INTO `t_role` VALUES ('22', '总经理', '1');
INSERT INTO `t_role` VALUES ('24', '技术部', '1');
INSERT INTO `t_role` VALUES ('25', '杨洪升', '1');
INSERT INTO `t_role` VALUES ('26', '设计', '1');

-- ----------------------------
-- Table structure for t_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_role_menu`;
CREATE TABLE `t_role_menu` (
  `ROLE_ID` bigint(20) NOT NULL COMMENT '角色ID',
  `MENU_ID` bigint(20) NOT NULL COMMENT '菜单/按钮ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
INSERT INTO `t_role_menu` VALUES ('5', '4');
INSERT INTO `t_role_menu` VALUES ('5', '6');
INSERT INTO `t_role_menu` VALUES ('5', '7');
INSERT INTO `t_role_menu` VALUES ('5', '8');
INSERT INTO `t_role_menu` VALUES ('5', '9');
INSERT INTO `t_role_menu` VALUES ('5', '10');
INSERT INTO `t_role_menu` VALUES ('5', '11');
INSERT INTO `t_role_menu` VALUES ('5', '30');
INSERT INTO `t_role_menu` VALUES ('5', '12');
INSERT INTO `t_role_menu` VALUES ('5', '13');
INSERT INTO `t_role_menu` VALUES ('5', '14');
INSERT INTO `t_role_menu` VALUES ('5', '15');
INSERT INTO `t_role_menu` VALUES ('5', '16');
INSERT INTO `t_role_menu` VALUES ('5', '17');
INSERT INTO `t_role_menu` VALUES ('5', '18');
INSERT INTO `t_role_menu` VALUES ('5', '19');
INSERT INTO `t_role_menu` VALUES ('5', '20');
INSERT INTO `t_role_menu` VALUES ('5', '21');
INSERT INTO `t_role_menu` VALUES ('5', '22');
INSERT INTO `t_role_menu` VALUES ('5', '23');
INSERT INTO `t_role_menu` VALUES ('5', '24');
INSERT INTO `t_role_menu` VALUES ('5', '25');
INSERT INTO `t_role_menu` VALUES ('5', '26');
INSERT INTO `t_role_menu` VALUES ('5', '1');
INSERT INTO `t_role_menu` VALUES ('5', '31');
INSERT INTO `t_role_menu` VALUES ('5', '2');
INSERT INTO `t_role_menu` VALUES ('5', '5');
INSERT INTO `t_role_menu` VALUES ('5', '27');
INSERT INTO `t_role_menu` VALUES ('5', '28');
INSERT INTO `t_role_menu` VALUES ('5', '32');
INSERT INTO `t_role_menu` VALUES ('5', '33');
INSERT INTO `t_role_menu` VALUES ('5', '34');
INSERT INTO `t_role_menu` VALUES ('5', '35');
INSERT INTO `t_role_menu` VALUES ('5', '3');
INSERT INTO `t_role_menu` VALUES ('5', '38');
INSERT INTO `t_role_menu` VALUES ('5', '40');
INSERT INTO `t_role_menu` VALUES ('5', '41');
INSERT INTO `t_role_menu` VALUES ('25', '3');
INSERT INTO `t_role_menu` VALUES ('25', '4');
INSERT INTO `t_role_menu` VALUES ('25', '11');
INSERT INTO `t_role_menu` VALUES ('25', '12');
INSERT INTO `t_role_menu` VALUES ('25', '23');
INSERT INTO `t_role_menu` VALUES ('25', '33');
INSERT INTO `t_role_menu` VALUES ('25', '17');
INSERT INTO `t_role_menu` VALUES ('25', '32');
INSERT INTO `t_role_menu` VALUES ('25', '34');
INSERT INTO `t_role_menu` VALUES ('25', '1');
INSERT INTO `t_role_menu` VALUES ('25', '6');
INSERT INTO `t_role_menu` VALUES ('25', '7');
INSERT INTO `t_role_menu` VALUES ('25', '8');
INSERT INTO `t_role_menu` VALUES ('25', '9');
INSERT INTO `t_role_menu` VALUES ('25', '10');
INSERT INTO `t_role_menu` VALUES ('25', '38');
INSERT INTO `t_role_menu` VALUES ('25', '39');
INSERT INTO `t_role_menu` VALUES ('25', '2');
INSERT INTO `t_role_menu` VALUES ('25', '5');
INSERT INTO `t_role_menu` VALUES ('25', '13');
INSERT INTO `t_role_menu` VALUES ('25', '14');
INSERT INTO `t_role_menu` VALUES ('25', '15');
INSERT INTO `t_role_menu` VALUES ('25', '16');
INSERT INTO `t_role_menu` VALUES ('25', '41');
INSERT INTO `t_role_menu` VALUES ('25', '42');
INSERT INTO `t_role_menu` VALUES ('25', '43');
INSERT INTO `t_role_menu` VALUES ('25', '40');
INSERT INTO `t_role_menu` VALUES ('25', '18');
INSERT INTO `t_role_menu` VALUES ('25', '19');
INSERT INTO `t_role_menu` VALUES ('25', '20');
INSERT INTO `t_role_menu` VALUES ('25', '44');
INSERT INTO `t_role_menu` VALUES ('25', '21');
INSERT INTO `t_role_menu` VALUES ('25', '22');
INSERT INTO `t_role_menu` VALUES ('25', '24');
INSERT INTO `t_role_menu` VALUES ('5', '44');
INSERT INTO `t_role_menu` VALUES ('5', '42');
INSERT INTO `t_role_menu` VALUES ('5', '43');
INSERT INTO `t_role_menu` VALUES ('25', '47');
INSERT INTO `t_role_menu` VALUES ('5', '48');
INSERT INTO `t_role_menu` VALUES ('5', '47');
INSERT INTO `t_role_menu` VALUES ('25', '29');
INSERT INTO `t_role_menu` VALUES ('5', '45');
INSERT INTO `t_role_menu` VALUES ('5', '46');
INSERT INTO `t_role_menu` VALUES ('5', '37');
INSERT INTO `t_role_menu` VALUES ('5', '36');
INSERT INTO `t_role_menu` VALUES ('5', '39');
INSERT INTO `t_role_menu` VALUES ('25', '45');
INSERT INTO `t_role_menu` VALUES ('25', '46');
INSERT INTO `t_role_menu` VALUES ('5', '29');
INSERT INTO `t_role_menu` VALUES ('25', '25');
INSERT INTO `t_role_menu` VALUES ('25', '26');
INSERT INTO `t_role_menu` VALUES ('25', '35');
INSERT INTO `t_role_menu` VALUES ('25', '48');
INSERT INTO `t_role_menu` VALUES ('25', '37');
INSERT INTO `t_role_menu` VALUES ('25', '36');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `user_id` varchar(50) NOT NULL COMMENT '用户ID',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `nickname` varchar(255) DEFAULT '' COMMENT '昵称',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `station` varchar(255) DEFAULT '' COMMENT '岗位id',
  `status` char(1) NOT NULL COMMENT '状态 1锁定 0有效',
  `quit_reason` longtext DEFAULT NULL,
  PRIMARY KEY (`user_id`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('0101695108880048494', '0101695108880048494', '柴坤', '74', '', '1', '技术打法就是的分开来说打发撒旦法');

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `USER_ID` varchar(50) NOT NULL COMMENT '用户ID',
  `ROLE_ID` bigint(20) NOT NULL COMMENT '角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES ('1526092607-1594655110', '5');
INSERT INTO `t_user_role` VALUES ('11193965151345942278', '7');
INSERT INTO `t_user_role` VALUES ('1060086465641753496', '7');
INSERT INTO `t_user_role` VALUES ('16101321511231137', '7');
INSERT INTO `t_user_role` VALUES ('2857571264690234', '7');
INSERT INTO `t_user_role` VALUES ('173543431835960181', '7');
INSERT INTO `t_user_role` VALUES ('10680931601479954282', '7');
INSERT INTO `t_user_role` VALUES ('0223575544-862067237', '7');
INSERT INTO `t_user_role` VALUES ('08673439171217237', '7');
INSERT INTO `t_user_role` VALUES ('090127556526362382', '7');
INSERT INTO `t_user_role` VALUES ('0901276240778723', '7');
INSERT INTO `t_user_role` VALUES ('1709341457-1640556684', '7');
INSERT INTO `t_user_role` VALUES ('25321130001971671437', '7');
INSERT INTO `t_user_role` VALUES ('2536504362635918184', '7');
INSERT INTO `t_user_role` VALUES ('20305968972375062', '7');
INSERT INTO `t_user_role` VALUES ('1411500915-505303249', '7');
INSERT INTO `t_user_role` VALUES ('171013021015203590', '7');
INSERT INTO `t_user_role` VALUES ('09486205261095571943', '7');
INSERT INTO `t_user_role` VALUES ('1704525364-1540230445', '7');
INSERT INTO `t_user_role` VALUES ('023911653428144967', '7');
INSERT INTO `t_user_role` VALUES ('133866265721818848', '7');
INSERT INTO `t_user_role` VALUES ('1365430860712570761', '7');
INSERT INTO `t_user_role` VALUES ('17096836351179804', '7');
INSERT INTO `t_user_role` VALUES ('116761443549378227', '5');
INSERT INTO `t_user_role` VALUES ('1753172253-982544683', '5');
INSERT INTO `t_user_role` VALUES ('11514727461892074592', '7');
INSERT INTO `t_user_role` VALUES ('18041756401905342891', '7');
INSERT INTO `t_user_role` VALUES ('1042394142-1612090421', '7');
INSERT INTO `t_user_role` VALUES ('1038653450-941588447', '7');
INSERT INTO `t_user_role` VALUES ('1421124712-425947682', '7');
INSERT INTO `t_user_role` VALUES ('27690639662073324215', '7');
INSERT INTO `t_user_role` VALUES ('2923542839-1137196695', '7');
INSERT INTO `t_user_role` VALUES ('28322439261030790530', '7');
INSERT INTO `t_user_role` VALUES ('121067280723423593', '7');
INSERT INTO `t_user_role` VALUES ('262645156920114733', '7');
INSERT INTO `t_user_role` VALUES ('041008271524378112', '7');
INSERT INTO `t_user_role` VALUES ('0761066726777983', '7');
INSERT INTO `t_user_role` VALUES ('262002451324621500', '7');
INSERT INTO `t_user_role` VALUES ('0852103204-754355814', '7');
INSERT INTO `t_user_role` VALUES ('2930403506680478590', '7');
INSERT INTO `t_user_role` VALUES ('2825492124-1798720528', '7');
INSERT INTO `t_user_role` VALUES ('231632496420882277', '7');
INSERT INTO `t_user_role` VALUES ('21404064-1583463806', '7');
INSERT INTO `t_user_role` VALUES ('213826221438629285', '7');
INSERT INTO `t_user_role` VALUES ('1718066831-1128758286', '7');
INSERT INTO `t_user_role` VALUES ('2804501522-154039927', '7');
INSERT INTO `t_user_role` VALUES ('0205060507846021', '7');
INSERT INTO `t_user_role` VALUES ('086169145835837099', '7');
INSERT INTO `t_user_role` VALUES ('0866421325843331', '7');
INSERT INTO `t_user_role` VALUES ('0953451247-358270056', '7');
INSERT INTO `t_user_role` VALUES ('manager6883', '7');
INSERT INTO `t_user_role` VALUES ('0127595666-1424315518', '7');
INSERT INTO `t_user_role` VALUES ('1106055729-1329770986', '7');
INSERT INTO `t_user_role` VALUES ('01133722671024022073', '7');
INSERT INTO `t_user_role` VALUES ('104212661938045554', '7');
INSERT INTO `t_user_role` VALUES ('032302564932571441', '7');
INSERT INTO `t_user_role` VALUES ('1746181437-605638522', '7');
INSERT INTO `t_user_role` VALUES ('09001448511257910', '7');
INSERT INTO `t_user_role` VALUES ('1254595644597577237', '7');
INSERT INTO `t_user_role` VALUES ('0215551966-1280493922', '7');
INSERT INTO `t_user_role` VALUES ('086643423221525594', '7');
INSERT INTO `t_user_role` VALUES ('17525166471230276', '7');
INSERT INTO `t_user_role` VALUES ('2938082533-1039389612', '7');
INSERT INTO `t_user_role` VALUES ('17410308681149210', '7');
INSERT INTO `t_user_role` VALUES ('0129036534622626023', '7');
INSERT INTO `t_user_role` VALUES ('0265294600-1695695594', '7');
INSERT INTO `t_user_role` VALUES ('17261468001447731939', '7');
INSERT INTO `t_user_role` VALUES ('0155156266905759', '7');
INSERT INTO `t_user_role` VALUES ('172106691623131861', '7');
INSERT INTO `t_user_role` VALUES ('0641082943-1213472059', '5');
INSERT INTO `t_user_role` VALUES ('0309061036-184416825', '7');
INSERT INTO `t_user_role` VALUES ('031335552324375328', '7');
INSERT INTO `t_user_role` VALUES ('04395807391554827797', '7');
INSERT INTO `t_user_role` VALUES ('2923544336-1618238413', '7');
INSERT INTO `t_user_role` VALUES ('2200093351590939438', '7');
INSERT INTO `t_user_role` VALUES ('174000520621607760', '7');
INSERT INTO `t_user_role` VALUES ('086639142723323170', '7');
INSERT INTO `t_user_role` VALUES ('10290301061829663294', '7');
INSERT INTO `t_user_role` VALUES ('2304506300441012875', '7');
INSERT INTO `t_user_role` VALUES ('0827216627-956767870', '7');
INSERT INTO `t_user_role` VALUES ('296824055636667064', '7');
INSERT INTO `t_user_role` VALUES ('033201324929226046', '7');
INSERT INTO `t_user_role` VALUES ('1239171713921698778', '7');
INSERT INTO `t_user_role` VALUES ('0463584367735555304', '7');
INSERT INTO `t_user_role` VALUES ('28322631341868319133', '7');
INSERT INTO `t_user_role` VALUES ('250031140426275424', '7');
INSERT INTO `t_user_role` VALUES ('086643483246093431', '7');
INSERT INTO `t_user_role` VALUES ('180337173044839086', '7');
INSERT INTO `t_user_role` VALUES ('0204672951941263', '7');
INSERT INTO `t_user_role` VALUES ('086644211221556979', '7');
INSERT INTO `t_user_role` VALUES ('033511455739948516', '7');
INSERT INTO `t_user_role` VALUES ('086640281026610439', '7');
INSERT INTO `t_user_role` VALUES ('10302704421427028026', '7');
INSERT INTO `t_user_role` VALUES ('2241371027548806578', '7');
INSERT INTO `t_user_role` VALUES ('1700614147-1971623934', '7');
INSERT INTO `t_user_role` VALUES ('086515394621498356', '7');
INSERT INTO `t_user_role` VALUES ('08664136061135955011', '7');
INSERT INTO `t_user_role` VALUES ('0221294261-187863501', '7');
INSERT INTO `t_user_role` VALUES ('05615765421777878661', '7');
INSERT INTO `t_user_role` VALUES ('086643085620759535', '7');
INSERT INTO `t_user_role` VALUES ('086817040924361632', '7');
INSERT INTO `t_user_role` VALUES ('086643206632406853', '7');
INSERT INTO `t_user_role` VALUES ('10340400531605370544', '7');
INSERT INTO `t_user_role` VALUES ('2505463920212357549', '7');
INSERT INTO `t_user_role` VALUES ('1729370009-1568269664', '7');
INSERT INTO `t_user_role` VALUES ('13194060411265083', '7');
INSERT INTO `t_user_role` VALUES ('086719392429426661', '7');
INSERT INTO `t_user_role` VALUES ('1323180917139915319', '7');
INSERT INTO `t_user_role` VALUES ('245339453926081827', '7');
INSERT INTO `t_user_role` VALUES ('12246330051172778365', '7');
INSERT INTO `t_user_role` VALUES ('1412291140-1834555180', '7');
INSERT INTO `t_user_role` VALUES ('04204840391354059900', '7');
INSERT INTO `t_user_role` VALUES ('151164134036484942', '7');
INSERT INTO `t_user_role` VALUES ('031308010737760199', '7');
INSERT INTO `t_user_role` VALUES ('1938243317160332651', '7');
INSERT INTO `t_user_role` VALUES ('1611100904793657', '7');
INSERT INTO `t_user_role` VALUES ('14190823511437692576', '7');
INSERT INTO `t_user_role` VALUES ('13601438131152341', '7');
INSERT INTO `t_user_role` VALUES ('280314472621605549', '7');
INSERT INTO `t_user_role` VALUES ('140301156229108721', '7');
INSERT INTO `t_user_role` VALUES ('2309251827846024', '7');
INSERT INTO `t_user_role` VALUES ('213431613132825589', '7');
INSERT INTO `t_user_role` VALUES ('1324391800682301', '7');
INSERT INTO `t_user_role` VALUES ('17003407441249806', '7');
INSERT INTO `t_user_role` VALUES ('0614213128907693', '7');
INSERT INTO `t_user_role` VALUES ('200315016629348574', '7');
INSERT INTO `t_user_role` VALUES ('182240611226350656', '7');
INSERT INTO `t_user_role` VALUES ('086720256837886878', '7');
INSERT INTO `t_user_role` VALUES ('08664110481034008', '7');
INSERT INTO `t_user_role` VALUES ('090060542436733133', '7');
INSERT INTO `t_user_role` VALUES ('21071733001324070540', '7');
INSERT INTO `t_user_role` VALUES ('0866430637-1743716235', '7');
INSERT INTO `t_user_role` VALUES ('0866435319684891', '7');
INSERT INTO `t_user_role` VALUES ('1830015938-2042947508', '7');
INSERT INTO `t_user_role` VALUES ('21020634001098580901', '7');
INSERT INTO `t_user_role` VALUES ('1630560213-1555064915', '7');
INSERT INTO `t_user_role` VALUES ('02276848021433917560', '7');
INSERT INTO `t_user_role` VALUES ('1504110157-996642183', '7');
INSERT INTO `t_user_role` VALUES ('1838101020883353', '7');
INSERT INTO `t_user_role` VALUES ('2667180737-1416488367', '7');
INSERT INTO `t_user_role` VALUES ('1766172837-1777153088', '7');
INSERT INTO `t_user_role` VALUES ('106233403520217725', '7');
INSERT INTO `t_user_role` VALUES ('20593527-2117722851', '7');
INSERT INTO `t_user_role` VALUES ('0919254020248133401', '7');
INSERT INTO `t_user_role` VALUES ('23401904791657', '7');
INSERT INTO `t_user_role` VALUES ('302862322020067989', '7');
INSERT INTO `t_user_role` VALUES ('0412593454-330168904', '7');
INSERT INTO `t_user_role` VALUES ('1435004863-1455516236', '7');
INSERT INTO `t_user_role` VALUES ('05294324671211443416', '7');
INSERT INTO `t_user_role` VALUES ('090059381926114524', '7');
INSERT INTO `t_user_role` VALUES ('166935033926296562', '7');
INSERT INTO `t_user_role` VALUES ('2903020357858588', '7');
INSERT INTO `t_user_role` VALUES ('360856021982794789', '7');
INSERT INTO `t_user_role` VALUES ('2423442312-2057706426', '7');
INSERT INTO `t_user_role` VALUES ('31084032391220506', '7');
INSERT INTO `t_user_role` VALUES ('095838356139785452', '7');
INSERT INTO `t_user_role` VALUES ('14123225361433566448', '7');
INSERT INTO `t_user_role` VALUES ('1834365665-1336484564', '7');
INSERT INTO `t_user_role` VALUES ('2532486961328107923', '7');
INSERT INTO `t_user_role` VALUES ('01231738591100893902', '7');
INSERT INTO `t_user_role` VALUES ('08111961412109519833', '7');
INSERT INTO `t_user_role` VALUES ('02371722071697501298', '7');
INSERT INTO `t_user_role` VALUES ('2832251829-1459661797', '7');
INSERT INTO `t_user_role` VALUES ('046511196221248145', '7');
INSERT INTO `t_user_role` VALUES ('1628470356-150796453', '7');
INSERT INTO `t_user_role` VALUES ('17485337411210421704', '7');
INSERT INTO `t_user_role` VALUES ('13666804111669715157', '7');
INSERT INTO `t_user_role` VALUES ('23325727681185886863', '7');
INSERT INTO `t_user_role` VALUES ('0960585756960547739', '7');
INSERT INTO `t_user_role` VALUES ('23401904791657', '5');
INSERT INTO `t_user_role` VALUES ('086169145835837099', '5');
INSERT INTO `t_user_role` VALUES ('0866421325843331', '5');
INSERT INTO `t_user_role` VALUES ('manager6883', '5');
INSERT INTO `t_user_role` VALUES ('095838356139785452', '6');
INSERT INTO `t_user_role` VALUES ('17003407441249806', '6');
INSERT INTO `t_user_role` VALUES ('08664136061135955011', '6');
INSERT INTO `t_user_role` VALUES ('090059381926114524', '6');
INSERT INTO `t_user_role` VALUES ('05294324671211443416', '6');
INSERT INTO `t_user_role` VALUES ('213826221438629285', '6');
INSERT INTO `t_user_role` VALUES ('21404064-1583463806', '6');
INSERT INTO `t_user_role` VALUES ('302862322020067989', '6');
INSERT INTO `t_user_role` VALUES ('20305968972375062', '6');
INSERT INTO `t_user_role` VALUES ('0641082943-1213472059', '6');
INSERT INTO `t_user_role` VALUES ('0463584367735555304', '6');
INSERT INTO `t_user_role` VALUES ('0223575544-862067237', '6');
INSERT INTO `t_user_role` VALUES ('04204840391354059900', '6');
INSERT INTO `t_user_role` VALUES ('086515394621498356', '6');
INSERT INTO `t_user_role` VALUES ('0953451247-358270056', '6');
INSERT INTO `t_user_role` VALUES ('1746181437-605638522', '6');
INSERT INTO `t_user_role` VALUES ('1042394142-1612090421', '6');
INSERT INTO `t_user_role` VALUES ('23401904791657', '6');
INSERT INTO `t_user_role` VALUES ('0866421325843331', '6');
INSERT INTO `t_user_role` VALUES ('086169145835837099', '6');
INSERT INTO `t_user_role` VALUES ('14190823511437692576', '6');
INSERT INTO `t_user_role` VALUES ('09096946011894151846', '6');
INSERT INTO `t_user_role` VALUES ('086639142723323170', '6');
INSERT INTO `t_user_role` VALUES ('04395807391554827797', '6');
INSERT INTO `t_user_role` VALUES ('05615765421777878661', '6');
INSERT INTO `t_user_role` VALUES ('086643483246093431', '6');
INSERT INTO `t_user_role` VALUES ('086719392429426661', '6');
INSERT INTO `t_user_role` VALUES ('031308010737760199', '6');
INSERT INTO `t_user_role` VALUES ('033201324929226046', '6');
INSERT INTO `t_user_role` VALUES ('11193965151345942278', '7');
INSERT INTO `t_user_role` VALUES ('1060086465641753496', '7');
INSERT INTO `t_user_role` VALUES ('16101321511231137', '7');
INSERT INTO `t_user_role` VALUES ('2857571264690234', '7');
INSERT INTO `t_user_role` VALUES ('173543431835960181', '7');
INSERT INTO `t_user_role` VALUES ('10680931601479954282', '7');
INSERT INTO `t_user_role` VALUES ('08673439171217237', '7');
INSERT INTO `t_user_role` VALUES ('090127556526362382', '7');
INSERT INTO `t_user_role` VALUES ('0901276240778723', '7');
INSERT INTO `t_user_role` VALUES ('1709341457-1640556684', '7');
INSERT INTO `t_user_role` VALUES ('25321130001971671437', '7');
INSERT INTO `t_user_role` VALUES ('2536504362635918184', '7');
INSERT INTO `t_user_role` VALUES ('20305968972375062', '7');
INSERT INTO `t_user_role` VALUES ('1411500915-505303249', '7');
INSERT INTO `t_user_role` VALUES ('171013021015203590', '7');
INSERT INTO `t_user_role` VALUES ('09486205261095571943', '7');
INSERT INTO `t_user_role` VALUES ('1704525364-1540230445', '7');
INSERT INTO `t_user_role` VALUES ('133866265721818848', '7');
INSERT INTO `t_user_role` VALUES ('1365430860712570761', '7');
INSERT INTO `t_user_role` VALUES ('17096836351179804', '7');
INSERT INTO `t_user_role` VALUES ('116761443549378227', '7');
INSERT INTO `t_user_role` VALUES ('1753172253-982544683', '7');
INSERT INTO `t_user_role` VALUES ('11514727461892074592', '7');
INSERT INTO `t_user_role` VALUES ('18041756401905342891', '7');
INSERT INTO `t_user_role` VALUES ('1042394142-1612090421', '7');
INSERT INTO `t_user_role` VALUES ('1038653450-941588447', '7');
INSERT INTO `t_user_role` VALUES ('1421124712-425947682', '7');
INSERT INTO `t_user_role` VALUES ('27690639662073324215', '7');
INSERT INTO `t_user_role` VALUES ('2923542839-1137196695', '7');
INSERT INTO `t_user_role` VALUES ('28322439261030790530', '7');
INSERT INTO `t_user_role` VALUES ('121067280723423593', '7');
INSERT INTO `t_user_role` VALUES ('262645156920114733', '7');
INSERT INTO `t_user_role` VALUES ('262002451324621500', '7');
INSERT INTO `t_user_role` VALUES ('2930403506680478590', '7');
INSERT INTO `t_user_role` VALUES ('2825492124-1798720528', '7');
INSERT INTO `t_user_role` VALUES ('231632496420882277', '7');
INSERT INTO `t_user_role` VALUES ('21404064-1583463806', '7');
INSERT INTO `t_user_role` VALUES ('213826221438629285', '7');
INSERT INTO `t_user_role` VALUES ('1718066831-1128758286', '7');
INSERT INTO `t_user_role` VALUES ('2804501522-154039927', '7');
INSERT INTO `t_user_role` VALUES ('0866421325843331', '7');
INSERT INTO `t_user_role` VALUES ('0953451247-358270056', '7');
INSERT INTO `t_user_role` VALUES ('manager6883', '7');
INSERT INTO `t_user_role` VALUES ('1106055729-1329770986', '7');
INSERT INTO `t_user_role` VALUES ('104212661938045554', '7');
INSERT INTO `t_user_role` VALUES ('1746181437-605638522', '7');
INSERT INTO `t_user_role` VALUES ('09001448511257910', '7');
INSERT INTO `t_user_role` VALUES ('1254595644597577237', '7');
INSERT INTO `t_user_role` VALUES ('086643423221525594', '7');
INSERT INTO `t_user_role` VALUES ('17525166471230276', '7');
INSERT INTO `t_user_role` VALUES ('2938082533-1039389612', '7');
INSERT INTO `t_user_role` VALUES ('17410308681149210', '7');
INSERT INTO `t_user_role` VALUES ('17261468001447731939', '7');
INSERT INTO `t_user_role` VALUES ('172106691623131861', '7');
INSERT INTO `t_user_role` VALUES ('2923544336-1618238413', '7');
INSERT INTO `t_user_role` VALUES ('2200093351590939438', '7');
INSERT INTO `t_user_role` VALUES ('174000520621607760', '7');
INSERT INTO `t_user_role` VALUES ('10290301061829663294', '7');
INSERT INTO `t_user_role` VALUES ('2304506300441012875', '7');
INSERT INTO `t_user_role` VALUES ('296824055636667064', '7');
INSERT INTO `t_user_role` VALUES ('1239171713921698778', '7');
INSERT INTO `t_user_role` VALUES ('28322631341868319133', '7');
INSERT INTO `t_user_role` VALUES ('250031140426275424', '7');
INSERT INTO `t_user_role` VALUES ('086643483246093431', '7');
INSERT INTO `t_user_role` VALUES ('180337173044839086', '7');
INSERT INTO `t_user_role` VALUES ('086644211221556979', '7');
INSERT INTO `t_user_role` VALUES ('10302704421427028026', '7');
INSERT INTO `t_user_role` VALUES ('2241371027548806578', '7');
INSERT INTO `t_user_role` VALUES ('1700614147-1971623934', '7');
INSERT INTO `t_user_role` VALUES ('08664136061135955011', '7');
INSERT INTO `t_user_role` VALUES ('086643085620759535', '7');
INSERT INTO `t_user_role` VALUES ('086817040924361632', '7');
INSERT INTO `t_user_role` VALUES ('086643206632406853', '7');
INSERT INTO `t_user_role` VALUES ('10340400531605370544', '7');
INSERT INTO `t_user_role` VALUES ('2505463920212357549', '7');
INSERT INTO `t_user_role` VALUES ('1729370009-1568269664', '7');
INSERT INTO `t_user_role` VALUES ('13194060411265083', '7');
INSERT INTO `t_user_role` VALUES ('086719392429426661', '7');
INSERT INTO `t_user_role` VALUES ('1323180917139915319', '7');
INSERT INTO `t_user_role` VALUES ('245339453926081827', '7');
INSERT INTO `t_user_role` VALUES ('12246330051172778365', '7');
INSERT INTO `t_user_role` VALUES ('1412291140-1834555180', '7');
INSERT INTO `t_user_role` VALUES ('1938243317160332651', '7');
INSERT INTO `t_user_role` VALUES ('1611100904793657', '7');
INSERT INTO `t_user_role` VALUES ('14190823511437692576', '7');
INSERT INTO `t_user_role` VALUES ('13601438131152341', '7');
INSERT INTO `t_user_role` VALUES ('280314472621605549', '7');
INSERT INTO `t_user_role` VALUES ('140301156229108721', '7');
INSERT INTO `t_user_role` VALUES ('2309251827846024', '7');
INSERT INTO `t_user_role` VALUES ('213431613132825589', '7');
INSERT INTO `t_user_role` VALUES ('1324391800682301', '7');
INSERT INTO `t_user_role` VALUES ('17003407441249806', '7');
INSERT INTO `t_user_role` VALUES ('200315016629348574', '7');
INSERT INTO `t_user_role` VALUES ('182240611226350656', '7');
INSERT INTO `t_user_role` VALUES ('086720256837886878', '7');
INSERT INTO `t_user_role` VALUES ('090060542436733133', '7');
INSERT INTO `t_user_role` VALUES ('21071733001324070540', '7');
INSERT INTO `t_user_role` VALUES ('0866430637-1743716235', '7');
INSERT INTO `t_user_role` VALUES ('0866435319684891', '7');
INSERT INTO `t_user_role` VALUES ('1830015938-2042947508', '7');
INSERT INTO `t_user_role` VALUES ('21020634001098580901', '7');
INSERT INTO `t_user_role` VALUES ('1630560213-1555064915', '7');
INSERT INTO `t_user_role` VALUES ('1838101020883353', '7');
INSERT INTO `t_user_role` VALUES ('2667180737-1416488367', '7');
INSERT INTO `t_user_role` VALUES ('1766172837-1777153088', '7');
INSERT INTO `t_user_role` VALUES ('106233403520217725', '7');
INSERT INTO `t_user_role` VALUES ('20593527-2117722851', '7');
INSERT INTO `t_user_role` VALUES ('0919254020248133401', '7');
INSERT INTO `t_user_role` VALUES ('23401904791657', '7');
INSERT INTO `t_user_role` VALUES ('302862322020067989', '7');
INSERT INTO `t_user_role` VALUES ('090059381926114524', '7');
INSERT INTO `t_user_role` VALUES ('166935033926296562', '7');
INSERT INTO `t_user_role` VALUES ('2903020357858588', '7');
INSERT INTO `t_user_role` VALUES ('360856021982794789', '7');
INSERT INTO `t_user_role` VALUES ('2423442312-2057706426', '7');
INSERT INTO `t_user_role` VALUES ('31084032391220506', '7');
INSERT INTO `t_user_role` VALUES ('095838356139785452', '7');
INSERT INTO `t_user_role` VALUES ('14123225361433566448', '7');
INSERT INTO `t_user_role` VALUES ('1834365665-1336484564', '7');
INSERT INTO `t_user_role` VALUES ('2532486961328107923', '7');
INSERT INTO `t_user_role` VALUES ('2832251829-1459661797', '7');
INSERT INTO `t_user_role` VALUES ('1628470356-150796453', '7');
INSERT INTO `t_user_role` VALUES ('17485337411210421704', '7');
INSERT INTO `t_user_role` VALUES ('13666804111669715157', '7');
INSERT INTO `t_user_role` VALUES ('23325727681185886863', '7');
INSERT INTO `t_user_role` VALUES ('0960585756960547739', '7');
INSERT INTO `t_user_role` VALUES ('034620583336425010', '7');
INSERT INTO `t_user_role` VALUES ('0611396024110801579', '7');
INSERT INTO `t_user_role` VALUES ('086515671738740821', '7');
INSERT INTO `t_user_role` VALUES ('0909245922-2060846180', '7');
INSERT INTO `t_user_role` VALUES ('1528452059-112991602', '7');
INSERT INTO `t_user_role` VALUES ('03490532192100065813', '5');
INSERT INTO `t_user_role` VALUES ('093819666535550621', '7');
INSERT INTO `t_user_role` VALUES ('1528452059-112991602', '5');
INSERT INTO `t_user_role` VALUES ('09096946011894151846', '25');
INSERT INTO `t_user_role` VALUES ('03490532192100065813', '26');
INSERT INTO `t_user_role` VALUES ('033201324929226046', '6');
INSERT INTO `t_user_role` VALUES ('18041756401905342891', '5');
INSERT INTO `t_user_role` VALUES ('04204840391354059900', '5');

-- ----------------------------
-- View structure for feedindex
-- ----------------------------
DROP VIEW IF EXISTS `feedindex`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER  VIEW `feedindex` AS SELECT uuid,type,time,content,dutyname,dutyid,leixing,suggest,fstatus,deptname,toname,toid,endtime,createid FROM 
	(SELECT d_id AS uuid,'1' AS type,d_create_time AS time,d_desc AS content,d_duter_name AS dutyname,d_duter_id AS dutyid,'' AS leixing,
d_suggest AS suggest,d_status AS fstatus,d_dept_name AS deptname,d_topeo_name AS toname,d_topeo_id AS toid,d_jie_time AS endtime,d_creator_id AS createid from tg_fb_dept
UNION ALL
	SELECT sys_id AS uuid,'2' AS type,sys_creattime AS time,sys_desc AS content,sys_duter_name AS dutyname,sys_duter AS dutyid,sys_type AS leixing,sys_suggest AS suggest,
sys_status AS fstatus,sys_deptname AS deptname,sys_topeople_name AS toname,sys_topeople AS toid,sys_endtime AS endtime,sys_creator AS createid from tg_fb_system
UNION ALL
	SELECT w_id AS uuid,'3' AS type,w_creat_time AS time,w_desc AS content,w_dutyer_name AS dutyname,w_dutyer_id AS dutyid,w_type AS leixing,w_suggest AS suggest,
w_status AS fstatus,w_dept_name AS deptname,w_topeo_name AS toname,w_topeo_id AS toid,w_jie_time AS endtime,w_create_id AS createid from tg_fb_work
UNION ALL
	SELECT c_id AS uuid,'4' AS type,c_create_time AS time,c_desc AS content,c_topeo_name AS dutyname,'' AS dutyid,c_type AS leixing,c_suggest AS suggest,c_status AS fstatus,
'企业' AS deptname,c_topeo_name AS toname,c_topeo_id AS toid,c_jie_time AS endtime,c_create_id AS createid from tg_fb_company) as fbi
ORDER BY fbi.time desc ; ;

-- ----------------------------
-- View structure for workindex
-- ----------------------------
DROP VIEW IF EXISTS `workindex`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER  VIEW `workindex` AS SELECT uuid,puid,time,type,deptid,duterid,content,leixing,tiid,mudalid,wstatus,ytime,deptname,dutyname FROM
	(SELECT wk_uuid as uuid,wk_puid as puid,wk_create_time as time,'1' as type,wk_dept_id as deptid,wk_duty_id as duterid,wk_content as content,wk_type as leixing,wk_create_name as tiid,wk_auditid as mudalid,wk_status as wstatus,
					wk_end_time as ytime,wk_dept_name as deptname,wk_duty_name as dutyname FROM tg_work_kao
UNION ALL
	 SELECT pk_id as uuid,pk_pid as puid,pk_time as time,'2' as type,pk_deptid as deptid,pk_duty_id as duterid,pk_content as content,'3' as leixing,pk_create_name as tiid,'' as mudalid,pk_status as wstatus,
					pk_apptime as ytime,pk_dept_name as deptname,pk_duty_name as dutyname FROM tg_per_kao
) as wid ; ;

-- ----------------------------
-- Procedure structure for updateWorkStart
-- ----------------------------
DROP PROCEDURE IF EXISTS `updateWorkStart`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `updateWorkStart`(IN `cycle` char)
BEGIN
	#Routine body goes here...
	UPDATE tg_work_plan set w_status = '1' where w_start_time = DATE_FORMAT(NOW(),'%Y-%m-%d');
END
;;
DELIMITER ;
