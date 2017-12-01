package com.mtx.wechat.service;

import com.mtx.wechat.WechatConstants;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import org.springframework.stereotype.Service;

/**
 * Created by wensheng on 15-5-28.
 */

@Service
public class TemplateSendService implements MessageProcessService {

    @Override
    public String processMessage(BaseRequestMessage reqMessage,WechatBinding wechatBinding) {
        return WechatConstants.DEFAULT_REPLY_MSG;
    }
}
