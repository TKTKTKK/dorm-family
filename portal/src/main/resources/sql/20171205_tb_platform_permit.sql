-- 修改菜单
UPDATE `tb_platform_permit` set permitname='销售服务'  where uuid='2015050510000011';

UPDATE `tb_platform_permit` set permitresource='销售服务'  where uuid='2015050510000011';

UPDATE `tb_platform_permit` set permitname='经销商管理'  where uuid='2015050510000012';


INSERT INTO `tb_platform_permit` VALUES ('2017120510000001', 'MENU', '品质服务', '品质服务', null, '1200', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', 'icon-wrench');
INSERT INTO `tb_platform_permit` VALUES ('2017120510000002', 'MENU', '培训管理', 'admin/wefamily/trainManage', '2017120510000001', '1201', 'APP', now(), 'sys', now(), 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2017120510000003', 'MENU', '保养管理', 'admin/wefamily/maintenanceManage', '2017120510000001', '1202', 'APP', now(), 'sys', now(), 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2017120510000004', 'MENU', '报修管理', 'admin/wefamily/repairManage', '2017120510000001', '1203', 'APP', now(), 'sys', now(), 'sys', '1', 'N', '');


INSERT INTO `tb_platform_role_permit` VALUES ('201712050000001', '2015062610000001', '2017120510000001', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('201712050000002', '2015062610000001', '2017120510000002', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('201712050000003', '2015062610000001', '2017120510000003', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('201712050000004', '2015062610000001', '2017120510000004', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');

-- 机器管理
INSERT INTO `tb_platform_permit` VALUES ('2017120610000001', 'MENU', '机器管理', 'admin/wefamily/machineManage', '2015050510000011', '1103', 'APP', now(), 'sys', now(), 'sys', '1', 'N', '');
INSERT INTO `tb_platform_role_permit` VALUES ('201712060000001', '2015062610000001', '2017120610000001', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');