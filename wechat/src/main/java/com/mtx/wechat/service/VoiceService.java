package com.mtx.wechat.service;

import com.mtx.wechat.WechatConstants;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import com.mtx.wechat.entity.message.request.RequestVoiceMessage;
import com.mtx.wechat.entity.message.response.ResponseTextMessage;
import com.mtx.wechat.utils.MessageUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * Created by wensheng on 2016/5/28.
 */

@Service
public class VoiceService implements MessageProcessService {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Override
    public String processMessage(BaseRequestMessage reqMessage, WechatBinding wechatBinding) {
        try {
            RequestVoiceMessage requestVoiceMessage = (RequestVoiceMessage)reqMessage;
            ResponseTextMessage respTextMsg = new ResponseTextMessage();
            respTextMsg.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
            respTextMsg = MessageUtil.getRespMessage(reqMessage,respTextMsg);
            respTextMsg.setContent(requestVoiceMessage.getRecognition());
            return MessageUtil.messageToXml(respTextMsg);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
            return WechatConstants.DEFAULT_REPLY_MSG;
        }
    }
}
