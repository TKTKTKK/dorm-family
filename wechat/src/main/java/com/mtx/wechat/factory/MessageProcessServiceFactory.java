package com.mtx.wechat.factory;


import com.mtx.common.utils.ApplicationContextUtil;
import com.mtx.common.utils.ConfigHolder;
import com.mtx.wechat.service.MessageProcessService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MessageProcessServiceFactory {
    private static Logger logger = LoggerFactory.getLogger(MessageProcessServiceFactory.class);

    private MessageProcessService service;

    public MessageProcessServiceFactory(String serviceType) {
        String serviceName = ConfigHolder.getConfigValue(serviceType);
        logger.info("**********MessageProcessService Name : " + serviceName + " ******************");
        this.service = (MessageProcessService) ApplicationContextUtil.getBean(serviceName);
    }

    public MessageProcessService getService(){
        return this.service;
    }
}
