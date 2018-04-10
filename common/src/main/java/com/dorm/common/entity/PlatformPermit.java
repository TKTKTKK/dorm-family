package com.dorm.common.entity;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.List;

@Table(name="tb_platform_permit")
public class PlatformPermit extends BaseEntity {
    @Column
    private String permittype;
    @Column
    private String permitname;
    @Column
    private String permitresource;
    @Column
    private String parentpermitid;
    @Column
    private Integer permitorder;
    @Column
    private String status;
    @Column
    private String menuicon;

    private String parentpermitname;
    //子结点
    List<PlatformPermit> childPermits = new ArrayList<PlatformPermit>();

    public String getPermittype() {
        return permittype;
    }

    public void setPermittype(String permittype) {
        this.permittype = permittype;
    }

    public String getPermitname() {
        return permitname;
    }

    public void setPermitname(String permitname) {
        this.permitname = permitname;
    }

    public String getPermitresource() {
        return permitresource;
    }

    public void setPermitresource(String permitresource) {
        this.permitresource = permitresource;
    }

    public String getParentpermitid() {
        return parentpermitid;
    }

    public void setParentpermitid(String parentpermitid) {
        this.parentpermitid = parentpermitid;
    }

    public int getPermitorder() {
        return permitorder;
    }

    public void setPermitorder(Integer permitorder) {
        this.permitorder = permitorder;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<PlatformPermit> getChildPermits() {
        return childPermits;
    }

    public void setChildPermits(List<PlatformPermit> childPermits) {
        this.childPermits = childPermits;
    }

    public String getMenuicon() {
        return menuicon;
    }

    public void setMenuicon(String menuicon) {
        this.menuicon = menuicon;
    }

    public String getParentpermitname() {return parentpermitname;}

    public void setParentpermitname(String parentpermitname) {this.parentpermitname = parentpermitname;}
}
