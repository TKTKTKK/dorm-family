package com.mtx.wechat.utils;

import com.mtx.wechat.entity.WechatError;
import com.mtx.wechat.entity.card.WechatCard;
import com.mtx.wechat.entity.card.WhiteList;
import com.mtx.wechat.entity.card.color.Colors;
import com.mtx.wechat.entity.param.card.*;
import com.mtx.wechat.entity.result.card.CardTicketResult;
import com.mtx.common.base.CommonConstants;
import com.mtx.common.utils.StringUtils;
import com.mtx.wechat.WechatConstants;
import com.mtx.wechat.entity.card.color.Color;
import com.mtx.wechat.entity.result.card.ConsumeCodeResult;
import com.mtx.wechat.entity.result.card.DecryptCodeResult;
import com.mtx.wechat.entity.result.card.UpdateMemberCardResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Map;

/**
 * Created by wensheng on 1/28/2015.
 */
public class CardUtil {
    private static Logger logger = LoggerFactory.getLogger(CardUtil.class);
    /**
     *
     * 卡券测试白名单设置
     * @param accessToken
     * @param whiteList
     */
    public static String createCardWhiteList(String accessToken,WhiteList whiteList){
        String requestUrl = WechatConstants.WECHAT_CARD_TEST_WHITE_LIST_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken);
        String jsonStr = WechatUtil.toJson(whiteList);
        WechatError wechatError = WechatUtil.httpsRequest(requestUrl, CommonConstants.REQUEST_METHOD_POST,jsonStr,WechatError.class);
        return wechatError.getErrcode() + wechatError.getErrmsg();
    }

    /**
     *
     * 创建卡券
     * @param accessToken
     * @param wechatCard
     */
    public static String createCard(String accessToken,WechatCard wechatCard){
        String requestUrl = WechatConstants.WECHAT_CREATE_CARD_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken);
        String jsonStr = WechatUtil.toJson(wechatCard);
        Map resultMap = WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_POST,jsonStr,Map.class);
        if(resultMap != null && StringUtils.isNotBlank((String) resultMap.get("card_id"))){
            return String.valueOf(resultMap.get("card_id"));
        }else{
            return null;
        }
    }

    /**
     *
     * 获取卡券颜色列表
     */
    public static List<Color> getCardColors(String accessToken){
        String requestUrl = WechatConstants.WECHAT_CARD_GET_COLORS_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        Colors colors = WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_GET,null,Colors.class);
        if(colors != null && colors.getErrcode()==0){
            return colors.getColors();
        }else{
            return null;
        }
    }

    /**
     *
     * 获取卡券二维码Ticket
     */
    public static String getCardTicket(String accessToken,CardTicketParam cardTicketParam){
        String requestUrl = WechatConstants.WECHAT_CARD_GET_TICKET_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        String jsonStr = WechatUtil.toJson(cardTicketParam);
        CardTicketResult ticket = WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_POST,jsonStr,CardTicketResult.class);
        if(ticket != null && ticket.getErrcode()==0){
            return ticket.getTicket();
        }else{
            return null;
        }
    }

    /**
     * 核销code
     * @param accessToken
     * @param consumeCodeParam
     * @return
     */
    public static ConsumeCodeResult consumeCode(String accessToken,ConsumeCodeParam consumeCodeParam){
        String requestUrl = WechatConstants.WECHAT_CARD_CODE_CONSUME_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        String jsonStr = WechatUtil.toJson(consumeCodeParam);
        ConsumeCodeResult consumeCodeResult = WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_POST,jsonStr,ConsumeCodeResult.class);
        if(consumeCodeResult != null && consumeCodeResult.getErrcode()==0){
            return consumeCodeResult;
        }else{
            if(consumeCodeResult == null){
                logger.error("卡券code核销失败！无核销结果");
            }else{
                logger.error("卡券code核销失败！错误代码"+ consumeCodeResult.getErrcode());
            }
            return null;
        }
    }

    /**
     * code解码
     * @param accessToken
     * @param encryptCode
     * @return
     */
    public static DecryptCodeResult decryptCode(String accessToken,EncryptCode encryptCode){
        String requestUrl = WechatConstants.WECHAT_CARD_CODE_DECRYPT_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        String jsonStr = WechatUtil.toJson(encryptCode);
        DecryptCodeResult decryptCodeResult = WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_POST,jsonStr,DecryptCodeResult.class);
        if(decryptCodeResult != null && decryptCodeResult.getErrcode()==0){
            return decryptCodeResult;
        }else{
            if(decryptCodeResult == null){
                logger.error("卡券code解码失败！");
            }else{
                logger.error("卡券code解码失败！错误代码"+ decryptCodeResult.getErrcode());
            }
            return null;
        }
    }

    /**
     * 激活会员卡
     * @param accessToken
     * @param activateMemberCard
     * @return
     */
    public static int activateMemberCard(String accessToken,ActivateMemberCard activateMemberCard){
        String requestUrl = WechatConstants.WECHAT_CARD_ACTIVATE_MEMBER_CARD_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        String jsonStr = WechatUtil.toJson(activateMemberCard);
        WechatError result = WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_POST,jsonStr,WechatError.class);
        if(result != null && result.getErrcode()==0){
            return result.getErrcode();
        }else{
            if(result == null){
                logger.error("会员卡激活失败！");
                return -1;
            }else{
                logger.error("会员卡激活失败！错误代码"+ result.getErrcode());
                return result.getErrcode();
            }
        }
    }

    /**
     * 会员卡交易
     * @param accessToken
     * @param updateMemberCard
     * @return
     */
    public static UpdateMemberCardResult updateMemberCard(String accessToken,UpdateMemberCard updateMemberCard){
        String requestUrl = WechatConstants.WECHAT_CARD_MEMBER_CARD_UPDATE_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        String jsonStr = WechatUtil.toJson(updateMemberCard);
        UpdateMemberCardResult result = WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_POST,jsonStr,UpdateMemberCardResult.class);
        if(result != null && result.getErrcode()==0){
            return result;
        }else{
            if(result == null){
                logger.error("会员卡交易失败！");
            }else{
                logger.error("会员卡交易失败！错误代码"+ result.getErrcode());
            }
        }
        return null;
    }

}
