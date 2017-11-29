package com.mtx.wechat.entity.card.scenic;

import com.mtx.wechat.entity.card.base.Coupon;

/**
 * Created by wensheng on 12/17/2014.
 */
public class ScenicCoupon extends Coupon {

    private String ticket_class;
    private String guide_url;

    public String getTicket_class() {
        return ticket_class;
    }

    public void setTicket_class(String ticket_class) {
        this.ticket_class = ticket_class;
    }

    public String getGuide_url() {
        return guide_url;
    }

    public void setGuide_url(String guide_url) {
        this.guide_url = guide_url;
    }
}
