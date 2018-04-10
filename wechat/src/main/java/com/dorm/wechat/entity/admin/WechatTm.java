package com.dorm.wechat.entity.admin;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wensheng on 15-5-24.
 */
@Table(name = "tb_wechat_tm")
public class WechatTm extends BaseEntity {

    @Column
    private String bindid;
    @Column
    private String tmid;
    @Column
    private String tmtype;
    @Column
    private String tmname;

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getTmid() {
        return tmid;
    }

    public void setTmid(String tmid) {
        this.tmid = tmid;
    }

    public String getTmtype() {
        return tmtype;
    }

    public void setTmtype(String tmtype) {
        this.tmtype = tmtype;
    }

    public String getTmname() {
        return tmname;
    }

    public void setTmname(String tmname) {
        this.tmname = tmname;
    }
}
