package com.mtx.wechat.service;

import com.mtx.wechat.WechatConstants;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by wensheng on 15-5-15.
 */

@Service
public class UnsubscribeService implements MessageProcessService {
    private static Logger logger = LoggerFactory.getLogger(MessageProcessService.class);

    @Autowired
    private WpUserService wpUserService;

    @Override
    public String processMessage(BaseRequestMessage reqMessage, WechatBinding wechatBinding) {

        WpUser wpUser = new WpUser();
        wpUser.setOpenid(reqMessage.getFromUserName());
        wpUser = wpUserService.queryForObjectByUniqueKey(wpUser);
        if(null != wpUser){
            wpUser.setIfsubscribe("N");
            try {
                wpUserService.updatePartial(wpUser);
            } catch (Exception e) {
                logger.error(e.getMessage(),e);
            }
        }

        return WechatConstants.DEFAULT_REPLY_MSG;

    }
}
