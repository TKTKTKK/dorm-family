-- Table structure for tb_mtx_order
-- ----------------------------
CREATE TABLE `tb_mtx_order` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `snno` varchar(32) NOT NULL,
  `machinemodel` varchar(32) NOT NULL,
  `quantity` int(11) NOT NULL,
  `electricstart` VARCHAR(10) NOT NULL ,
  `rowspace` VARCHAR(10) NOT NULL ,
  `transversetime` VARCHAR(10) NOT NULL,
  `seedlingneedle` varchar(10) NOT NULL,
  `entrusttransport` VARCHAR(10) NOT NULL,
  `seedlingbasket` VARCHAR(10) NOT NULL,
  `coverall` VARCHAR(10) NOT NULL,
  `plasticcover` VARCHAR(10) NOT NULL,
  `fueltank` VARCHAR(10) NOT NULL,
  `status` VARCHAR(10) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- order-code
-- 添加株距要求
INSERT INTO tb_common_code VALUES ('2017120500000001', null, null, 'ROW_SPACE', '120', '120', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120500000002', null, null, 'ROW_SPACE', '140', '140', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120500000003', null, null, 'ROW_SPACE', '160', '160', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120500000004', null, null, 'ROW_SPACE', '180', '180', null,'', '4', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120500000005', null, null, 'ROW_SPACE', '210', '210', null,'', '5', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120500000006', null, null, 'ROW_SPACE', '280', '280', null,'', '6', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

-- 添加横向送秧次数
INSERT INTO tb_common_code VALUES ('2017120500000007', null, null, 'TRANSVERSE_TIME', '14', '14', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120500000008', null, null, 'TRANSVERSE_TIME', '18', '18', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120500000009', null, null, 'TRANSVERSE_TIME', '20', '20', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120500000010', null, null, 'TRANSVERSE_TIME', '26', '26', null,'', '4', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

-- 添加宽秧针
INSERT INTO tb_common_code VALUES ('2017120500000011', null, null, 'SEEDLING_NEEDLE', 'NORMAL', '标准', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120500000012', null, null, 'SEEDLING_NEEDLE', 'WIDEN', '加宽', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

-- 添加载秧篮
INSERT INTO tb_common_code VALUES ('2017120500000013', null, null, 'SEEDLING_BASKET', 'NORMAL', '标准', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120500000014', null, null, 'SEEDLING_BASKET', 'WIDEN', '加宽', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

-- 添加委托运输
INSERT INTO tb_common_code VALUES ('2017120500000015', null, null, 'ENTRUST_TRANSPORT', 'SELF', '自提', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120500000016', null, null, 'ENTRUST_TRANSPORT', 'ENTRUST', '委托运输', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120500000017', null, null, 'ENTRUST_TRANSPORT', 'ALLOCATE', '配载', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

INSERT INTO tb_common_code VALUES ('2017120700000001', null, null, 'ORDER_CHOOSE', 'Y', '选配', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120700000002', null, null, 'ORDER_CHOOSE', 'N', '不选配', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');


-- 订单流水号
INSERT INTO `tb_common_sequence` (`name`, `current_value`, `increment`) VALUES ('MTX_ORDER', 0, 1);