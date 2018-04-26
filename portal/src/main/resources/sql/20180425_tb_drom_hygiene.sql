-- 卫生
CREATE TABLE `tb_dorm_hygiene` (
  `uuid` varchar(32) NOT NULL,
  `term` int(2) NOT NULL,
  `week` int(2) NOT NULL,
  `dormitoryid` varchar(32) not null,
  `layer` varchar(32) not null,
  `roomno` varchar(32) not null,
  `ground` int(2) DEFAULT null,
  `desk` int(2) DEFAULT null,
  `bed` int(2) DEFAULT null,
  `balcony` int(2) DEFAULT null,
  `toilet` int(2) DEFAULT null,
  `total` int(3) DEFAULT null,
  `remarks` varchar(256) DEFAULT null,
  `status` varchar(16) default null,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;