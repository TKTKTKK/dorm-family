package com.mtx.wechat.utils;

import com.mtx.common.base.CommonConstants;
import com.mtx.common.utils.ApplicationContextUtil;
import com.mtx.common.utils.ConfigHolder;
import com.mtx.common.utils.StringUtils;
import com.mtx.wechat.entity.*;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.param.tm.TemplateMessage;
import com.mtx.wechat.entity.result.jssdk.JsApiTicket;
import com.mtx.wechat.entity.result.material.MaterialNewsResult;
import com.mtx.wechat.entity.result.qrcode.QrcodeResult;
import com.mtx.wechat.menu.Menu;
import com.mtx.wechat.service.WechatBindingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wensheng on 1/19/2015.
 */
public class WechatBindingUtil {

    private static Logger logger = LoggerFactory.getLogger(WechatBindingUtil.class);

    private static WechatBindingService wechatBindingService = ApplicationContextUtil.getBean(WechatBindingService.class);

    public static WechatBinding getWechatBindingByUser(){
        return wechatBindingService.getWechatBindingByUser();
    }

    /**
     * 根据微信原始ID获取bindid
     * @param wechatOrigId
     * @return
     */
    public static String getBindIdByWechatOrigId(String wechatOrigId){
        return wechatBindingService.getBindIdByWechatOrigId(wechatOrigId);
    }

    /**
     * 根据微信原始ID获取WechatBinding
     * @param wechatOrigId
     * @return
     */
    public static WechatBinding getWechatBindingByWechatOrigId(String wechatOrigId){
        String bindId = getBindIdByWechatOrigId(wechatOrigId);
        return wechatBindingService.getWechatBindingByBindId(bindId);
    }

    /**
     *
     * @param bindId
     * @return
     */
    public static WechatBinding getWechatBindingByBindId(String bindId){
        return wechatBindingService.getWechatBindingByBindId(bindId);
    }

    /**
     * 管理员登陆后使用
     * @return
     */
    public static String getAccessToken(){
        WechatBinding wechatBinding = getWechatBindingByUser();
        return WechatUtil.getAccessToken(wechatBinding.getAppid(), wechatBinding.getAppsecret());
    }

    /**
     * 微信用户使用
     * @param bindId
     * @return
     */
    public static String getAccessTokenByBindId(String bindId){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByBindId(bindId);
        return WechatUtil.getAccessToken(wechatBinding.getAppid(), wechatBinding.getAppsecret());
    }

    /**
     * 微信用户使用
     * @param bindId
     * @param openId
     * @return
     */
    public static WechatUser getWechatUser(String bindId, String openId){
        String accessToken = getAccessTokenByBindId(bindId);
        return AdvancedUtil.getWechatUserInfo(accessToken, openId);
    }

    /**
     * 管理员使用
     * @param openId
     * @return
     */
    public static WechatUser getWechatUser(String openId){
        if(StringUtils.isNotBlank(openId)){
            String accessToken = getAccessToken();
            return AdvancedUtil.getWechatUserInfo(accessToken, openId);
        }else{
            return new WechatUser();
        }

    }

    /**
     * 管理员使用
     * @param openId
     * @return
     */
    public static String getWechatNickname(String openId){
        WechatUser wechatUser = getWechatUser(openId);
        if (wechatUser != null){
            return wechatUser.getNickname();
        }
        return null;
    }

    /**
     * @param bindId
     * @return
     */
    public static String getAppIdByBindId(String bindId){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByBindId(bindId);
        return wechatBinding.getAppid();
    }

    /**
     * 获取JSAPI TICKET使用
     * @param bindId
     * @return
     */
    public static String getJsApiTicket(String bindId){
        String accessToken = getAccessTokenByBindId(bindId);
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByBindId(bindId);
        JsApiTicket jsApiTicket = JsSdkUtil.getTicket(accessToken, wechatBinding.getAppid());
        return jsApiTicket.getTicket();
    }

    /**
     *
     * @param bindId
     * @return
     */
    public static Map<String, String> getJssdkSignature(String url,String bindId){
        String accessToken = getAccessTokenByBindId(bindId);
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByBindId(bindId);
        JsApiTicket jsApiTicket = JsSdkUtil.getTicket(accessToken, wechatBinding.getAppid());
        Map<String, String> ret = SignUtil.getJssdkSignature(jsApiTicket.getTicket(), url);
        ret.put("appid", wechatBinding.getAppid());
        return ret;
    }

    /**
     * 拉起卡券列表,仅供测试
     * @param bindId
     * @return
     */
    public static Map<String, String> getTestChooseCardSignature(String bindId){
        String accessToken = getAccessTokenByBindId(bindId);
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByBindId(bindId);
        JsApiTicket jsApiTicket = JsSdkUtil.getApiTicket(accessToken, wechatBinding.getAppid());
        Map<String, String> ret = SignUtil.getChooseCard(jsApiTicket.getTicket(), "pyvukt5IKE4d53TYts83OlooVDjM", null);
        return ret;
    }


    /**
     * 添加卡券,仅供测试
     * @param bindId
     * @return
     */
    public static Map<String, String> getAddCardConfig(String bindId){
        String accessToken = getAccessTokenByBindId(bindId);
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByBindId(bindId);
        JsApiTicket jsApiTicket = JsSdkUtil.getApiTicket(accessToken, wechatBinding.getAppid());
        return SignUtil.getAddCardConfig(jsApiTicket.getTicket(), "pyvukt5IKE4d53TYts83OlooVDjM", null, null, null);
    }


