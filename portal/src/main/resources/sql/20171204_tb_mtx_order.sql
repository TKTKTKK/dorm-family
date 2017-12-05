-- Table structure for tb_mtx_order
-- ----------------------------
CREATE TABLE `tb_mtx_order` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `snno` varchar(32) NOT NULL,
  `machinemodel` varchar(32) NOT NULL,
  `machinename` varchar(32) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;