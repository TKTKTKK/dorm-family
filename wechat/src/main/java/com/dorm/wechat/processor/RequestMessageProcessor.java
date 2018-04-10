package com.dorm.wechat.processor;

import com.dorm.wechat.entity.admin.WechatBinding;
import com.dorm.wechat.entity.message.request.BaseRequestMessage;

/**
 * 消息类型处理接口，需要模块提供具体实现
 * Created by wensheng on 14-11-15.
 */
public interface RequestMessageProcessor {

    public abstract void setService(String serviceType);

    public abstract String process(BaseRequestMessage requestMessage, WechatBinding wechatBinding);
}
