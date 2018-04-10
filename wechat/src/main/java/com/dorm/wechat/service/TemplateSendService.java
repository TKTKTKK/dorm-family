package com.dorm.wechat.service;

import com.dorm.wechat.entity.message.request.BaseRequestMessage;
import com.dorm.wechat.WechatConstants;
import com.dorm.wechat.entity.admin.WechatBinding;
import org.springframework.stereotype.Service;

/**
 * Created by wensheng on 15-5-28.
 */

@Service
public class TemplateSendService implements MessageProcessService {

    @Override
    public String processMessage(BaseRequestMessage reqMessage, WechatBinding wechatBinding) {
        return WechatConstants.DEFAULT_REPLY_MSG;
    }
}
