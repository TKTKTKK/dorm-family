package com.dorm.wechat.utils;

import com.dorm.common.base.CommonConstants;
import com.dorm.common.utils.CacheUtils;
import com.dorm.wechat.WechatConstants;
import com.dorm.wechat.entity.result.jssdk.JsApiTicket;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by wensheng on 15-1-25.
 */
public class JsSdkUtil {
    private static Logger log = LoggerFactory.getLogger(JsSdkUtil.class);

    public static String WECHAT_API_TICKET_URL = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=wx_card";

    /**
     *
     * 获取JS API Ticket
     */
    public static JsApiTicket getTicket(String accessToken,String appid){
        JsApiTicket ticket = (JsApiTicket) CacheUtils.get(WechatConstants.JSAPI_TICKET_CACHE, appid);
        if(ticket != null && !ticket.tokenExpired()){
            return ticket;
        }else{
            synchronized (JsSdkUtil.class){
                ticket = (JsApiTicket) CacheUtils.get(WechatConstants.JSAPI_TICKET_CACHE, appid);
                if(ticket == null || ticket.tokenExpired()){
                    String requestUrl = WechatConstants.WECHAT_JSAPI_GET_TICKET_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
                    ticket = WechatUtil.httpsRequest(requestUrl, CommonConstants.REQUEST_METHOD_GET,null,JsApiTicket.class);
                    if(ticket != null){
                        if(ticket.getErrcode() == 0){
                            ticket.setCreatedTime(System.currentTimeMillis());
                            CacheUtils.put(WechatConstants.JSAPI_TICKET_CACHE,appid,ticket);
                        }else{
                            log.error("获取ticket失败 errcode:{} errmsg:{}", ticket.getErrcode(), ticket.getErrmsg());
                        }
                    }else{
                        log.error("获取ticket失败");
                    }
                }
            }

        }
        return ticket;
    }


    /**
     *
     * 获取卡券api_ticket
     */
    public static JsApiTicket getApiTicket(String accessToken,String appid){
        JsApiTicket ticket = (JsApiTicket) CacheUtils.get(WechatConstants.API_TICKET_CACHE, appid);
        if(ticket != null && !ticket.tokenExpired()){
            return ticket;
        }else{
            synchronized (JsSdkUtil.class){
                ticket = (JsApiTicket) CacheUtils.get(WechatConstants.API_TICKET_CACHE, appid);
                if(ticket == null || ticket.tokenExpired()){
                    String requestUrl = WECHAT_API_TICKET_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
                    ticket = WechatUtil.httpsRequest(requestUrl, CommonConstants.REQUEST_METHOD_GET,null,JsApiTicket.class);
                    if(ticket != null){
                        if(ticket.getErrcode() == 0){
                            ticket.setCreatedTime(System.currentTimeMillis());
                            CacheUtils.put(WechatConstants.API_TICKET_CACHE,appid,ticket);
                        }else{
                            log.error("获取api ticket失败 errcode:{} errmsg:{}", ticket.getErrcode(), ticket.getErrmsg());
                        }
                    }else{
                        log.error("获取api ticket失败");
                    }
                }
            }

        }
        return ticket;
    }

    /**
     *
     * 获取JS API Ticket,仅供测试
     *
     */
    public static JsApiTicket getTestTicket(String accessToken) {
        String requestUrl = WechatConstants.WECHAT_JSAPI_GET_TICKET_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        JsApiTicket ticket = WechatUtil.httpsRequest(requestUrl, CommonConstants.REQUEST_METHOD_GET, null, JsApiTicket.class);
        if (ticket != null) {
            if (ticket.getErrcode() == 0) {
                ticket.setCreatedTime(System.currentTimeMillis());
            } else {
                log.error("获取ticket失败 errcode:{} errmsg:{}", ticket.getErrcode(), ticket.getErrmsg());
            }
        } else {
            log.error("获取ticket失败");
        }
        return ticket;
    }


    /**
     *
     * 获取卡券api_ticket,仅供测试
     *
     */
    public static JsApiTicket getTestApiTicket(String accessToken) {
        String requestUrl = WECHAT_API_TICKET_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        JsApiTicket ticket = WechatUtil.httpsRequest(requestUrl, CommonConstants.REQUEST_METHOD_GET, null, JsApiTicket.class);
        if (ticket != null) {
            if (ticket.getErrcode() == 0) {
                ticket.setCreatedTime(System.currentTimeMillis());
            } else {
                log.error("获取ticket失败 errcode:{} errmsg:{}", ticket.getErrcode(), ticket.getErrmsg());
            }
        } else {
            log.error("获取ticket失败");
        }
        return ticket;
    }

}


