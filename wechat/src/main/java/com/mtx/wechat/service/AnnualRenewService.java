package com.mtx.wechat.service;

import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.WechatConstants;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import org.springframework.stereotype.Service;

@Service
public class AnnualRenewService implements MessageProcessService {

    @Override
    public String processMessage(BaseRequestMessage reqMessage, WechatBinding wechatBinding) {
        //todo : better notification of annual renew
        return WechatConstants.DEFAULT_REPLY_MSG;
    }

}
