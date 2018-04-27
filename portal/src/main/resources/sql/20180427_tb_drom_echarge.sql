-- 电费记录
CREATE TABLE `tb_dorm_echarge` (
  `uuid` varchar(32) NOT NULL,
  `snno` varchar(32) NOT NULL,
  `dormitoryid` varchar(32) NOT NULL,
  `layer` varchar(32) NOT NULL,
  `roomno` varchar(32) not null,
  `stuid` varchar(32) not null,
  `price` decimal(10,2) DEFAULT NULL,
  `paytype` varchar(20) DEFAULT null,
  `status` varchar(20) DEFAULT null,
  `remarks` varchar(256) DEFAULT null,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 电费缴费方式
INSERT INTO tb_common_code VALUES ('201804270001', null, null, 'ECHARGE_PAYTYPE', 'CASH', '现金', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804270002', null, null, 'ECHARGE_PAYTYPE', 'WECHAT', '微信', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('201804270003', null, null, 'ECHARGE_PAYTYPE', 'ALIPAY', '支付宝', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');


-- 缴费记录流水号
INSERT INTO `tb_common_sequence` (`name`, `current_value`, `increment`) VALUES ('DORM_ECHARGE', 0, 1);