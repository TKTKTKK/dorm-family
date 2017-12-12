
-- 创建产品表
CREATE TABLE `tb_mtx_product` (
  `uuid` varchar(32) NOT NULL,
  `model` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `img` varchar(256) DEFAULT NULL,
  `status` varchar(8) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `detail` text(0) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 产品管理
INSERT INTO `tb_platform_permit` VALUES ('2017120410000002', 'MENU', '产品管理', 'admin/wefamily/MtxProduct', '2015050510000011', '1102', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');

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

-- 咨询管理
INSERT INTO `tb_platform_permit` VALUES ('2017120510000005', 'MENU', '咨询管理', 'admin/wefamily/mtxReserveManage', '2015050510000011', '1104', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');

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

-- 留言管理
INSERT INTO `tb_platform_permit` VALUES ('2017120610000002', 'MENU', '留言管理', 'admin/wefamily/mtxConsultManage', '2015050510000011', '1105', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');

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


-- 会员管理
INSERT INTO `tb_platform_permit` VALUES ('2017120810000001', 'MENU', '会员管理', 'admin/wefamily/mtxMemberManage', '2015050510000011', '1106', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');

-- 商品兑换表
CREATE TABLE `tb_mtx_good_exchange` (
  `uuid` varchar(32) NOT NULL,
  `name` varchar(48) NOT NULL,
  `img` varchar(256) DEFAULT NULL,
  `detail` varchar(256) DEFAULT NULL,
  `points` decimal(10) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 商品兑换管理
INSERT INTO `tb_platform_permit` VALUES ('2017120910000002', 'MENU', '商品兑换管理', 'admin/wefamily/mtxGoodManage', '2015050510000011', '1108', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');



-- 积分消费记录表
CREATE TABLE `tb_mtx_point_record` (
  `uuid` varchar(32) NOT NULL,
  `userid` varchar(32) NOT NULL,
  `machineid` varchar(32) DEFAULT NULL,
  `goodid` varchar(32) DEFAULT NULL,
  `points` decimal(10) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 积分管理
INSERT INTO `tb_platform_permit` VALUES ('2017120910000001', 'MENU', '积分管理', 'admin/wefamily/mtxPointManage', '2015050510000011', '1107', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');


alter table tb_wp_user add column `merchantid`  varchar(32) default null AFTER openid;
alter table tb_wp_user add column `machineid`  varchar(32) default null AFTER merchantid;
alter table tb_wp_user add column `province`  varchar(60) default null AFTER contactno;
alter table tb_wp_user add column `city`  varchar(60) default null AFTER province;
alter table tb_wp_user add column `district`  varchar(60) default null AFTER city;
alter table tb_wp_user add column `address`  varchar(256) default null AFTER district;
alter table tb_wp_user add column `points`  decimal(16) default null AFTER address;
