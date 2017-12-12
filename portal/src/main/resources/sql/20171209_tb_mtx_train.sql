-- Table structure for tb_mtx_train
-- ----------------------------
DROP TABLE IF EXISTS `tb_mtx_train`;
CREATE TABLE `tb_mtx_train` (
  `uuid` varchar(32) NOT NULL,
  `machinemodel` varchar(32) NOT NULL,
  `engineno` varchar(32) NOT NULL,
  `machineno` varchar(32) NOT NULL,
  `productiondt` varchar(23) NOT NULL,
  `personname` varchar(90) NOT NULL,
  `personphone` varchar(20) NOT NULL,
  `program` varchar(255) DEFAULT NULL,
  `type` varchar(10) NOT NULL,
  `traindt` varchar(23) NOT NULL,
  `situation` varchar(10) DEFAULT NULL,
  `location` varchar(32) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 培训项目
INSERT INTO tb_common_code VALUES ('2017120900000004', null, null, 'TRAIN_PROGRAM', 'ADD_GREASE', '插植臂处使用后应涂加黄油', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120900000005', null, null, 'TRAIN_PROGRAM', 'CHANGE_MACHINE_OIL', '发动机使用50小时，更换机油', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120900000006', null, null, 'TRAIN_PROGRAM', 'REGULAR_GASOLINE', '应该使用95号正规加油站汽油', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120900000007', null, null, 'TRAIN_PROGRAM', 'PROBLEM_PHONE', '故障问题的联系电话', null,'', '4', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120900000008', null, null, 'TRAIN_PROGRAM', 'COMPLAIN_PHONE', '服务投诉电话', null,'', '5', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

-- 培训情况
INSERT INTO tb_common_code VALUES ('2017120900000009', null, null, 'TRAIN_SITUATION', 'GOOD', '好', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120900000010', null, null, 'TRAIN_SITUATION', 'NORMAL', '中', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120900000011', null, null, 'TRAIN_SITUATION', 'BAD', '差', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

-- 培训状态
INSERT INTO tb_common_code VALUES ('2017120900000012', null, null, 'TRAIN_STATUS', 'NEW', '未完成', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120900000013', null, null, 'TRAIN_STATUS', 'FINISH', '已完成', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

-- 培训类型
INSERT INTO tb_common_code VALUES ('2017121100000001', null, null, 'TRAIN_TYPE', 'FIRST', '首次培训', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017121100000002', null, null, 'TRAIN_TYPE', 'SCENE', '现场培训', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
