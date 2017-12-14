-- 订单增加经销商
alter table tb_mtx_order add column `merchantid`  varchar(32) not null AFTER bindid;

-- 报修流水号
INSERT INTO `tb_common_sequence` (`name`, `current_value`, `increment`) VALUES ('MTX_REPAIR', 0, 1);

-- 维修状态
INSERT INTO tb_common_code VALUES ('2017121300000001', null, null, 'REPAIR_STATUS', 'NEW', '新报修', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017121300000002', null, null, 'REPAIR_STATUS', 'DISTRIBUTED', '已分配', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017121300000003', null, null, 'REPAIR_STATUS', 'REPAIRING', '维修中', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017121300000004', null, null, 'REPAIR_STATUS', 'FINISH', '已完成', null,'', '4', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

-- 维修评价
INSERT INTO tb_common_code VALUES ('2017121300000008', null, null, 'REPAIR_EVALUATE', 'GOOD', '好', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017121300000009', null, null, 'REPAIR_EVALUATE', 'NORMAL', '中', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017121300000010', null, null, 'REPAIR_EVALUATE', 'BAD', '差', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');


-- Table structure for tb_mtx_repair
-- ----------------------------
DROP TABLE IF EXISTS `tb_mtx_repair`;
CREATE TABLE `tb_mtx_repair` (
  `uuid` varchar(32) NOT NULL,
  `snno` varchar(32) NOT NULL ,
  `machinemodel` varchar(32) DEFAULT NULL,
  `engineno` varchar(32) DEFAULT NULL,
  `machineno` varchar(32) DEFAULT NULL,
  `productiondt` varchar(23) DEFAULT NULL,
  `reporter` varchar(32) DEFAULT NULL,
  `reportername` varchar(20) NOT NULL,
  `reporterphone` varchar(20) NOT NULL,
  `merchantid` varchar(32) DEFAULT NULL,
  `repairdt` varchar(23) DEFAULT NULL,
  `evaluate` varchar(10) DEFAULT NULL,
  `location` varchar(32) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `content` varchar(256) NOT NULL,
  `remarks` varchar(256) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Table structure for tb_mtx_repair_worker
-- ----------------------------
DROP TABLE IF EXISTS `tb_mtx_repair_worker`;
CREATE TABLE `tb_mtx_repair_worker` (
  `uuid` varchar(32) NOT NULL,
  `repairid` varchar(32) NOT NULL,
  `openid` VARCHAR (32) DEFAULT NULL ,
  `name` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

