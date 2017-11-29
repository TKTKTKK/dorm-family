package com.mtx.wechat.service;

import com.mtx.common.OpenApiResult;
import com.mtx.common.utils.HttpUtils;
import com.mtx.common.utils.RequestUtil;
import com.mtx.wechat.WechatConstants;
import com.mtx.wechat.entity.WechatUser;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import com.mtx.wechat.entity.message.request.RequestQRCodeEventMessage;
import com.mtx.wechat.utils.WechatBindingUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
public class ScanService implements MessageProcessService {

    private static Logger logger = LoggerFactory.getLogger(ScanService.class);

    @Autowired
    private AutoReplyService autoReplyService;

    @Override
    public String processMessage(BaseRequestMessage reqMessage, WechatBinding wechatBinding) {

        if(reqMessage instanceof RequestQRCodeEventMessage){
            RequestQRCodeEventMessage qrCodeEventMessage = (RequestQRCodeEventMessage)reqMessage;
            logger.info("**********ScanService : EventKey = " + qrCodeEventMessage.getEventKey() + " *******************");
            if("SIGNIN".equals(qrCodeEventMessage.getEventKey())){
                WechatUser wechatUser = WechatBindingUtil.getWechatUser(wechatBinding.getUuid(),qrCodeEventMessage.getFromUserName());
                //自动签到
                String requestUrl = RequestUtil.getDomainUrl() + "/openapi/activity/sign";
                Map<String,String> paramMap = new HashMap<>();
                paramMap.put("bindid",wechatBinding.getUuid());
                paramMap.put("openid",wechatUser.getOpenid());
                paramMap.put("headimg",wechatUser.getHeadimgurl());
                paramMap.put("nickname",wechatUser.getNickname());
                try {
                    HttpUtils.post(requestUrl,paramMap,RequestUtil.getApiId(),RequestUtil.getApiKey(), OpenApiResult.class);
                } catch (Exception e) {
                    logger.error(e.getMessage(),e);
                }
                return autoReplyService.getRespTextMessage(reqMessage,"签到成功！");
            }
        }
        return WechatConstants.DEFAULT_REPLY_MSG;
    }
}
