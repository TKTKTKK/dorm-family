package com.mtx.wechat.processor;

import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.factory.MessageProcessServiceFactory;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import com.mtx.wechat.service.MessageProcessService;

/**
 * Created by wensheng on 2016/5/28.
 */
public class RequestVoiceMessageProcessor implements RequestMessageProcessor {

    private MessageProcessService service;

    @Override
    public void setService(String serviceType) {
        MessageProcessServiceFactory messageProcessServiceFactory = new MessageProcessServiceFactory(serviceType);
        service = messageProcessServiceFactory.getService();
    }

    @Override
    public String process(BaseRequestMessage requestMessage, WechatBinding wechatBinding) {
        String msgType = requestMessage.getMsgType();
        setService(msgType);
        return service.processMessage(requestMessage,wechatBinding);
    }
}
