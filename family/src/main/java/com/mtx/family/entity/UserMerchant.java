package com.mtx.family.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name = "tb_mtx_user_merchant")
public class UserMerchant extends BaseEntity {
    @Column
    private String userid;
    @Column
    private String merchantid;

    //getter & setter
    private String merchantname;

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getMerchantid() {
        return merchantid;
    }

    public void setMerchantid(String merchantid) {
        this.merchantid = merchantid;
    }

    public String getMerchantname() {
        return merchantname;
    }

    public void setMerchantname(String merchantname) {
        this.merchantname = merchantname;
    }
}
