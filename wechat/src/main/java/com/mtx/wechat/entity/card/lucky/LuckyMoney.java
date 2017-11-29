package com.mtx.wechat.entity.card.lucky;

import com.mtx.wechat.entity.card.base.Card;

/**
 * Created by wensheng on 12/17/2014.
 */
public class LuckyMoney extends Card {

    private LuckyCoupon lucky_money;

    public LuckyCoupon getLucky_money() {
        return lucky_money;
    }

    public void setLucky_money(LuckyCoupon lucky_money) {
        this.lucky_money = lucky_money;
    }
}
