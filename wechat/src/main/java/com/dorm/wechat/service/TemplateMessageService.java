package com.dorm.wechat.service;

import com.dorm.wechat.utils.WechatBindingUtil;
import com.dorm.wechat.entity.param.tm.TemplateMessage;
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
