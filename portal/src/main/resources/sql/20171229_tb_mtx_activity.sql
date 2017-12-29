-- 中奖总人数
alter table tb_mtx_activity add  column totalParticipant int(3) DEFAULT  NULL AFTER status;
-- 每轮中奖人数
alter table tb_mtx_activity add  column everyParticipant int(3) DEFAULT  NULL AFTER totalParticipant;
