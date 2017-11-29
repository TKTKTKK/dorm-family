package com.mtx.wechat.provider.request;

import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import com.mtx.wechat.entity.message.request.RequestTextMessage;
import com.mtx.wechat.utils.MessageUtil;

import java.util.Map;

/**
 * Created by wensheng on 14-11-13.
 */
public class RequestTextMessageProvider implements RequestMessageProvider {

    public BaseRequestMessage provide(Map<String, String> requestMap) {
        // 发送方帐号（open_id）
        String fromUserName = requestMap.get("FromUserName");
        // 公众帐号
        String toUserName = requestMap.get("ToUserName");
        // 消息内容
        String content = requestMap.get("Content");

        RequestTextMessage textMessage = new RequestTextMessage();
        textMessage.setToUserName(toUserName);
        textMessage.setFromUserName(fromUserName);
        textMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
        textMessage.setContent(content);
        return textMessage;
    }
}
