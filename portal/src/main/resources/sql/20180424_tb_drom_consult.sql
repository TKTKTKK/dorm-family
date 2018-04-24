-- 咨询
CREATE TABLE `tb_dorm_consult` (
  `uuid` varchar(32) NOT NULL,
  `stuid` varchar(32) default null,
  `detail` varchar(256) DEFAULT null,
  `reply` varchar(256) DEFAULT null,
  `status` varchar(16) default null,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;