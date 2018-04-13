

-- 用户状态
INSERT INTO tb_common_code VALUES ('201804120001', null, null, 'USER_STATUS', 'NORMAL', '正常', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804120002', null, null, 'USER_STATUS', 'FREEZE', '冻结', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');


-- 宿舍房间
DROP TABLE IF EXISTS `tb_dorm_address`;
CREATE TABLE `tb_dorm_address` (
  `uuid` varchar(32) NOT NULL,
  `dormitoryid` varchar(32) NOT NULL,
  `layer` varchar(10) NOT NULL,
  `roomno` varchar(10) NOT NULL ,
  `area` DECIMAL (10) DEFAULT NULL ,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;