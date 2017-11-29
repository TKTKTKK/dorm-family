package com.mtx.wechat.service;

import com.mtx.wechat.entity.admin.WechatBaseCard;
import com.mtx.common.base.CommonConstants;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.admin.WechatCardCode;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import com.mtx.wechat.entity.message.request.RequestCardEventMessage;
import com.mtx.wechat.utils.MessageUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by wensheng on 1/16/2015.
 */
@Service
@Transactional
public class CardEventService  implements MessageProcessService {
    private static Logger logger = LoggerFactory.getLogger(CardEventService.class);

    @Autowired
    private WechatBaseCardService wechatBaseCardService;
    @Autowired
    private WechatCardCodeService wechatCardCodeService;

    public String processMessage(BaseRequestMessage reqMessage, WechatBinding wechatBinding) {
        logger.info("*********Card Event Processing*******\n");
        RequestCardEventMessage cardEventMessage = (RequestCardEventMessage)reqMessage;
        logger.info("*********Card Event Type*******" + cardEventMessage.getEvent() + "\n");
        if(MessageUtil.EVENT_TYPE_CARD_PASS.equals(cardEventMessage.getEvent()) || MessageUtil.EVENT_TYPE_CARD_REJECT.equals(cardEventMessage.getEvent())){
           //卡券审核通过/拒绝
            logger.info("*********Card Event App or Rej*******\n");
            WechatBaseCard wechatBaseCard = new WechatBaseCard();
            wechatBaseCard.setCard_id(cardEventMessage.getCardId());
            wechatBaseCard.setBindid(wechatBinding.getUuid());
            wechatBaseCard = wechatBaseCardService.queryForObjectByUniqueKey(wechatBaseCard);

            WechatBaseCard updateWechatCard = new WechatBaseCard();
            updateWechatCard.setUuid(wechatBaseCard.getUuid());
            updateWechatCard.setVersionno(wechatBaseCard.getVersionno());
            if (MessageUtil.EVENT_TYPE_CARD_PASS.equals(cardEventMessage.getEvent())) {
                updateWechatCard.setStatus(CommonConstants.STATUS_APPROVE);
            }else{
                updateWechatCard.setStatus(CommonConstants.STATUS_REJECT);
            }
            wechatBaseCardService.updatePartial(updateWechatCard);

        }else if(MessageUtil.EVENT_TYPE_CARD_GET.equals(cardEventMessage.getEvent())){
            //卡券被用户领取
            logger.info("*********Card Event Get*******\n");
            WechatBaseCard wechatBaseCard = new WechatBaseCard();
            wechatBaseCard.setCard_id(cardEventMessage.getCardId());
            wechatBaseCard.setBindid(wechatBinding.getUuid());
            wechatBaseCard = wechatBaseCardService.queryForObjectByUniqueKey(wechatBaseCard);
            WechatCardCode wechatCardCode = new WechatCardCode();
            wechatCardCode.setCardid(wechatBaseCard.getUuid());
            wechatCardCode.setCard_id(wechatBaseCard.getCard_id());
            wechatCardCode.setCode(cardEventMessage.getUserCardCode());
            wechatCardCode.setIsgivebyfriend(cardEventMessage.getIsGiveByFriend());
            wechatCardCode.setFriendopenid(cardEventMessage.getFriendUserName());
            wechatCardCode.setOuterid(cardEventMessage.getOuterId());
            wechatCardCode.setOpenid(cardEventMessage.getFromUserName());
            wechatCardCode.setStatus(CommonConstants.STATUS_INIT);
            wechatCardCodeService.insert(wechatCardCode);

        }else if(MessageUtil.EVENT_TYPE_CARD_DEL.equals(cardEventMessage.getEvent())){
            //卡券被用户删除
            logger.info("*********Card Event Delete*******\n");
            WechatCardCode wechatCardCode = new WechatCardCode();
            wechatCardCode.setCard_id(cardEventMessage.getCardId());
            wechatCardCode.setCode(cardEventMessage.getUserCardCode());
            wechatCardCode = wechatCardCodeService.queryForObjectByUniqueKey(wechatCardCode);
            wechatCardCode.setStatus(CommonConstants.STATUS_DEL);
            wechatCardCodeService.updatePartial(wechatCardCode);
        }
        return "";
    }
}
