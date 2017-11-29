package com.mtx.wechat.service;

import com.mtx.wechat.entity.param.tm.TemplateMessage;
import com.mtx.wechat.utils.WechatBindingUtil;
import org.springframework.stereotype.Service;

/**
 * Created by wensheng on 15-2-7.
 */

@Service
public class TemplateMessageService {

    public void sendTemplateMessage(TemplateMessage tm, String bindid){
        WechatBindingUtil.sendTemplateMessageFrontend(tm,bindid);
    }
    public void sendTemplateMessage(String tm,String bindid){
        WechatBindingUtil.sendTemplateMessageFrontend(tm,bindid);
    }

    public void sendTemplateMessage(TemplateMessage tm){
        WechatBindingUtil.sendTemplateMessage(tm);
    }
}
