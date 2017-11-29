package com.mtx.wechat.entity.card.scenic;

import com.mtx.wechat.entity.card.base.Card;

/**
 * Created by wensheng on 12/17/2014.
 */
public class ScenicCard extends Card {

    private ScenicCoupon scenic_ticket;

    public ScenicCoupon getScenic_ticket() {
        return scenic_ticket;
    }

    public void setScenic_ticket(ScenicCoupon scenic_ticket) {
        this.scenic_ticket = scenic_ticket;
    }
}
