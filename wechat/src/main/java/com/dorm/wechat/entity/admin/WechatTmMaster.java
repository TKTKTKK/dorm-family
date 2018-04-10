package com.dorm.wechat.entity.admin;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name = "tb_wechat_tm_master")
public class WechatTmMaster extends BaseEntity {
    @Column
    private String tmidshort;
    @Column
    private String tmname;

    //getter & setter
    public String getTmidshort() {
        return tmidshort;
    }

    public void setTmidshort(String tmidshort) {
        this.tmidshort = tmidshort;
    }

    public String getTmname() {
        return tmname;
    }

    public void setTmname(String tmname) {
        this.tmname = tmname;
    }
}