    /**
     * 保存微信服务器文件至本地服务器/文件服务器,
     * @param bindId
     * @return
     */
    public static String saveMedia(String bindId,String serverId,String type){
        String accessToken = getAccessTokenByBindId(bindId);
        return AdvancedUtil.saveMedia(accessToken, serverId, type);
    }

    /**
     * 发送模板消息
     * @param tm
     */
    public static void sendTemplateMessage(TemplateMessage tm){
        String accessToken = getAccessToken();
        AdvancedUtil.sendTemplateMessage(accessToken,tm);
    }

    /**
     * 发送模板消息
     * @param tm
     */
    public static void sendTemplateMessageFrontend(TemplateMessage tm,String bindid){
        String accessToken = getAccessTokenByBindId(bindid);
        AdvancedUtil.sendTemplateMessage(accessToken,tm);
    }
    public static void sendTemplateMessageFrontend(String tm,String bindid){
        String accessToken = getAccessTokenByBindId(bindid);
        AdvancedUtil.sendTemplateMessage(accessToken,tm);
    }
    /**
     * 获取图文列表
     * @param offset
     * @param count
     * @return
     */
    public static MaterialNewsResult BatchGetMaterialNews(int offset,int count){
        String accessToken = getAccessToken();
        return AdvancedUtil.BatchGetMaterialNews(accessToken, offset, count);
    }

    /**
     * 根据OpenID列表群发图文
     * @param mediaId
     * @param openids
     * @return
     */
    public static WechatError BatchSendMaterialNews(String mediaId, List<String> openids){
        String accessToken = getAccessToken();
        return AdvancedUtil.BatchSendMaterialNews(accessToken, mediaId, openids);
    }

    /**
     * 获取关注者列表
     * @return
     */
    public static WechatUserList getAllWechatUsers(){
        WechatBinding wechatBinding = getWechatBindingByUser();
        if(wechatBinding == null || StringUtils.isBlank(wechatBinding.getAppid())){
            return null;
        }
        try {
            String accessToken = getAccessToken();
            WechatUserList userList =  AdvancedUtil.getWechatUserList(accessToken, null);
            Map<String,List> dataMap = new HashMap<String,List>();
            List tempList = new ArrayList();
            while(StringUtils.isNotBlank(userList.getNext_openid())){
                tempList.addAll(userList.getData().get("openid"));
                userList = AdvancedUtil.getWechatUserList(accessToken, userList.getNext_openid());
            }
            dataMap.put("openid", tempList);
            userList.setData(dataMap);
            logger.info("关注者openid数量 ： " + userList.getData().get("openid").size());
            return userList;
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return null;
        }
    }

    /**
     *
     * @param menu
     * @return
     */
    public static int createMenu(Menu menu){
        String accessToken = getAccessToken();
        return WechatUtil.createMenu(menu, accessToken);
    }

    /**
     *
     * @param menu
     * @return
     */
    public static void createConditionalMenu(Menu menu){
        String accessToken = getAccessToken();
        WechatUtil.createConditionalMenu(menu, accessToken);
    }

    /**
     *
     */
    public static void deleteMenu(){
        String accessToken = getAccessToken();
        WechatUtil.deleteMenu(accessToken);
    }

    /**
     *
     * @param wechatGroup
     */
    public static void createWechatGroup(WechatGroup wechatGroup){
        String accessToken = getAccessToken();
        AdvancedUtil.createWechatGroup(accessToken, wechatGroup);
    }

    /**
     *
     * @param wechatGroup
     */
    public static void updateWechatGroup(WechatGroup wechatGroup){
        String accessToken = getAccessToken();
        AdvancedUtil.updateWechatGroup(accessToken, wechatGroup);
    }

    /**
     *
     * @param wechatGroup
     */
    public static void deleteWechatGroup(WechatGroup wechatGroup){
        String accessToken = getAccessToken();
        AdvancedUtil.deleteWechatGroup(accessToken, wechatGroup);
    }

    /**
     *
     * @return
     */
    public static WechatGroups getWechatGroups(){
        if(StringUtils.isNotBlank(getWechatBindingByUser().getAppid())){
            String accessToken = getAccessToken();
            return AdvancedUtil.getWechatGroups(accessToken);
        }else{
            return new WechatGroups();
        }

    }

    /**
     *
     * @param openid
     */
    public static Map getWechatUserGroup(String openid){
        String accessToken = getAccessToken();
        return AdvancedUtil.getWechatGroup(accessToken, openid);
    }

    /**
     *
     * @param openid
     * @param to_groupid
     */
    public static void updateWechatUserGroup(String openid,String to_groupid){
        String accessToken = getAccessToken();
        AdvancedUtil.updateWechatUserGroup(accessToken, openid, to_groupid);
    }


    /**
     *
     * @param shortTemplateId
     */
    public static String addTemplate(String shortTemplateId){
        String accessToken = getAccessToken();
        return AdvancedUtil.addTemplate(accessToken, shortTemplateId );
    }

    /**
     *
     * @param templateId
     * @return
     */
    public static WechatError deleteTemplate(String templateId){
        String accessToken = getAccessToken();
        return AdvancedUtil.deleteTemplate(accessToken, templateId);
    }

    /**
     *
     * @param sceneStr
     * @return
     */
    public static String generateQrcode(String sceneStr){
        String accessToken = getAccessToken();
        QrcodeResult qrcodeResult = AdvancedUtil.generateQrcode(accessToken, sceneStr);
        String url = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=";
        String ticket = qrcodeResult.getTicket();
        try {
            ticket = URLEncoder.encode(ticket, CommonConstants.ENCODING_UTF8);
        } catch (UnsupportedEncodingException e) {
            logger.error(e.getMessage(),e);
        }
        return url + ticket;
    }

}
