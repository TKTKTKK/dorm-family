package com.dorm.wechat.service;

import com.dorm.wechat.entity.WechatUser;
import com.dorm.wechat.entity.WpUser;
import com.dorm.wechat.entity.message.request.BaseRequestMessage;
import com.dorm.wechat.entity.message.request.RequestEventMessage;
import com.dorm.wechat.utils.WechatBindingUtil;
import com.dorm.wechat.entity.admin.RespSetting;
import com.dorm.wechat.entity.admin.WechatBinding;
import com.dorm.wechat.entity.message.request.RequestQRCodeEventMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by wensheng on 14-11-15.
 */

@Service
@Transactional
public class SubscribeService implements MessageProcessService {

    private static Logger logger = LoggerFactory.getLogger(MessageProcessService.class);

    @Autowired
    private AutoReplyService autoReplyService;
    @Autowired
    private WpUserService wpUserService;

    /**
     *
     * @param reqMessage
     * @param wechatBinding
     * @return
     */
    @Override
    public String processMessage(BaseRequestMessage reqMessage, WechatBinding wechatBinding) {

        RequestEventMessage requestEventMessage = (RequestEventMessage)reqMessage;
        if(requestEventMessage instanceof RequestQRCodeEventMessage){
            RequestQRCodeEventMessage qrcodeScanEvent = (RequestQRCodeEventMessage)requestEventMessage;
            //扫描带参数二维码并关注事件
            if("subscribe".equals(qrcodeScanEvent.getEvent())){
                //todo
            }
        }
        WechatUser wechatUser = WechatBindingUtil.getWechatUser(wechatBinding.getUuid(), reqMessage.getFromUserName());
        WpUser wpUser = new WpUser();
        wpUser.setOpenid(reqMessage.getFromUserName());
        wpUser = wpUserService.queryForObjectByUniqueKey(wpUser);
        if(null != wpUser){
            wpUser.setNickname(wechatUser.getNickname());
            wpUser.setHeadimgurl(wechatUser.getHeadimgurl());
            wpUser.setIfsubscribe("Y");
            try {
                wpUserService.updatePartial(wpUser);
            } catch (Exception e) {
                logger.error(e.getMessage(),e);
            }
        }else{
            wpUser = new WpUser();
            wpUser.setBindid(wechatBinding.getUuid());
            wpUser.setOpenid(reqMessage.getFromUserName());
            wpUser.setNickname(wechatUser.getNickname());
            wpUser.setHeadimgurl(wechatUser.getHeadimgurl());
            wpUser.setIfsubscribe("Y");
            wpUserService.insert(wpUser);
        }

        //注意此处传递Event，而不是MsgType
        RespSetting rs = autoReplyService.getEventRespSetting(wechatBinding.getUuid(),requestEventMessage.getEvent(),null);
        if(rs != null){
           return autoReplyService.getRespMessage(reqMessage,rs);
        }

        //没有找到关键词回复，则使用默认文本回复
        return autoReplyService.getDefaultRespTextMessage(reqMessage,wechatBinding.getUuid(),requestEventMessage.getEvent());
    }
}
