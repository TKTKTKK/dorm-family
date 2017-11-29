package com.mtx.wechat.entity.admin;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name = "tb_wechat_binding_dtl")
public class WechatBindingDtl extends BaseEntity {
    @Column
    private String bindid;
    @Column
    private String name;
    @Column
    private String picurl;
    @Column
    private String staffqrcode;

    //getter & setter

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPicurl() {
        return picurl;
    }

    public void setPicurl(String picurl) {
        this.picurl = picurl;
    }

    public String getStaffqrcode() {
        return staffqrcode;
    }

    public void setStaffqrcode(String staffqrcode) {
        this.staffqrcode = staffqrcode;
    }
}
