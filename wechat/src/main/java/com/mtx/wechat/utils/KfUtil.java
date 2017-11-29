package com.mtx.wechat.utils;

import com.mtx.common.base.CommonConstants;
import com.mtx.wechat.WechatConstants;

import java.util.Map;

public class KfUtil {

    //添加客服账号
    public static String WECHAT_KF_ACCOUNT_ADD_URL = "https://api.weixin.qq.com/customservice/kfaccount/add?access_token=ACCESS_TOKEN";
    public static String WECHAT_KF_ACCOUNT_UPDATE_URL = "https://api.weixin.qq.com/customservice/kfaccount/update?access_token=ACCESS_TOKEN";
    public static String WECHAT_KF_GET_WAITCASE_URL = " https://api.weixin.qq.com/customservice/kfsession/getwaitcase?access_token=ACCESS_TOKEN";


    public static Map addKfAccount(String accessToken,Map account){
        String jsonStr = WechatUtil.toJson(account);
        String requestUrl = WECHAT_KF_ACCOUNT_ADD_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        return WechatUtil.httpsRequest(requestUrl, CommonConstants.REQUEST_METHOD_POST,jsonStr,Map.class);
    }

    public static String getWaitCase(String accessToken){
        String requestUrl = WECHAT_KF_GET_WAITCASE_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        Map map =  WechatUtil.httpsRequest(requestUrl, CommonConstants.REQUEST_METHOD_GET,null,Map.class);
        return String.valueOf(((Double)map.get("count")).intValue()) ;
    }
}
