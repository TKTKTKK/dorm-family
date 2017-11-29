package com.mtx.wechat.entity.card.member;

import com.mtx.wechat.entity.card.base.Card;

/**
 * Created by wensheng on 12/17/2014.
 */
public class MemberCard extends Card {

    private MemberCoupon member_card;

    public MemberCoupon getMember_card() {
        return member_card;
    }

    public void setMember_card(MemberCoupon member_card) {
        this.member_card = member_card;
    }
}
