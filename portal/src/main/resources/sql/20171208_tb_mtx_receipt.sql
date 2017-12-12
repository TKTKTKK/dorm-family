-- Table structure for tb_mtx_receipt
-- ----------------------------
DROP TABLE IF EXISTS `tb_mtx_receipt`;
CREATE TABLE `tb_mtx_receipt` (
  `uuid` varchar(32) NOT NULL,
  `orderid` varchar(32) NOT NULL,
  `question` varchar(100) DEFAULT NULL,
  `satisfaction` varchar(10) NOT NULL,
  `receiptdt` varchar(23) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 满意度
INSERT INTO tb_common_code VALUES ('2017120800000001', null, null, 'SATISFACTION', 'H', '非常满意', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120800000002', null, null, 'SATISFACTION', 'M', '满意', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120800000003', null, null, 'SATISFACTION', 'N', '一般', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120800000004', null, null, 'SATISFACTION', 'L', '不满意', null,'', '4', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120800000005', null, null, 'SATISFACTION', 'W', '非常不满意', null,'', '5', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

-- 订单状态code
INSERT INTO tb_common_code VALUES ('2017120900000001', null, null, 'ORDER_STATUS', 'NEW', '未发送', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120900000002', null, null, 'ORDER_STATUS', 'OUT', '已发送', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120900000003', null, null, 'ORDER_STATUS', 'FINISH', '已完成', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
