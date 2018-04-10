package com.dorm.common.audit;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name="tb_common_audit_log")
public class AuditLog extends BaseEntity {

    @Column
    private String action;
    @Column
    private String entityid;
    @Column
    private String entityname;
    @Column
    private String detail;

    //创建人名称
    private String createbyname;

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getEntityid() {
        return entityid;
    }

    public void setEntityid(String entityid) {
        this.entityid = entityid;
    }

    public String getEntityname() {
        return entityname;
    }

    public void setEntityname(String entityname) {
        this.entityname = entityname;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getCreatebyname() {
        return createbyname;
    }

    public void setCreatebyname(String createbyname) {
        this.createbyname = createbyname;
    }
}
