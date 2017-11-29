package com.mtx.wechat.service;

import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import org.springframework.stereotype.Service;

/**
 * Created by wensheng on 14-12-1.
 */
@Service
public class ViewService implements MessageProcessService {

    @Override
    public String processMessage(BaseRequestMessage reqMessage,WechatBinding wechatBinding) {
        return "";
    }
}