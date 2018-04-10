package com.dorm.wechat.service;

import com.dorm.wechat.entity.admin.RespSetting;
import com.dorm.wechat.entity.admin.WechatBinding;
import com.dorm.wechat.entity.message.request.BaseRequestMessage;
import com.dorm.wechat.entity.message.request.RequestMenuEventMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by wensheng on 15-1-29.
 */

@Service
public class ClickService implements MessageProcessService {
    private Logger logger = LoggerFactory.getLogger(ClickService.class);

    @Autowired
    private AutoReplyService autoReplyService;

    @Override
    public String processMessage(BaseRequestMessage reqMessage, WechatBinding wechatBinding) {
        RequestMenuEventMessage menuEventMessage = (RequestMenuEventMessage) reqMessage;
        RespSetting rs = autoReplyService.getEventRespSetting(wechatBinding.getUuid(),menuEventMessage.getEvent(), menuEventMessage.getEventKey());
        if (rs != null) {
            return autoReplyService.getRespMessage(reqMessage,rs);
        }
        return null;
    }
}
