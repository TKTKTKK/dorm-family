-- 维修工人 openid变为userid
alter table tb_mtx_repair_worker  change column openid userid varchar(32) NOT NULL;

alter table tb_mtx_repair change column workarea workarea varchar(20) DEFAULT NULL ;

alter table tb_mtx_repair change column arrivetime arrivetime varchar(20) DEFAULT NULL ;

