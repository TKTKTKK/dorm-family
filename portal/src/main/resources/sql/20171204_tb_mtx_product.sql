
-- 创建产品表
CREATE TABLE `tb_mtx_product` (
  `uuid` varchar(32) NOT NULL,
  `model` varchar(32) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `img` varchar(256) DEFAULT NULL,
  `status` varchar(8) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `detail` text(0) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 创建预订表
CREATE TABLE `tb_mtx_reserve` (
  `uuid` varchar(32) NOT NULL,
  `productid` varchar(32) default null,
  `name` varchar(48) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `province` varchar(60) NOT NULL,
  `city` varchar(60) NOT NULL,
  `district` varchar(60) NOT NULL,
  `address` varchar(256) NOT NULL,
  `detail` varchar(256) default null,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 创建留言表
CREATE TABLE `tb_mtx_consult` (
  `uuid` varchar(32) NOT NULL,
  `userid` varchar(32) default null,
  `identify` varchar(32) NOT NULL,
  `status` varchar(16) default null,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 创建留言详情表
CREATE TABLE `tb_mtx_consult_detail` (
  `uuid` varchar(32) NOT NULL,
  `consultid` varchar(32) NOT NULL,
  `content` varchar(256) default null,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 选取用户身份
INSERT INTO tb_common_code VALUES ('2017120700000003', null, null, 'IDENTITY_CODE', 'COOPERATION', '合作社', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120700000004', null, null, 'IDENTITY_CODE', 'COMMON_USER', '普通用户', null,'', '4', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120700000005', null, null, 'IDENTITY_CODE', 'AGENT', '代理商', null,'', '5', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

-- 留言回复状态
INSERT INTO tb_common_code VALUES ('2017120700000007', null, null, 'ANWSER_OR_NOT', 'ANWSER_RECENT', '已回复', null,'', '7', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017120700000008', null, null, 'ANWSER_OR_NOT', 'NO_ANWSER', '未回复', null,'', '8', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

-- 积分消费记录表
CREATE TABLE `tb_mtx_point_record` (
  `uuid` varchar(32) NOT NULL,
  `userid` varchar(32) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
   `points` int(11) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table tb_wp_user add column `province`  varchar(60) default null AFTER contactno;
alter table tb_wp_user add column `city`  varchar(60) default null AFTER province;
alter table tb_wp_user add column `district`  varchar(60) default null AFTER city;
alter table tb_wp_user add column `address`  varchar(256) default null AFTER district;
alter table tb_wp_user add column `points`  int(11) default null AFTER address;

-- 产品还是兑换商品
INSERT INTO tb_common_code VALUES ('2017121300000006', null, null, 'TYPE_CODE', 'PRODUCT', '产品', null,'', '6', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017121300000007', null, null, 'TYPE_CODE', 'EXCHANGE_GOOD', '兑换商品', null,'', '7', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');


-- 创建用户产品表
CREATE TABLE `tb_mtx_usermachine` (
  `uuid` varchar(32) NOT NULL,
   `userid` varchar(32) DEFAULT NULL,
  `machineid` varchar(32) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
