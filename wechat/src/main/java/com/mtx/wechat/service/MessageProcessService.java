package com.mtx.wechat.service;

import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;

/**
 * 消息处理接口，根据实际业务逻辑由具体模块提供实现
 * Created by wensheng on 14-11-14.
 */

public interface MessageProcessService {
    public String processMessage(BaseRequestMessage reqMessage,WechatBinding wechatBinding);
}
