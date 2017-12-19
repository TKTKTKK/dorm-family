

alter table tb_mtx_reserve add  column status VARCHAR(15) DEFAULT  NULL AFTER detail;
alter table tb_mtx_reserve add  column remarks VARCHAR(256) DEFAULT  NULL AFTER status;


INSERT INTO tb_common_code VALUES ('2017121800000001', null, null, 'DEAL_STATUS', 'C_DEAL', '已处理', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017121800000002', null, null, 'DEAL_STATUS', 'N_DEAL', '未处理', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

