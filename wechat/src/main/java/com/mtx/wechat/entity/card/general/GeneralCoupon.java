package com.mtx.wechat.entity.card.general;

import com.mtx.wechat.entity.card.base.Coupon;

/**
 * Created by wensheng on 12/17/2014.
 */
public class GeneralCoupon extends Coupon {

    private String  default_detail;

    public String getDefault_detail() {
        return default_detail;
    }

    public void setDefault_detail(String default_detail) {
        this.default_detail = default_detail;
    }
}
