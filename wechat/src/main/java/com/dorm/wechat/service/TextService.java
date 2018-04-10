package com.dorm.wechat.service;

import com.dorm.wechat.entity.admin.RespSetting;
import com.dorm.wechat.entity.admin.WechatBinding;
import com.dorm.wechat.entity.message.request.BaseRequestMessage;
import com.dorm.wechat.entity.message.request.RequestTextMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by wensheng on 14-11-15.
 */

@Service
public class TextService implements MessageProcessService {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private AutoReplyService autoReplyService;

    /**
     * 根据设置自动回复，目前只支持回复文本，音乐和图文。
     * 如没有找到相关的配置项，则回复默认的文本消息
     * 如没有默认回复的文本消息，则不回复
     * @param reqMessage
     * @param wechatBinding
     * @return
     */
    public String processMessage(BaseRequestMessage reqMessage,WechatBinding wechatBinding) {
        RequestTextMessage requestTextMessage = (RequestTextMessage)reqMessage;
        List<RespSetting> respSettingList = autoReplyService.getRespSettingList(wechatBinding.getUuid(),reqMessage.getMsgType());
        for(RespSetting rs : respSettingList){
            if(requestTextMessage.getContent().contains(rs.getKeywords())){
                return autoReplyService.getRespMessage(reqMessage,rs);
            }
        }

        //没有找到关键词回复，则使用默认文本回复
        return autoReplyService.getDefaultRespTextMessage(reqMessage,wechatBinding.getUuid(),reqMessage.getMsgType());
    }
}
