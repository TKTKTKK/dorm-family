
-- 经销商增加常用联系人电话
alter table tb_mtx_merchant add  column contactsphone VARCHAR (20) DEFAULT  NULL AFTER  frequentcontacts;
