package com.mtx.wechat.entity.result.card;

import com.mtx.wechat.entity.WechatError;

/**
 * Created by wensheng on 1/19/2015.
 */
public class CardTicketResult extends WechatError {

    private String ticket;

    public String getTicket() {
        return ticket;
    }

    public void setTicket(String ticket) {
        this.ticket = ticket;
    }
}
