package com.mtx.wechat.entity.card.gift;

import com.mtx.wechat.entity.card.base.Coupon;

/**
 * Created by wensheng on 12/17/2014.
 */
public class GiftCoupon extends Coupon {

    private String gift;

    public String getGift() {
        return gift;
    }

    public void setGift(String gift) {
        this.gift = gift;
    }
}
