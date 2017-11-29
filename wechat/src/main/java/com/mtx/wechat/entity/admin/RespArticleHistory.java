package com.mtx.wechat.entity.admin;


import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;

public class RespArticleHistory extends BaseEntity {
    @Column
    private String mediaid;
    @Column
    private String openid;

    //getter & setter

    public String getMediaid() {
        return mediaid;
    }

    public void setMediaid(String mediaid) {
        this.mediaid = mediaid;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }
}
