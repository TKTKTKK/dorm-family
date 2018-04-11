-- 宿舍楼
DROP TABLE IF EXISTS `tb_dorm_dormitory`;
CREATE TABLE `tb_dorm_dormitory` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) DEFAULT NULL,
  `name` varchar(48) NOT NULL,
  `frequentcontacts` varchar(10) DEFAULT NULL ,
  `contactsphone` varchar(20) DEFAULT NULL ,
  `contactno` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL ,
  `logo` varchar(100) DEFAULT NULL,
  `type` varchar(20) NOT NULL ,
  `remarks` varchar(100) DEFAULT NULL ,
  `electricfence` varchar(200) DEFAULT NULL ,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 宿舍楼与用户关系
DROP TABLE IF EXISTS `tb_dorm_dormitory_user`;
CREATE TABLE `tb_dorm_dormitory_user` (
  `uuid` varchar(32) NOT NULL,
  `userid` varchar(32) DEFAULT NULL,
  `dormitoryid` varchar(48) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 宿舍类型
INSERT INTO tb_common_code VALUES ('201804110001', null, null, 'DORMITORY_TYPE', 'N', '普通', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804110002', null, null, 'DORMITORY_TYPE', 'F', '公寓', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804110003', null, null, 'DORMITORY_TYPE', 'T', '教师', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
