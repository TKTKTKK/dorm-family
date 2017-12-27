
-- 经销商备注
alter table tb_mtx_order add  column merchantremarks VARCHAR(256) DEFAULT  NULL AFTER `fueltank`;

-- qualityMgmt 状态code
UPDATE `tb_common_code` set  codevalue='新任务' where uuid='2017121300000001';

DELETE FROM `tb_common_code` WHERE uuid = '2017121300000002';


