
-- 把配件产地改成说明书版本
alter table tb_mtx_machine CHANGE address instruction VARCHAR (64) DEFAULT  null;

-- 增加一个字段标记产品的价格是否可见
alter table tb_mtx_product add COLUMN watchornot VARCHAR (1) DEFAULT  'N' AFTER price;

-- 修改咨询购买的状态为 已联系、未联系、已转代理商
delete from tb_common_code where uuid in('2017121800000001','2017121800000002');

INSERT INTO tb_common_code VALUES ('2017121800000001', null, null, 'DEAL_STATUS', 'C_DEAL', '已联系', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017121800000002', null, null, 'DEAL_STATUS', 'N_DEAL', '未联系', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017121800000003', null, null, 'DEAL_STATUS', 'CHANGE', '已转代理商', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');


-- 留言关联经销商
alter table tb_mtx_reserve add  column merchantid VARCHAR (32) DEFAULT  NULL AFTER productid;

-- 增加兑换处理状态   已处理  未处理
INSERT INTO tb_common_code VALUES ('2018010500000001', null, null, 'CONFIRM_STATUS', 'C_DEAL', '已处理', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2018010500000002', null, null, 'CONFIRM_STATUS', 'N_DEAL', '未处理', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
