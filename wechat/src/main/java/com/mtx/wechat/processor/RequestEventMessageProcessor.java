package com.mtx.wechat.processor;

import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import com.mtx.wechat.entity.message.request.RequestEventMessage;
import com.mtx.wechat.entity.message.response.ResponseTextMessage;
import com.mtx.wechat.factory.MessageProcessServiceFactory;
import com.mtx.wechat.service.MessageProcessService;
import com.mtx.wechat.utils.MessageUtil;

/**
 * Created by wensheng on 14-11-15.
 */
public class RequestEventMessageProcessor implements RequestMessageProcessor {

    private MessageProcessService service;

    @Override
    public void setService(String serviceType) {
        MessageProcessServiceFactory messageProcessServiceFactory = new MessageProcessServiceFactory(serviceType);
        service = messageProcessServiceFactory.getService();
    }

    /**
     * 根据Event处理调用相应的Service处理
     * @param requestMessage
     * @return
     */
    @Override
    public String process(BaseRequestMessage requestMessage,WechatBinding wechatBinding) {
        RequestEventMessage requestEventMessage = (RequestEventMessage)requestMessage;
        String eventType = requestEventMessage.getEvent();

        /**********第三方平台全网发布专用测试账号步骤****************/
        if("gh_3c884a361561".equals(requestMessage.getToUserName())){
            ResponseTextMessage respTextMsg = new ResponseTextMessage();
            respTextMsg.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
            respTextMsg = MessageUtil.getRespMessage(requestMessage,respTextMsg);
            respTextMsg.setContent(eventType + "from_callback");
            return MessageUtil.messageToXml(respTextMsg);
        }
        /**********第三方平台全网发布专用测试账号步骤****************/

        setService(eventType);
        return service.processMessage(requestMessage,wechatBinding);
    }
}
