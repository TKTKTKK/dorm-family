package com.mtx.wechat.entity.card.cash;

import com.mtx.wechat.entity.card.base.Card;

/**
 * Created by wensheng on 12/17/2014.
 */
public class CashCouponCard extends Card {

    private CashCoupon cash;

    public CashCoupon getCash() {
        return cash;
    }

    public void setCash(CashCoupon cash) {
        this.cash = cash;
    }
}
