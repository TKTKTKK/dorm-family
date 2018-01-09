
-- 会员增加耕地面积
alter table tb_wp_user add  column area decimal(10,2) DEFAULT NULL AFTER  contactno;
