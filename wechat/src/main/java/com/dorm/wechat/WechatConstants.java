package com.dorm.wechat;

/**
 * Created by wensheng on 14-12-1.
 */
public class WechatConstants {
    public static String DEFAULT_REPLY_MSG = "success";

    /**
     * Common Message Properties
     */
    public static String MSG_PROP_FROMUSERNAME = "FromUserName";
    public static String MSG_PROP_TOUSERNAME = "ToUserName";
    public static String MSG_PROP_EVENT = "Event";
    public static String MSG_PROP_EVENTKEY = "EventKey";
    public static String MSG_PROP_TICKET = "Ticket";
    public static String MSG_PROP_LATITUDE = "Latitude";
    public static String MSG_PROP_LONGITUDE = "Longitude";
    public static String MSG_PROP_PRECISION = "Precision";
    public static String MSG_PROP_CARDID = "CardId";
    public static String MSG_PROP_ISGIVEBYFRIEND = "IsGiveByFriend";
    public static String MSG_PROP_USERCARDCODE = "UserCardCode";
    public static String MSG_PROP_OUTERID = "OuterId";

    /**
     * placeholder of API URL
     */
    public static String PARAM_PLACEHOLDER_APPID = "APPID";
    public static String PARAM_PLACEHOLDER_APPSECRET = "APPSECRET";
    public static String PARAM_PLACEHOLDER_CODE = "CODE";
    public static String PARAM_PLACEHOLDER_ACCESS_TOKEN = "ACCESS_TOKEN";
    public static String PARAM_PLACEHOLDER_REDIRECT_URI = "REDIRECT_URI";
    public static String PARAM_PLACEHOLDER_SCOPE = "SCOPE";
    public static String PARAM_PLACEHOLDER_STATE = "STATE";
    public static String PARAM_PLACEHOLDER_OPENID = "OPENID";
    public static String PARAM_PLACEHOLDER_NEXT_OPENID = "NEXT_OPENID";
    public static String PARAM_PLACEHOLDER_TYPE = "TYPE";
    public static String PARAM_PLACEHOLDER_MEDIA_ID = "MEDIA_ID";

    /**
     * API PARAMETER
     */
    public static String OAUTH2_SCOPE_BASE = "snsapi_base";
    public static String OAUTH2_SCOPE_USERINFO = "snsapi_userinfo";

    /**
     * Wechat related cache name
     */
    public static String ORIGID_BIND_MAP_CACHE = "origidBindMapCache";
    public static String BIND_DETAILS_CACHE = "bindDetailsCache";
    public static String ACCESS_TOKEN_CACHE = "accessTokenCache";
    public static String JSAPI_TICKET_CACHE = "jsApiTicketCache";
    public static String API_TICKET_CACHE = "apiTicketCache";



    /**
     * keyword of default auto response
     */
    public static String RESP_DEFAULT_KEYWORD = "DEFAULT_RESP";

    /**
     * API URL with placeholder
     */

