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
  `staffqrcode` varchar(256) DEFAULT NULL,
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

-- 微信公众平台菜单详情表
-- ----------------------------
-- Table structure for tb_wp_menu
-- ----------------------------
CREATE TABLE `tb_wp_menu` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `menusname` varchar(15) NOT NULL,
  `menustype` char(1) NOT NULL,
  `parentid` varchar(32) DEFAULT NULL,
  `name` varchar(10) NOT NULL,
  `type` varchar(50) NOT NULL,
  `link` varchar(2000) DEFAULT NULL,
  `orderno` int(11) NOT NULL,
  `groupid` varchar(10) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_wp_user
-- ----------------------------
CREATE TABLE `tb_wp_user` (
  `uuid` varchar(32) NOT NULL,
  `bindid` varchar(32) NOT NULL,
  `openid` varchar(32) NOT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `headimgurl` varchar(255) DEFAULT NULL,
  `name` varchar(90) DEFAULT NULL,
  `contactno` varchar(20) DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `ifauth` char(1) DEFAULT NULL,
  `ifsubscribe` char(1) DEFAULT NULL,
  `createon` varchar(23) NOT NULL,
  `createby` varchar(32) NOT NULL,
  `modifyon` varchar(23) NOT NULL,
  `modifyby` varchar(32) NOT NULL,
  `versionno` int(11) NOT NULL,
  `delind` char(1) NOT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `ind_wp_user_openid` (`openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `tb_platform_permit` VALUES ('2015050510000001', 'MENU', '公众号', '公众号', null, '1000', 'APP', '2015-05-20 19:31:10', 'sys', '2016-01-21 11:33:31 051', 'e34638d3152c49ecac24467591cc4365', '2', 'N', 'icon-home');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000002', 'MENU', '公众号管理', 'admin/account/search', '2015050510000001', '1010', 'APP', '2015-05-20 19:37:23', 'sys', '2015-05-20 19:37:23', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000003', 'MENU', '授权设置', 'admin/account/authorizationSetting', '2015050510000001', '1020', 'APP', '2015-05-20 19:37:23', 'sys', '2015-05-20 19:37:23', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015112510000001', 'MENU', '模板消息', 'admin/account/templateMessageSetting', '2015050510000001', '1221', 'APP', '2015-12-05 06:35:35', 'sys', '2015-12-05 06:35:35', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015122810000001', 'MENU', '图文消息', 'admin/account/articleMessage', '2015050510000001', '1080', 'APP', '2015-12-29 17:01:01', 'sys', '2015-12-29 17:01:01', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2016011210000001', 'MENU', '菜单配置', 'admin/account/menusSetting', '2015050510000001', '1234', 'APP', '2016-01-29 18:58:00', 'sys', '2016-01-29 18:58:00', 'sys', '1', 'N', '');

INSERT INTO `tb_platform_permit` VALUES ('2015050510000004', 'MENU', '自动回复', '自动回复', null, '1030', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', 'fa fa-reply-all');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000005', 'MENU', '关注时自动回复', 'admin/autoRep/subscribeRepTxt', '2015050510000004', '1040', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000006', 'MENU', '关键词自动回复', 'admin/autoRep/keywordAutoRep', '2015050510000004', '1050', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000007', 'MENU', '图文集', 'admin/autoRep/showArticleSet', '2015050510000004', '1060', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000008', 'MENU', '图片库', 'admin/autoRep/showPictureLib', '2015050510000004', '1070', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');

INSERT INTO `tb_platform_permit` VALUES ('2015050510000009', 'MENU', '用户', '用户', null, '1080', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', 'icon-users');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000010', 'MENU', '用户管理', 'admin/usermanage/roleDistribute', '2015050510000009', '1090', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2015110210000001', 'MENU', '权限管理', 'admin/usermanage/rolePermitManage', '2015050510000009', '2100', 'APP', '2015-11-05 06:49:35', 'sys', '2015-11-05 06:49:35', 'sys', '1', 'N', '');

INSERT INTO `tb_platform_permit` VALUES ('2017121210000001', 'MENU', '产品中心', '产品中心', null, '1081', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', 'icon-users');
INSERT INTO `tb_platform_permit` VALUES ('2017120410000002', 'MENU', '产品管理', 'admin/wefamily/MtxProduct', '2017121210000001', '1102', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');

INSERT INTO `tb_platform_permit` VALUES ('2017121210000002', 'MENU', '会员管理', '会员管理', null, '1082', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', 'icon-users');
INSERT INTO `tb_platform_permit` VALUES ('2017120810000001', 'MENU', '会员管理', 'admin/wefamily/mtxMemberManage', '2017121210000002', '1106', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2017120910000001', 'MENU', '积分管理', 'admin/wefamily/mtxPointManage', '2017121210000002', '1107', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2017120910000002', 'MENU', '商品兑换管理', 'admin/wefamily/mtxGoodManage', '2017121210000002', '1108', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');

INSERT INTO `tb_platform_permit` VALUES ('2015050510000011', 'MENU', '销售服务', '销售服务', null, '1090', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', 'icon-users');
INSERT INTO `tb_platform_permit` VALUES ('2015050510000012', 'MENU', '经销商管理', 'admin/wefamily/merchant', '2015050510000011', '1100', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2017120410000001', 'MENU', '订单管理', 'admin/wefamily/orderManage', '2015050510000011', '1101', 'APP', now(), 'sys', now(), 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2017120610000001', 'MENU', '机器管理', 'admin/wefamily/machineManage', '2015050510000011', '1103', 'APP', now(), 'sys', now(), 'sys', '1', 'N', '');

INSERT INTO `tb_platform_permit` VALUES ('2017120510000001', 'MENU', '品质服务', '品质服务', null, '1200', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', 'icon-wrench');
INSERT INTO `tb_platform_permit` VALUES ('2017120510000002', 'MENU', '培训管理', 'admin/wefamily/trainManage', '2017120510000001', '1201', 'APP', now(), 'sys', now(), 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2017120510000003', 'MENU', '保养管理', 'admin/wefamily/maintenanceManage', '2017120510000001', '1202', 'APP', now(), 'sys', now(), 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2017120510000004', 'MENU', '报修管理', 'admin/wefamily/repairManage', '2017120510000001', '1203', 'APP', now(), 'sys', now(), 'sys', '1', 'N', '');

INSERT INTO `tb_platform_permit` VALUES ('2017121210000003', 'MENU', '咨询留言', '咨询留言', null, '1210', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', 'icon-users');
INSERT INTO `tb_platform_permit` VALUES ('2017120510000005', 'MENU', '咨询管理', 'admin/wefamily/mtxReserveManage', '2017121210000003', '1104', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');
INSERT INTO `tb_platform_permit` VALUES ('2017120610000002', 'MENU', '留言管理', 'admin/wefamily/mtxConsultManage', '2017121210000003', '1105', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', '');

INSERT INTO `tb_platform_permit` VALUES ('2017121210000004', 'MENU', '活动中心', '活动中心', null, '1220', 'APP', '2015-05-20 19:31:10', 'sys', '2015-05-20 19:31:10', 'sys', '1', 'N', 'icon-users');


-- INSERT INTO `tb_platform_role` VALUES ('2017120100000001', null, 'SYSTEM_ADM', '系统管理员', '2017-12-01 10:08:10', 'sys', '2017-12-01 10:08:10', 'sys', '1', 'N');
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
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000014', '2015062610000001', '2015112510000001', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000015', '2015062610000001', '2015122810000001', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');
INSERT INTO `tb_platform_role_permit` VALUES ('2017120100000016', '2015062610000001', '2016011210000001', '2015-06-26 14:16:24', 'sys', '2015-06-26 14:16:24', 'sys', '1', 'N');