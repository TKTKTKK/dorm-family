package com.mtx.common.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;
import java.util.List;

/**
 * Created by wensheng on 14-12-12.
 */
@Table(name="tb_platform_role")
public class PlatformRole extends BaseEntity {

    @Column
    private String bindid;
    @Column
    private String rolekey;
    @Column
    private String rolename;

    private String bindroleid;

    private List<PlatformPermit> permitList;

    private String permits;

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getRolekey() {
        return rolekey;
    }

    public void setRolekey(String rolekey) {
        this.rolekey = rolekey;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    public List<PlatformPermit> getPermitList() {return permitList;}

    public void setPermitList(List<PlatformPermit> permitList) {this.permitList = permitList;}

    public String getPermits() {return permits;}

    public void setPermits(String permits) {this.permits = permits;}

    public String getBindroleid() {
        return bindroleid;
    }

    public void setBindroleid(String bindroleid) {
        this.bindroleid = bindroleid;
    }
}
