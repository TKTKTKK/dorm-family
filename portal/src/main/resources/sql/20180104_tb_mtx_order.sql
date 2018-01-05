
-- 订单运费
alter table tb_mtx_order add  column freight decimal(10,2) DEFAULT  NULL AFTER  merchantremarks;

-- 品质服务奖励状态描述
UPDATE `tb_common_code` set  codevalue='不同意发放' where uuid='2017122900000001';
UPDATE `tb_common_code` set  codevalue='同意但未发放' where uuid='2017122900000002';

-- 前端报修增加位置
alter table tb_mtx_quality_management add  column reportlocation VARCHAR (32) DEFAULT  NULL AFTER  productiondt;


