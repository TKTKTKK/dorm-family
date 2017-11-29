package com.mtx.wechat.entity.card.group;

import com.mtx.wechat.entity.card.base.Coupon;

/**
 * Created by wensheng on 12/17/2014.
 */
public class Groupon extends Coupon {

    private String  deal_detail;

    public String getDeal_detail() {
        return deal_detail;
    }

    public void setDeal_detail(String deal_detail) {
        this.deal_detail = deal_detail;
    }
}
