-- 订单状态
DELETE FROM tb_common_code WHERE codetype = 'ORDER_STATUS';


INSERT INTO tb_common_code VALUES ('2017122200000001', null, null, 'ORDER_STATUS', 'UNSUBMIT', '未发送', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017122200000002', null, null, 'ORDER_STATUS', 'NEW', '新订单', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017122200000003', null, null, 'ORDER_STATUS', 'INPLAN', '计划中', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017122200000004', null, null, 'ORDER_STATUS', 'INLOGISTICS', '运输中', null,'', '4', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017122200000005', null, null, 'ORDER_STATUS', 'RECEIVED', '已收货', null,'', '5', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017122200000006', null, null, 'ORDER_STATUS', 'FILED', '归档完成', null,'', '6', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');



-- 机器备注
alter table tb_mtx_machine add  column remarks VARCHAR(256) DEFAULT  NULL AFTER `format`;

-- 订单状态长度
alter table tb_mtx_order change column status status varchar(20) NOT NULL ;
-- 订单备注
alter table tb_mtx_order add  column remarks VARCHAR(256) DEFAULT  NULL AFTER `status`;

-- 培训增加经销商
alter table tb_mtx_train add column merchantid  varchar(32) not null AFTER `uuid`;

-- 培训增加编号
alter table tb_mtx_train add column snno  varchar(32) not null AFTER `uuid`;

-- 培训流水号
INSERT INTO `tb_common_sequence` (`name`, `current_value`, `increment`) VALUES ('MTX_TRAIN', 0, 1);

