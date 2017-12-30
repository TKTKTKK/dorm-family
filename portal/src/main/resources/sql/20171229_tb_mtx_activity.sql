-- 中奖总人数
alter table tb_mtx_activity add  column totalLuckyCount int(3) DEFAULT  NULL AFTER status;
-- 每轮中奖人数
alter table tb_mtx_activity add  column everyLuckyCount int(3) DEFAULT  NULL AFTER totalLuckyCount;
