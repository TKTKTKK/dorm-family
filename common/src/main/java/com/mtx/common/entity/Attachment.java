package com.mtx.common.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name="tb_common_attachment")
public class Attachment extends BaseEntity {
    @Column
    private String refid;
    @Column
    private String name;

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
}
