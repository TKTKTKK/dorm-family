
-- 已经中奖人数
alter table tb_mtx_activity add  column currentLuckyCount int(3) DEFAULT  0 AFTER everyLuckyCount;
