package com.mtx.family.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;


@Table(name = "tb_mtx_consult_detail")
public class MtxConsultDetail extends BaseEntity {

    @Column
    private String consultid;
    @Column
    private String content;
    public String getConsultid() {
        return consultid;
    }

    public void setConsultid(String consultid) {
        this.consultid = consultid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

}
