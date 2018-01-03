
-- 经销商
alter table tb_mtx_merchant add  column legalperson VARCHAR (90) DEFAULT  NULL AFTER  contactno;
alter table tb_mtx_merchant add  column license VARCHAR (256) DEFAULT  NULL AFTER  legalperson;
alter table tb_mtx_merchant add  column frequentcontacts VARCHAR (90) DEFAULT  NULL AFTER  license;
