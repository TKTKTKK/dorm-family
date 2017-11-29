package com.mtx.wechat.entity.card.boarding;

import com.mtx.wechat.entity.card.base.Card;

/**
 * Created by wensheng on 12/17/2014.
 */
public class BoardingCouponCard extends Card {

    private BoardingCoupon boarding_pass;

    public BoardingCoupon getBoarding_pass() {
        return boarding_pass;
    }

    public void setBoarding_pass(BoardingCoupon boarding_pass) {
        this.boarding_pass = boarding_pass;
    }
}
