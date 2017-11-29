package com.mtx.wechat.entity.card.cash;

import com.mtx.wechat.entity.card.base.Coupon;

/**
 * Created by wensheng on 12/17/2014.
 */
public class CashCoupon extends Coupon {

    private Long least_cost;
    private Long reduce_cost;

    public Long getLeast_cost() {
        return least_cost;
    }

    public void setLeast_cost(Long least_cost) {
        this.least_cost = least_cost;
    }

    public Long getReduce_cost() {
        return reduce_cost;
    }

    public void setReduce_cost(Long reduce_cost) {
        this.reduce_cost = reduce_cost;
    }
}
