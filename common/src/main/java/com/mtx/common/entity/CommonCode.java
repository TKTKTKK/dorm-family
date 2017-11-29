package com.mtx.common.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wensheng on 1/19/2015.
 */
@Table(name = "tb_common_code")
public class CommonCode extends BaseEntity {

    @Column
    private String bindid;
    @Column
    private String refid;
    @Column
    private String codetype;
    @Column
    private String code;
    @Column
    private String codevalue;
    @Column
    private String extvalue;
    @Column
    private String childcodetype;
    @Column
    private Integer orderno;

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getRefid() {
        return refid;
    }

    public void setRefid(String refid) {
        this.refid = refid;
    }

    public String getCodetype() {
        return codetype;
    }

    public void setCodetype(String codetype) {
        this.codetype = codetype;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCodevalue() {
        return codevalue;
    }

    public void setCodevalue(String codevalue) {
        this.codevalue = codevalue;
    }

    public String getExtvalue() {
        return extvalue;
    }

    public void setExtvalue(String extvalue) {
        this.extvalue = extvalue;
    }

    public String getChildcodetype() {
        return childcodetype;
    }

    public void setChildcodetype(String childcodetype) {
        this.childcodetype = childcodetype;
    }

    public Integer getOrderno() {
        return orderno;
    }

    public void setOrderno(Integer orderno) {
        this.orderno = orderno;
    }
}
