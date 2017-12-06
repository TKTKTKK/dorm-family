-- ----------------------------
-- Table structure for tb_common_code
-- ----------------------------
CREATE TABLE `tb_common_code` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) DEFAULT NULL,
  `refid` varchar(32) DEFAULT NULL,
  `codetype` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  `codevalue` varchar(255) NOT NULL,
  `extvalue` varchar(20) DEFAULT NULL,
  `childcodetype` varchar(50) DEFAULT NULL,
  `orderno` int(6) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_common_config
-- ----------------------------
CREATE TABLE `tb_common_config` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) DEFAULT NULL,
  `refid` varchar(32) DEFAULT NULL,
  `configname` varchar(32) NOT NULL,
  `configvalue` varchar(256) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_common_sequence
-- ----------------------------
CREATE TABLE `tb_common_sequence` (
  `name` varchar(50) NOT NULL,
  `current_value` int(11) NOT NULL,
  `increment` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_wp_attachment
-- ----------------------------
CREATE TABLE `tb_common_attachment` (
  `uuid` varchar(32) NOT NULL,
  `refid` varchar(32) NOT NULL,
  `name` varchar(300) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`),
  KEY `ind_common_att_refid` (`refid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_platform_permit
-- ----------------------------
CREATE TABLE `tb_platform_permit` (
  `uuid` varchar(32) NOT NULL,
  `permittype` varchar(20) NOT NULL,
  `permitname` varchar(60) NOT NULL,
  `permitresource` varchar(256) NOT NULL,
  `parentpermitid` varchar(32) DEFAULT NULL,
  `permitorder` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(100) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(100) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  `menuicon` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_platform_role
-- ----------------------------
CREATE TABLE `tb_platform_role` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) DEFAULT NULL,
  `rolekey` varchar(32) NOT NULL,
  `rolename` varchar(45) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(100) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(100) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_platform_role_permit
-- ----------------------------
CREATE TABLE `tb_platform_role_permit` (
  `uuid` varchar(32) NOT NULL,
  `roleid` varchar(32) NOT NULL,
  `permitid` varchar(32) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(100) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(100) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_platform_user
-- ----------------------------
CREATE TABLE `tb_platform_user` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) DEFAULT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(256) NOT NULL,
  `name` varchar(90) DEFAULT NULL,
  `cellphone` varchar(20) DEFAULT NULL,
  `email` varchar(320) DEFAULT NULL,
  `openid` varchar(32) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_platform_user_role
-- ----------------------------
CREATE TABLE `tb_platform_user_role` (
  `uuid` varchar(32) NOT NULL,
  `userid` varchar(32) DEFAULT NULL,
  `roleid` varchar(32) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tb_common_bind_role` (
  `uuid`        varchar(32) PRIMARY KEY,
  `bindid`      varchar(32) NOT NULL,
  `roleid`  varchar(32) NOT NULL,
  `createon`    varchar(23) NOT NULL,
  `createby`    varchar(32) NOT NULL,
  `modifyon`    varchar(23) NOT NULL,
  `modifyby`    varchar(32) NOT NULL,
  `versionno`   int(11) NOT NULL,
  `delind`      char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_image
-- ----------------------------
CREATE TABLE `tb_image` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `imgname` varchar(300) NOT NULL,
  `mediaid` varchar(100) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_resp_article
-- ----------------------------
CREATE TABLE `tb_resp_article` (
  `uuid` varchar(32) NOT NULL,
  `newsid` varchar(32) NOT NULL,
  `title` varchar(192) DEFAULT NULL,
  `decription` varchar(300) DEFAULT NULL,
  `picurl` varchar(255) DEFAULT NULL,
  `url` varchar(600) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  `detailcontent` text,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_resp_article_history
-- ----------------------------
CREATE TABLE `tb_resp_article_history` (
  `uuid` varchar(32) NOT NULL,
  `mediaid` varchar(60) NOT NULL,
  `openid` varchar(32) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_resp_news
-- ----------------------------
CREATE TABLE `tb_resp_news` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_resp_setting
-- ----------------------------
CREATE TABLE `tb_resp_setting` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `newsid` varchar(32) DEFAULT NULL,
  `reqtype` varchar(20) NOT NULL,
  `keywords` varchar(90) DEFAULT NULL,
  `resptype` varchar(255) NOT NULL,
  `content` varchar(1800) DEFAULT NULL,
  `title` varchar(60) DEFAULT NULL,
  `decription` varchar(300) DEFAULT NULL,
  `musicurl` varchar(255) DEFAULT NULL,
  `hqmusicurl` varchar(255) DEFAULT NULL,
  `thumbmediaid` varchar(32) DEFAULT NULL,
  `mediaid` varchar(100) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_wechat_binding
-- ----------------------------
CREATE TABLE `tb_wechat_binding` (
  `uuid` varchar(32) NOT NULL,
  `token` varchar(32) DEFAULT NULL,
  `wechatname` varchar(48) DEFAULT NULL,
  `wechatorigid` varchar(32) DEFAULT NULL,
  `wechatid` varchar(32) DEFAULT NULL,
  `appid` varchar(32) DEFAULT NULL,
  `appsecret` varchar(32) DEFAULT NULL,
  `logo_url` varchar(256) DEFAULT NULL,
  `brand_name` varchar(60) DEFAULT NULL,
  `trusteeship` varchar(10) DEFAULT NULL,
  `merchantid` varchar(64) DEFAULT NULL,
  `wechatpayid` varchar(15) DEFAULT NULL,
  `wechatpaykey` varchar(64) DEFAULT NULL,
  `phpayapiid` varchar(64) DEFAULT NULL,
  `phpayapikey` varchar(64) DEFAULT NULL,
  `authorizerrefreshtoken` varchar(128) DEFAULT NULL,
  `authorized` char(1) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`),
  KEY `ind_binding_origid` (`wechatorigid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_wechat_tm
-- ----------------------------
CREATE TABLE `tb_wechat_tm` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `tmid` varchar(60) NOT NULL,
  `tmtype` varchar(50) NOT NULL,
  `tmname` varchar(60) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_wechat_tm_master
-- ----------------------------
CREATE TABLE `tb_wechat_tm_master` (
  `uuid` varchar(32) NOT NULL,
  `tmidshort` varchar(32) NOT NULL,
  `tmname` varchar(60) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_wechat_userinfo
-- ----------------------------
CREATE TABLE `tb_wechat_userinfo` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `openid` varchar(32) NOT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `headimgurl` varchar(300) DEFAULT NULL,
  `name` varchar(90) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `companyid` varchar(32) DEFAULT NULL,
  `contactno` varchar(20) DEFAULT NULL,
  `remarks` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `ind_userinfo_openid` (`openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_wp_merchant
-- ----------------------------
CREATE TABLE `tb_mtx_merchant` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `name` varchar(48) NOT NULL,
  `contactno` varchar(100) DEFAULT NULL,
  `province` varchar(60) DEFAULT NULL,
  `city` varchar(60) DEFAULT NULL,
  `district` varchar(30) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tb_mtx_user_merchant` (
  `uuid` varchar(32) NOT NULL,
  `userid` varchar(32) NOT NULL,
  `merchantid` varchar(32) NOT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tb_platform_permit` VALUES ('2015050510000001', 'MENU', '公众号', '公众号', null, '1000', 'APP', '2015-05-20 19:31:10', 'sys', '2016-01-21 11:33:31 051', 'e34638d3152c49ecac24467591cc4365', '2', 'N', 'icon-home');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000002', 'MENU', '公众号管理', 'admin/account/search', '2015050510000001', '1010', 'APP', '2015-05-20 19:37:23', 'sys', '2015-05-20 19:37:23', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000003', 'MENU', '授权设置', 'admin/account/authorizationSetting', '2015050510000001', '1020', 'APP', '2015-05-20 19:37:23', 'sys', '2015-05-20 19:37:23', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000004', 'MENU', '自动回复', '自动回复', null, '1030', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', 'fa fa-reply-all');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000005', 'MENU', '关注时自动回复', 'admin/autoRep/subscribeRepTxt', '2015050510000004', '1040', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000006', 'MENU', '关键词自动回复', 'admin/autoRep/keywordAutoRep', '2015050510000004', '1050', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000007', 'MENU', '图文集', 'admin/autoRep/showArticleSet', '2015050510000004', '1060', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000008', 'MENU', '图片库', 'admin/autoRep/showPictureLib', '2015050510000004', '1070', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000009', 'MENU', '用户', '用户', null, '1080', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', 'icon-users');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000010', 'MENU', '用户管理', 'admin/usermanage/roleDistribute', '2015050510000009', '1090', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015110210000001', 'MENU', '权限管理', 'admin/usermanage/rolePermitManage', '2015050510000009', '2100', 'APP', '2015-11-05 06:49:35', 'sys', '2015-11-05 06:49:35', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000011', 'MENU', '满田星', '满田星', null, '1090', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', 'icon-users');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000012', 'MENU', '经销商', 'admin/wefamily/merchant', '2015050510000011', '1100', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');

