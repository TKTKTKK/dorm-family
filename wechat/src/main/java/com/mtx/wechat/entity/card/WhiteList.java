package com.mtx.wechat.entity.card;

import java.util.List;

/**
 * Created by wensheng on 14-12-17.
 */
public class WhiteList {

    private List<String> openid;
    private List<String> username;

    public List<String> getOpenid() {
        return openid;
    }

    public void setOpenid(List<String> openid) {
        this.openid = openid;
    }

    public List<String> getUsername() {
        return username;
    }

    public void setUsername(List<String> username) {
        this.username = username;
    }
}
