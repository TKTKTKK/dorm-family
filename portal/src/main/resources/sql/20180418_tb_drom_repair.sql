

-- 报修
CREATE TABLE `tb_dorm_repair` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `snno` varchar(32) NOT NULL,
  `dormitoryid` varchar(32) NOT NULL,
  `layer` varchar(15) DEFAULT NULL,
  `roomno` varchar(32) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `reporter` varchar(32) DEFAULT NULL,
  `reporterstuno` varchar(32) DEFAULT NULL,
  `reportername` varchar(32) DEFAULT NULL,
  `reporterphone` varchar(32) DEFAULT NULL,
  `worker` varchar(32) DEFAULT NULL ,
  `servicedt` varchar(23) DEFAULT NULL,
  `repairdt` varchar(23) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `content` varchar(256) DEFAULT NULL,
  `remarks` varchar(256) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 报修类型
INSERT INTO tb_common_code VALUES ('201804180001', null, null, 'REPAIR_TYPE', 'STUDENT', '学生', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804180002', null, null, 'REPAIR_TYPE', 'DORMMANAGER', '宿管', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

