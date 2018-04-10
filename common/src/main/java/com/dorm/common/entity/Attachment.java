package com.dorm.common.entity;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name="tb_common_attachment")
public class Attachment extends BaseEntity {
    @Column
    private String refid;
    @Column
    private String name;
    @Column
    private String type;

    public String getRefid() {
        return refid;
    }

    public void setRefid(String refid) {
        this.refid = refid;
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
}
