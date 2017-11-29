package com.mtx.wechat.entity.card.discount;

import com.mtx.wechat.entity.card.base.Card;

/**
 * Created by wensheng on 12/17/2014.
 */
public class DiscountCouponCard extends Card {

    private DiscountCoupon discount;

    public DiscountCoupon getDiscount() {
        return discount;
    }

    public void setDiscount(DiscountCoupon discount) {
        this.discount = discount;
    }
}
