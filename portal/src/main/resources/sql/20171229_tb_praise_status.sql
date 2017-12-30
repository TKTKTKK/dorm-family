-- 红包发放状态

alter table tb_mtx_train add  column praisestatus VARCHAR(10) DEFAULT  NULL AFTER `status`;
alter table tb_mtx_train add  column praiseremarks VARCHAR(256) DEFAULT  NULL AFTER `praisestatus`;

alter table tb_mtx_quality_management add  column praisestatus VARCHAR(10) DEFAULT  NULL AFTER `remarks`;
alter table tb_mtx_quality_management add  column praiseremarks VARCHAR(256) DEFAULT  NULL AFTER `praisestatus`;

-- 红包发放状态code
INSERT INTO tb_common_code VALUES ('2017122900000001', null, null, 'PRAISE_STATUS', 'NO', '不发放', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017122900000002', null, null, 'PRAISE_STATUS', 'UNPRAISED', '未发放', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017122900000003', null, null, 'PRAISE_STATUS', 'PRAISED', '已发放', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');


