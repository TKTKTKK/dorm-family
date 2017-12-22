
-- 把商品兑换管理改成积分商城
-- 把兑换记录管理改成兑换记录
UPDATE `tb_platform_permit` set  permitname='积分商城' where uuid='2017120910000002';
UPDATE `tb_platform_permit` set  permitname='兑换记录' where uuid='2017121610000001';

alter table tb_mtx_exchange_record add  column status VARCHAR(15) DEFAULT  NULL AFTER detail;
alter table tb_mtx_exchange_record add  column remarks VARCHAR(256) DEFAULT  NULL AFTER status;
-- 修改留言的字符集
ALTER TABLE tb_mtx_consult_detail  MODIFY content VARCHAR(256) CHARACTER SET utf8mb4;