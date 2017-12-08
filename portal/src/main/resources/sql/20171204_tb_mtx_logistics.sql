-- Table structure for tb_mtx_logistics
-- ----------------------------
DROP TABLE IF EXISTS `tb_mtx_logistics`;
CREATE TABLE `tb_mtx_logistics` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `orderid` varchar(32) NOT NULL,
  `driverphone` varchar(20) NOT NULL,
  `location` varchar(32) DEFAULT NULL,
  `platenumber` varchar(20) NOT NULL,
  `freight` decimal(10,2) DEFAULT NULL,
  `status` VARCHAR(10) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 添加物流状态
INSERT INTO tb_common_code VALUES ('2017120700000009', null, null, 'LOGISTICS_STATUS', 'NEW', '待发货', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120700000010', null, null, 'LOGISTICS_STATUS', 'TRANSPORT', '运输中', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120700000011', null, null, 'LOGISTICS_STATUS', 'ARRIVED', '已到达', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120700000012', null, null, 'LOGISTICS_STATUS', 'SIGNED', '已签收', null,'', '4', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');





-- Table structure for tb_mtx_machine
-- ----------------------------
DROP TABLE IF EXISTS `tb_mtx_machine`;
CREATE TABLE `tb_mtx_machine` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `orderid` varchar(32) DEFAULT NULL,
  `machinename` varchar(32) NOT NULL,
  `machinemodel` varchar(32) NOT NULL,
  `machineno` varchar(32) NOT NULL,
  `engineno` varchar(32) NOT NULL,
  `productiondate` varchar(23) NOT NULL,
  `standardpower` varchar(32) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;