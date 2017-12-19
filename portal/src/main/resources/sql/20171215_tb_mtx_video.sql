
-- 保养小视频表
CREATE TABLE `tb_mtx_video` (
  `uuid` varchar(32) NOT NULL,
  `model` varchar(48) DEFAULT NULL,
  `videourl` varchar(256) DEFAULT NULL,
  `status` varchar(15) DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `tb_platform_permit` VALUES ('2017121410000001', 'MENU', '视频管理', 'admin/wefamily/mtxVideoManage', '2017121210000001', '1110', 'APP', now(), 'sys', now(), 'sys', '1', 'N', '');

-- 视频类型
INSERT INTO tb_common_code VALUES ('2017121400000003', null, null, 'VIDEO_TYPE', 'M_VIDEO', '保养小视频', null,'', '3', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017121400000004', null, null, 'VIDEO_TYPE', 'R_VIDEO', '维修小视屏', null,'', '4', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');



INSERT INTO `tb_platform_permit` VALUES ('2017121510000001', 'MENU', '配件管理', 'admin/wefamily/mtxPartsCenterManage', '2017121210000001', '1109', 'APP', now(), 'sys', now(), 'sys', '1', 'N', '');



