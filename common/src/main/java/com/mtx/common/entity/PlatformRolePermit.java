package com.mtx.common.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name="tb_platform_role_permit")
public class PlatformRolePermit extends BaseEntity {
    @Column
    private String roleid;
    @Column
    private String permitid;

    private String rolename;

    private String permitname;

    private String permitnames;

    public String getRoleid() {
        return roleid;
    }

    public void setRoleid(String roleid) {
        this.roleid = roleid;
    }

    public String getPermitid() {
        return permitid;
    }

    public void setPermitid(String permitid) {
        this.permitid = permitid;
    }

    public String getRolename() {return rolename;}

    public void setRolename(String rolename) {this.rolename = rolename;}

    public String getPermitname() {return permitname;}

    public void setPermitname(String permitname) {this.permitname = permitname;}

    public String getPermitnames() {return permitnames;}

    public void setPermitnames(String permitnames) {this.permitnames = permitnames;}
}
