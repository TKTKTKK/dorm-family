package com.mtx.wechat.provider.request;

import com.mtx.wechat.entity.message.request.*;
import com.mtx.common.utils.StringUtils;
import com.mtx.wechat.WechatConstants;
import com.mtx.wechat.utils.MessageUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;

/**
 * Created by wensheng on 14-11-13.
 */
public class RequestEventMessageProvider implements RequestMessageProvider {

    private static Logger logger = LoggerFactory.getLogger(RequestEventMessageProvider.class);

    public BaseRequestMessage provide(Map<String, String> requestMap) {
        // 发送方帐号（open_id）
        String fromUserName = requestMap.get(WechatConstants.MSG_PROP_FROMUSERNAME);
        // 公众帐号
        String toUserName = requestMap.get(WechatConstants.MSG_PROP_TOUSERNAME);
        // 事件类型
        String eventType = requestMap.get(WechatConstants.MSG_PROP_EVENT);

        RequestEventMessage eventMessage = new RequestEventMessage();
        eventMessage.setToUserName(toUserName);
        eventMessage.setFromUserName(fromUserName);
        eventMessage.setMsgType(MessageUtil.REQ_MESSAGE_TYPE_EVENT);
        eventMessage.setEvent(eventType);

        // 自定义菜单点击事件
        if (eventType.equals(MessageUtil.EVENT_TYPE_CLICK)) {
            String eventKey = requestMap.get(WechatConstants.MSG_PROP_EVENTKEY);
            RequestMenuEventMessage menuEventMessage = new RequestMenuEventMessage();
            menuEventMessage.setToUserName(toUserName);
            menuEventMessage.setFromUserName(fromUserName);
            menuEventMessage.setMsgType(MessageUtil.REQ_MESSAGE_TYPE_EVENT);
            menuEventMessage.setEvent(eventType);
            menuEventMessage.setEventKey(eventKey);
            return menuEventMessage;
        }else if (eventType.equals(MessageUtil.EVENT_TYPE_SUBSCRIBE)){
            String eventKey = requestMap.get(WechatConstants.MSG_PROP_EVENTKEY);
            //用户扫描带场景值的二维码，且用户还未关注公众账号
            if(StringUtils.isNotBlank(eventKey) && eventKey.startsWith("qrscene_")){
                String ticket = requestMap.get(WechatConstants.MSG_PROP_TICKET);
                RequestQRCodeEventMessage qrCodeEventMessage = new RequestQRCodeEventMessage();
                qrCodeEventMessage.setToUserName(toUserName);
                qrCodeEventMessage.setFromUserName(fromUserName);
                qrCodeEventMessage.setMsgType(MessageUtil.REQ_MESSAGE_TYPE_EVENT);
                qrCodeEventMessage.setEvent(eventType);
                qrCodeEventMessage.setEventKey(eventKey);
                qrCodeEventMessage.setTicket(ticket);
                return qrCodeEventMessage;
            }
        }else if (eventType.equalsIgnoreCase(MessageUtil.EVENT_TYPE_SCAN)){
            //用户扫描带场景值的二维码，且用户已关注公众账号
            String eventKey = requestMap.get(WechatConstants.MSG_PROP_EVENTKEY);
            String ticket = requestMap.get(WechatConstants.MSG_PROP_TICKET);
            RequestQRCodeEventMessage qrCodeEventMessage = new RequestQRCodeEventMessage();
            qrCodeEventMessage.setToUserName(toUserName);
            qrCodeEventMessage.setFromUserName(fromUserName);
            qrCodeEventMessage.setMsgType(MessageUtil.REQ_MESSAGE_TYPE_EVENT);
            qrCodeEventMessage.setEvent(eventType);
            qrCodeEventMessage.setEventKey(eventKey);
            qrCodeEventMessage.setTicket(ticket);
            return qrCodeEventMessage;
        }else if(eventType.equals(MessageUtil.EVENT_TYPE_LOCATION)){
            String latitude = requestMap.get(WechatConstants.MSG_PROP_LATITUDE);
            String longitude = requestMap.get(WechatConstants.MSG_PROP_LONGITUDE);
            String precision = requestMap.get(WechatConstants.MSG_PROP_PRECISION);

            RequestLocationEventMessage locationEventMessage = new RequestLocationEventMessage();
            locationEventMessage.setToUserName(toUserName);
            locationEventMessage.setFromUserName(fromUserName);
            locationEventMessage.setMsgType(MessageUtil.REQ_MESSAGE_TYPE_EVENT);
            locationEventMessage.setEvent(eventType);
            locationEventMessage.setLatitude(latitude);
            locationEventMessage.setLongitude(longitude);
            locationEventMessage.setPrecision(precision);
            return locationEventMessage;
        }else if(MessageUtil.isCardEvent(eventType)){
            String cardId = requestMap.get(WechatConstants.MSG_PROP_CARDID);
            String isGiveByFriend = requestMap.get(WechatConstants.MSG_PROP_ISGIVEBYFRIEND);
            String userCardCode = requestMap.get(WechatConstants.MSG_PROP_USERCARDCODE);
            String outerId = requestMap.get(WechatConstants.MSG_PROP_OUTERID);

            RequestCardEventMessage cardEventMessage = new RequestCardEventMessage();
            cardEventMessage.setToUserName(toUserName);
            cardEventMessage.setFromUserName(fromUserName);
            cardEventMessage.setMsgType(MessageUtil.REQ_MESSAGE_TYPE_EVENT);
            cardEventMessage.setEvent(eventType);
            cardEventMessage.setCardId(cardId);
            cardEventMessage.setUserCardCode(userCardCode);
            try {
                if (StringUtils.isNotBlank(isGiveByFriend)) {
                    cardEventMessage.setIsGiveByFriend(Integer.parseInt(isGiveByFriend));
                }
                if (StringUtils.isNotBlank(outerId)) {
                    cardEventMessage.setOuterId(Integer.parseInt(outerId));
                }
            } catch (NumberFormatException e) {
                logger.error("error",e);
            }
            return cardEventMessage;
        }

        return eventMessage;
    }
}
