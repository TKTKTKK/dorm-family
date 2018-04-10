package com.dorm.wechat.service;

import com.dorm.wechat.WechatConstants;
import com.dorm.wechat.entity.admin.WechatBinding;
import com.dorm.wechat.entity.message.request.BaseRequestMessage;
import org.springframework.stereotype.Service;

@Service
public class AnnualRenewService implements MessageProcessService {

    @Override
    public String processMessage(BaseRequestMessage reqMessage, WechatBinding wechatBinding) {
        //todo : better notification of annual renew
        return WechatConstants.DEFAULT_REPLY_MSG;
    }

}
