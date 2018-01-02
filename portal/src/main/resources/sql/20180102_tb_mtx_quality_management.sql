
-- 增加用户评价备注
alter table tb_mtx_quality_management add column `evaluateremarks` varchar(256) DEFAULT NULL after evaluate;

alter table tb_mtx_train add column `situationremarks` varchar(256) DEFAULT NULL after situation;

-- 培训增加用户
alter table tb_mtx_train add column `person` varchar(32) DEFAULT NULL after productiondt;