    //微信OAuth2
    public final static String WECHAT_OAUTH2_URL = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=REDIRECT_URI&response_type=code&scope=SCOPE&state=STATE#wechat_redirect";
    //通过code换取网页授权access_token
    public final static String WECHAT_OAUTH2_ACCESSTOKEN_URL = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=APPSECRET&code=CODE&grant_type=authorization_code";
    //获取用户基本信息
    public final static String WECHAT_GET_USER_INFO_URL = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN";
    //网页授权获取用户基本信息
    public final static String WECHAT_OAUTH2_GET_USER_INFO_URL = "https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN";
    //获取关注者列表
    public final static String WECHAT_GET_USER_LIST_URL = "https://api.weixin.qq.com/cgi-bin/user/get?access_token=ACCESS_TOKEN&next_openid=NEXT_OPENID";
    //查询所有分组
    public final static String WECHAT_GET_GROUPS_URL = "https://api.weixin.qq.com/cgi-bin/groups/get?access_token=ACCESS_TOKEN";
    //查询用户所在分组
    public final static String WECHAT_GET_USER_GROUP_URL = "https://api.weixin.qq.com/cgi-bin/groups/getid?access_token=ACCESS_TOKEN";
    //创建分组
    public final static String WECHAT_CREATE_GROUP_URL = "https://api.weixin.qq.com/cgi-bin/groups/create?access_token=ACCESS_TOKEN";
    //修改分组名
    public final static String WECHAT_UPDATE_GROUP_URL = "https://api.weixin.qq.com/cgi-bin/groups/update?access_token=ACCESS_TOKEN";
    //删除分组
    public final static String WECHAT_DELETE_GROUP_URL = "https://api.weixin.qq.com/cgi-bin/groups/delete?access_token=ACCESS_TOKEN";
    //移动用户分组
    public final static String WECHAT_UPDATE_USER_GROUP_URL = "https://api.weixin.qq.com/cgi-bin/groups/members/update?access_token=ACCESS_TOKEN";
    //上传媒体文件
    public final static String WECHAT_UPLOAD_MEDIA_URL = "http://file.api.weixin.qq.com/cgi-bin/media/upload?access_token=ACCESS_TOKEN&type=TYPE";
    //下载媒体文件
    public final static String WECHAT_DOWNLOAD_MEDIA_URL = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=ACCESS_TOKEN&media_id=MEDIA_ID";
    //创建卡券
    public final static String WECHAT_CREATE_CARD_URL = "https://api.weixin.qq.com/card/create?access_token=ACCESS_TOKEN";
    //上传LOGO 接口
    public final static String WECHAT_UPLOAD_IMG_URL = "https://api.weixin.qq.com/cgi-bin/media/uploadimg?access_token=ACCESS_TOKEN";
    //设置测试用户白名单
    public static String WECHAT_CARD_TEST_WHITE_LIST_URL = "https://api.weixin.qq.com/card/testwhitelist/set?access_token=ACCESS_TOKEN";
    //获取微信卡券颜色列表
    public static String WECHAT_CARD_GET_COLORS_URL = "https://api.weixin.qq.com/card/getcolors?access_token=ACCESS_TOKEN";
    //获取卡券二维码Ticket
    public static String WECHAT_CARD_GET_TICKET_URL = "https://api.weixin.qq.com/card/qrcode/create?access_token=ACCESS_TOKEN";
    //核销code
    public static String WECHAT_CARD_CODE_CONSUME_URL = "https://api.weixin.qq.com/card/code/consume?access_token=ACCESS_TOKEN";
    //code解码
    public static String WECHAT_CARD_CODE_DECRYPT_URL = "https://api.weixin.qq.com/card/code/decrypt?access_token=ACCESS_TOKEN";
    //激活会员卡
    public static String WECHAT_CARD_ACTIVATE_MEMBER_CARD_URL = "https://api.weixin.qq.com/card/membercard/activate?access_token=ACCESS_TOKEN";
    //会员卡交易
    public static String WECHAT_CARD_MEMBER_CARD_UPDATE_URL = "https://api.weixin.qq.com/card/membercard/updateuser?access_token=ACCESS_TOKEN";
    //请求获得jsapi_ticket
    public static String WECHAT_JSAPI_GET_TICKET_URL = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";
    //发送模板消息
    public static String WECHAT_TM_SEND_URL = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN";


    /**
     * 卡券类型
     */
    //通用券
    public static String CARD_TYPE_GENERAL_COUPON = "GENERAL_COUPON";
    //团购券
    public static String CARD_TYPE_GROUPON = "GROUPON";
    //折扣券
    public static String CARD_TYPE_DISCOUNT = "DISCOUNT";
    //礼品券
    public static String CARD_TYPE_GIFT = "GIFT";
    //代金券
    public static String CARD_TYPE_CASH = "CASH";
    //会员卡
    public static String CARD_TYPE_MEMBER_CARD = "MEMBER_CARD";
    //景点门票
    public static String CARD_TYPE_SCENIC_TICKET = "SCENIC_TICKET";
    //电影票
    public static String CARD_TYPE_MOVIE_TICKET = "MOVIE_TICKET";
    //飞机票
    public static String CARD_TYPE_BOARDING_PASS = "BOARDING_PASS";
    //红包
    public static String CARD_TYPE_LUCKY_MONEY = "LUCKY_MONEY";
    //会议门票
    public static String CARD_TYPE_MEETING_TICKET = "meeting_ticket";
}
