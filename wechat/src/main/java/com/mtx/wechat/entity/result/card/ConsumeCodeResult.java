package com.mtx.wechat.entity.result.card;

import com.mtx.wechat.entity.WechatError;
import com.mtx.wechat.entity.param.card.Card;

/**
 * Created by wensheng on 1/19/2015.
 */
public class ConsumeCodeResult extends WechatError {

    private Card card;
    private String openid;

    public Card getCard() {
        return card;
    }

    public void setCard(Card card) {
        this.card = card;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }
}
