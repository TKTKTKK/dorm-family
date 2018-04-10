package com.dorm.wechat.entity.result.jssdk;

import com.dorm.wechat.entity.WechatError;

/**
 * Created by wensheng on 15-1-25.
 */
public class JsApiTicket extends WechatError {
    private String ticket;
    private Integer expires_in;
    // 凭证获得的时间
    private Long createdTime;

    public String getTicket() {
        return ticket;
    }

    public void setTicket(String ticket) {
        this.ticket = ticket;
    }

    public Integer getExpires_in() {
        return expires_in;
    }

    public void setExpires_in(Integer expires_in) {
        this.expires_in = expires_in;
    }

    public Long getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Long createdTime) {
        this.createdTime = createdTime;
    }

    public boolean tokenExpired(){
        return (System.currentTimeMillis() - getCreatedTime()) / 1000 > 7000;
    }
}
