package com.mtx.wechat.provider.request;

import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import com.mtx.wechat.entity.message.request.RequestVoiceMessage;
import com.mtx.wechat.utils.MessageUtil;

import java.util.Map;

/**
 * Created by wensheng on 2016/5/28.
 */
public class RequestVoiceMessageProvider implements RequestMessageProvider {

    @Override
    public BaseRequestMessage provide(Map<String, String> requestMap) {
        // 发送方帐号（open_id）
        String fromUserName = requestMap.get("FromUserName");
        // 公众帐号
        String toUserName = requestMap.get("ToUserName");

        String mediaId = requestMap.get("MediaId");
        String recognition = requestMap.get("Recognition");

        RequestVoiceMessage voiceMessage = new RequestVoiceMessage();
        voiceMessage.setToUserName(toUserName);
        voiceMessage.setFromUserName(fromUserName);
        voiceMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_VOICE);
        voiceMessage.setMediaId(mediaId);
        voiceMessage.setRecognition(recognition);
        return voiceMessage;
    }
}
