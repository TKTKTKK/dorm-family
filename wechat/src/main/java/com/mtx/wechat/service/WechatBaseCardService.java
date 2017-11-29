package com.mtx.wechat.service;

import com.mtx.wechat.entity.admin.WechatBaseCard;
import com.mtx.wechat.entity.card.WechatCard;
import com.mtx.wechat.entity.card.base.Card;
import com.mtx.wechat.entity.param.card.ActionInfo;
import com.mtx.wechat.utils.CardUtil;
import com.mtx.wechat.utils.WechatBindingUtil;
import com.mtx.common.base.BaseService;
import com.mtx.wechat.entity.param.card.CardTicketParam;
import com.mtx.wechat.mapper.WechatCardMapper;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by wensheng on 1/16/2015.
 */
@Service
@Transactional
public class WechatBaseCardService extends BaseService<WechatCardMapper,WechatBaseCard> {

    @Autowired
    public void setMapper(WechatCardMapper mapper) {
        super.setMapper(mapper);
    }

    /**
     * 添加卡券
      * @param wechatBaseCard
     * @param card
     */
    public void addCard(WechatBaseCard wechatBaseCard, Card card){
        //添加会员卡
        mapper.insert(wechatBaseCard);

        WechatCard wechatCard = new WechatCard();
        wechatCard.setCard(card);

        Gson gson = new Gson();
        System.out.println(gson.toJson(wechatCard));

        // 调用接口获取access_token
        String at = WechatBindingUtil.getAccessToken();

        String card_id = CardUtil.createCard(at, wechatCard);
        System.out.println(card_id);

        //通过公众平台创建卡券成功
        if(null != card_id){
            mapper.updateCardAfterCreate(card_id, wechatBaseCard.getCard_id());
        }
    }

    /**
     * 修改卡券
     * @param wechatBaseCard
     * @param wechatCard
     */
    public void updateCard(WechatBaseCard wechatBaseCard, WechatCard wechatCard){
        //修改会员卡
        mapper.updatePartial(wechatBaseCard);

//        Gson gson = new Gson();
//        System.out.println(gson.toJson(wechatCard));
//        // 第三方用户唯一凭证
//        String appId = ConfigHolder.getAppId();
//        // 第三方用户唯一凭证密钥
//        String appSecret = ConfigHolder.getAppSecret();
//
//        // 调用接口获取access_token
//        AccessToken at = WechatUtil.getAccessToken(appId, appSecret);
//
//        String card_id = AdvancedUtil.createCard(at.getToken(), wechatCard);
//        System.out.println(card_id);
//
//        //通过公众平台创建卡券成功
//        if(null != card_id){
//            mapper.updateCardAfterCreate(card_id, wechatBaseCard.getCard_id());
//        }
    }

    /**
     * 上传二维码
     */
    public void createQrCode(WechatBaseCard wechatBaseCard){
        // 调用接口获取access_token
        String at = WechatBindingUtil.getAccessToken();

        CardTicketParam cardTicketParam = new CardTicketParam();
        cardTicketParam.setAction_name("QR_CARD");
        com.mtx.wechat.entity.param.card.Card card = new com.mtx.wechat.entity.param.card.Card();
        card.setCard_id(wechatBaseCard.getCard_id());
        card.setExpire_seconds(String.valueOf(18000));
        card.setOuter_id(1);
        ActionInfo actionInfo = new ActionInfo();
        actionInfo.setCard(card);
        cardTicketParam.setAction_info(actionInfo);
        String ticket = CardUtil.getCardTicket(at, cardTicketParam);
        System.out.print(ticket);

        //修改basecard
        wechatBaseCard.setTicket(ticket);
        mapper.updatePartial(wechatBaseCard);
    }
}
