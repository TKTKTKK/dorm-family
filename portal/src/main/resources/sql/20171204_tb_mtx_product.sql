
-- 创建商品表
CREATE TABLE `tb_mtx_product` (
  `uuid` varchar(32) NOT NULL,
  `model` varchar(32) NOT NULL,
  `name` varchar(256) NOT NULL,
  `img` varchar(256) DEFAULT NULL,
  `status` varchar(32) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
);

-- 商品管理
INSERT INTO `tb_platform_permit` VALUES ('2017120410000002', 'MENU', '商品管理', 'admin/wefamily/MtxProduct', '2015050510000011', '1102', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');