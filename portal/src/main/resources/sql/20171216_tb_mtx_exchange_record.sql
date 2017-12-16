
-- 兑换记录表
CREATE TABLE `tb_mtx_exchange_record` (
  `uuid` varchar(32) NOT NULL,
  `userid` varchar(32) NOT NULL,
  `productid` varchar(32) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `address` varchar(90) DEFAULT NULL,
  `detail` varchar(256) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `tb_platform_permit` VALUES ('2017121610000001', 'MENU', '兑换记录管理', 'admin/wefamily/mtxExchangeRecordManage', '2015050510000011', '1111', 'APP', now(), 'sys', now(), 'sys', '1', 'N', '');


alter table `tb_mtx_machine`  add column type varchar(15)  default null AFTER `standardpower`;
alter table `tb_mtx_machine`  add column price decimal(10,2)  default null AFTER `type`;
alter table `tb_mtx_machine`  add column address varchar(256)  default null AFTER `price`;
alter table `tb_mtx_machine`  add column format varchar(10)  default null AFTER `address`;


INSERT INTO tb_common_code VALUES ('2017121600000001', null, null, 'MACHINE_TYPE', 'MACHINE', '机器', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017121600000002', null, null, 'MACHINE_TYPE', 'PARTS', '配件', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

alter table `tb_mtx_reserve`  add column type varchar(15)  default null AFTER `address`;
alter table `tb_mtx_usermachine`  add column type varchar(15)  default null AFTER `machineid`;

alter table `tb_mtx_machine` modify `productiondate`  varchar(23)   null;
alter table `tb_mtx_machine` modify `engineno`  varchar(32)   null;



