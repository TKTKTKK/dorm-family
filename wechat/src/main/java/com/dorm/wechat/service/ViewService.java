package com.dorm.wechat.service;

import com.dorm.wechat.entity.message.request.BaseRequestMessage;
import com.dorm.wechat.entity.admin.WechatBinding;
import org.springframework.stereotype.Service;

/**
 * Created by wensheng on 14-12-1.
 */
@Service
public class ViewService implements MessageProcessService {

    @Override
    public String processMessage(BaseRequestMessage reqMessage, WechatBinding wechatBinding) {
        return "";
    }
}