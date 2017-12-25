
-- 活动表 时间、地点、介绍、密码、状态
CREATE TABLE `tb_mtx_activity` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `merchantid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `startdate` varchar(23) NOT NULL,
  `img` varchar(256) not null,
  `enddate` varchar(23) NOT NULL,
  `address` varchar(90) NOT NULL,
  `detail` text(0) DEFAULT NULL,
  `password` varchar(48) DEFAULT NULL,
  `status` varchar(15) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 活动参与表
CREATE TABLE `tb_mtx_activity_participant` (
  `uuid` varchar(32) NOT NULL,
  `userid` varchar(32) NOT NULL,
  `activityid` varchar(32) NOT NULL,
  `status` varchar(15) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;



INSERT INTO `tb_platform_permit` VALUES ('2017122310000001', 'MENU', '活动管理', 'admin/wefamily/mtxActivityManage', '2017122110000004', '1113', 'APP', now(), 'sys', now(), 'sys', '1', 'N', '');

-- 活动状态
INSERT INTO tb_common_code VALUES ('2017122300000001', null, null, 'ACTIVITY_STATUS', 'INIT', '未进行', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017122300000002', null, null, 'ACTIVITY_STATUS', 'PENDING', '进行中', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017122300000003', null, null, 'ACTIVITY_STATUS', 'APP', '已结束', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
