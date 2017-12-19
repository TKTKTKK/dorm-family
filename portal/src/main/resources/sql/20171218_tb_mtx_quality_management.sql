-- 修改表名
alter table tb_mtx_repair_worker rename tb_mtx_worker;

-- repairid变为refid
alter table tb_mtx_worker  change column repairid refid varchar(32) NOT NULL;

-- 保养流水号
INSERT INTO `tb_common_sequence` (`name`, `current_value`, `increment`) VALUES ('MTX_MAINTAIN', 0, 1);

-- 修改表名
alter table tb_mtx_repair rename tb_mtx_quality_management;

-- 增加type
alter table tb_mtx_quality_management add column `type` varchar(10) NOT NULL after reporterphone;

-- 更新已有数据为报修
update tb_mtx_quality_management set type='REPAIR';

-- repairdt变为servicedt
alter table tb_mtx_quality_management  change column repairdt servicedt varchar(23) DEFAULT NULL ;

-- content(保养)允许为空
alter table tb_mtx_quality_management  change column content content varchar(256) DEFAULT NULL;

-- 更新菜单url
update tb_platform_permit set permitresource='admin/wefamily/maintainManage' where uuid = '2017120510000003';

-- 保养报修code
update tb_common_code  set codevalue='未处理' where uuid='2017121300000001';
update tb_common_code  set codevalue='处理中' where uuid='2017121300000003';