INSERT INTO `tb_platform_role` VALUES ('2017120100000001', null, 'SYSTEM_ADM', '系统管理员', '2017-12-01 10:08:10', 'sys', '2017-12-01 10:08:10', 'sys', '1', 'N');
INSERT INTO `tb_platform_role` VALUES ('2015062610000001', null, 'WP_SUPER', '超级管理员', '2015-06-26 14:08:10', 'sys', '2015-06-26 14:08:10', 'sys', '1', 'N');
INSERT INTO `tb_platform_role` VALUES ('2015050510000001', null, 'WP_ADM', '管理员', '2015-05-20 19:11:09', 'sys', '2016-01-21 11:33:04 505', 'sys', '1', 'N');

INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000001', '2015062610000001', '2015050510000001', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000002', '2015062610000001', '2015050510000002', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000003', '2015062610000001', '2015050510000003', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000004', '2015062610000001', '2015050510000004', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000005', '2015062610000001', '2015050510000005', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000006', '2015062610000001', '2015050510000006', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000007', '2015062610000001', '2015050510000007', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000008', '2015062610000001', '2015050510000008', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000009', '2015062610000001', '2015050510000009', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000010', '2015062610000001', '2015050510000010', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000011', '2015062610000001', '2015050510000011', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000012', '2015062610000001', '2015050510000012', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000013', '2015062610000001', '2015110210000001', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');