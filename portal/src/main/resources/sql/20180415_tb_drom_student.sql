

-- 学生
CREATE TABLE `tb_dorm_student` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `dormitoryid` varchar(32) NOT NULL,
  `layer` varchar(15) DEFAULT NULL,
  `roomno` varchar(32) DEFAULT NULL,
  `openid` varchar(32) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `nation` varchar(10) DEFAULT NULL,
  `political` varchar(10) DEFAULT NULL,
  `stuno` varchar(20) NOT NULL,
  `name` varchar(90) DEFAULT NULL,
  `contactno` varchar(20) DEFAULT NULL,
  `idno` varchar(30) DEFAULT NULL,
  `idtype` varchar(20) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `remarks` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL COMMENT 'NORMAL- 舍员  DORMHEAD - 舍长',
  `dormtype` varchar(15) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 学生类型
INSERT INTO tb_common_code VALUES ('201804160001', null, null, 'STUDENT_TYPE', 'NORMAL', '舍员', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804160002', null, null, 'STUDENT_TYPE', 'DORMHEAD', '舍长', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');


-- 证件类型
INSERT INTO tb_common_code VALUES ('201804160003', null, null, 'ID_TYPE', 'ID', '身份证', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804160004', null, null, 'ID_TYPE', 'PASSPORT', '护照', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804160005', null, null, 'ID_TYPE', 'MTPTR', '台湾居民往来大陆通行证', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804160006', null, null, 'ID_TYPE', 'MTPHKM', '港澳通行证', null,'', '4', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804160007', null, null, 'ID_TYPE', 'OTHER', '其他', null,'', '5', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

-- 政治面貌
INSERT INTO tb_common_code VALUES ('201804160008', null, null, 'POLITICAL', 'COMMUNIST', '共产党员', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804160009', null, null, 'POLITICAL', 'YOUTHCOM', '团员', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804160010', null, null, 'POLITICAL', 'GENERAL', '群众', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804160011', null, null, 'POLITICAL', 'OTHER', '其他党派', null,'', '4', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');


