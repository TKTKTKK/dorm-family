package com.mtx.wechat.processor;

import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import com.mtx.wechat.entity.message.request.RequestTextMessage;
import com.mtx.wechat.factory.MessageProcessServiceFactory;
import com.mtx.wechat.service.MessageProcessService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * Created by wensheng on 14-11-15.
 */

@Component
public class RequestTextMessageProcessor implements RequestMessageProcessor {

    private static Logger logger = LoggerFactory.getLogger(RequestTextMessageProcessor.class);
    private MessageProcessService service;

    @Override
    public void setService(String serviceType) {
        MessageProcessServiceFactory messageProcessServiceFactory = new MessageProcessServiceFactory(serviceType);
        service = messageProcessServiceFactory.getService();
    }


    /**
     * 自动回复
     * @param requestMessage
     * @return
     */
    @Override
    public String process(BaseRequestMessage requestMessage, WechatBinding wechatBinding) {
        RequestTextMessage requestTextMessage = ((RequestTextMessage)requestMessage);
        String msgType = requestTextMessage.getMsgType();
        setService(msgType);
        return service.processMessage(requestMessage,wechatBinding);
    }
}
