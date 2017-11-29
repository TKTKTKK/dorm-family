package com.mtx.wechat.entity.card.discount;

import com.mtx.wechat.entity.card.base.Coupon;

/**
 * Created by wensheng on 12/17/2014.
 */
public class DiscountCoupon extends Coupon {

    private Integer discount;

    public Integer getDiscount() {
        return discount;
    }

    public void setDiscount(Integer discount) {
        this.discount = discount;
    }
}
