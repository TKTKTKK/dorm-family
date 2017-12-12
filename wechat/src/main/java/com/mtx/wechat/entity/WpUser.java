package com.mtx.wechat.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wensheng on 12/26/2014.
 */
@Table(name = "tb_wp_user")
public class WpUser extends BaseEntity{

    @Column
    private String bindid;
    @Column
    private String openid;
    @Column
    private String nickname;
    @Column
    private String headimgurl;
    @Column
    private String name;
    @Column
    private String contactno;
    @Column
    private String type;
    @Column
    private String ifauth;
    @Column
    private String ifsubscribe;

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getHeadimgurl() {
        return headimgurl;
    }

    public void setHeadimgurl(String headimgurl) {
        this.headimgurl = headimgurl;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContactno() {
        return contactno;
    }

    public void setContactno(String contactno) {
        this.contactno = contactno;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getIfauth() {
        return ifauth;
    }

    public void setIfauth(String ifauth) {
        this.ifauth = ifauth;
    }

    public String getIfsubscribe() {
        return ifsubscribe;
    }

    public void setIfsubscribe(String ifsubscribe) {
        this.ifsubscribe = ifsubscribe;
    }
}
