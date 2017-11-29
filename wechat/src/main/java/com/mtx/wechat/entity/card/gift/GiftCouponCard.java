package com.mtx.wechat.entity.card.gift;

import com.mtx.wechat.entity.card.base.Card;

/**
 * Created by wensheng on 12/17/2014.
 */
public class GiftCouponCard  extends Card {

    private GiftCoupon gift;

    public GiftCoupon getGift() {
        return gift;
    }

    public void setGift(GiftCoupon gift) {
        this.gift = gift;
    }
}
