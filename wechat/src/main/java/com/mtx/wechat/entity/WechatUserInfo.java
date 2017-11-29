package com.mtx.wechat.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name = "tb_wechat_userinfo")
public class WechatUserInfo extends BaseEntity {
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
    private String type;
    @Column
    private String contactno;
    @Column
    private String companyid;
    @Column
    private String remarks;

    //序号
    private Integer rownum;
    //是否关注
    private String ifsubscribe;
    //是否创建账号
    private boolean createAccountFlag;

    //getter & setter


    public String getIfsubscribe() {
        return ifsubscribe;
    }

    public void setIfsubscribe(String ifsubscribe) {
        this.ifsubscribe = ifsubscribe;
    }

    public boolean isCreateAccountFlag() {
        return createAccountFlag;
    }

    public void setCreateAccountFlag(boolean createAccountFlag) {
        this.createAccountFlag = createAccountFlag;
    }

    public Integer getRownum() {
        return rownum;
    }

    public void setRownum(Integer rownum) {
        this.rownum = rownum;
    }

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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getContactno() {
        return contactno;
    }

    public void setContactno(String contactno) {
        this.contactno = contactno;
    }

    public String getCompanyid() {
        return companyid;
    }

    public void setCompanyid(String companyid) {
        this.companyid = companyid;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
