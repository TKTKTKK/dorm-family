package com.mtx.common.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wensheng on 14-11-30.
 */
@Table(name="tb_common_config")
public class Config extends BaseEntity {

    @Column
    private String bindid;
    @Column
    private String refid;
    @Column
    private String configname;
    @Column
    private String configvalue;
    //协议内容
    private String protocolcontent;
    //小区名称
    private String communityname;

    public String getCommunityname() {
        return communityname;
    }

    public void setCommunityname(String communityname) {
        this.communityname = communityname;
    }

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

    public String getConfigname() {
        return configname;
    }

    public void setConfigname(String configname) {
        this.configname = configname;
    }

    public String getConfigvalue() {
        return configvalue;
    }

    public void setConfigvalue(String configvalue) {
        this.configvalue = configvalue;
    }

    public String getProtocolcontent() {
        return protocolcontent;
    }

    public void setProtocolcontent(String protocolcontent) {
        this.protocolcontent = protocolcontent;
    }
}
