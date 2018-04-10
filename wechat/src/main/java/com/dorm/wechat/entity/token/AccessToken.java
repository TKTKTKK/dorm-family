package com.dorm.wechat.entity.token;

import com.dorm.wechat.entity.WechatError;

/**
 * 微信通用接口凭证
 */
public class AccessToken extends WechatError {
    // 获取到的凭证
    private String access_token;
    // 凭证有效时间，单位：秒
    private Integer expires_in;
    // 凭证获得的时间
    private Long createdTime;

    public String getAccess_token() {
        return access_token;
    }

    public void setAccess_token(String access_token) {
        this.access_token = access_token;
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

