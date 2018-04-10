package com.dorm.common.entity;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wensheng on 14-12-12.
 */
@Table(name="tb_platform_user_role")
public class PlatformUserRole extends BaseEntity {
    @Column
    private String userid;
    @Column
    private String roleid;

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getRoleid() {
        return roleid;
    }

    public void setRoleid(String roleid) {
        this.roleid = roleid;
    }
}
