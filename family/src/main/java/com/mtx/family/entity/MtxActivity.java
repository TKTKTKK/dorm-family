package com.mtx.family.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;


@Table(name = "tb_mtx_activity")
public class MtxActivity extends BaseEntity {
    @Column
    private String merchantid;
    @Column
    private String bindid;
    @Column
    private String name;
    @Column
    private String startdate;
    @Column
    private String enddate;
    @Column
    private String img;
    @Column
    private String detail;
    @Column
    private String status;
    @Column
    private String address;
    @Column
    private String password;
    @Column
    private Integer totalParticipant;
    @Column
    private Integer everyParticipant;

    public Integer getTotalParticipant() {
        return totalParticipant;
    }

    public void setTotalParticipant(Integer totalParticipant) {
        this.totalParticipant = totalParticipant;
    }

    public Integer getEveryParticipant() {
        return everyParticipant;
    }

    public void setEveryParticipant(Integer everyParticipant) {
        this.everyParticipant = everyParticipant;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getMerchantid() {
        return merchantid;
    }

    public void setMerchantid(String merchantid) {
        this.merchantid = merchantid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStartdate() {
        return startdate;
    }

    public void setStartdate(String startdate) {
        this.startdate = startdate;
    }

    public String getEnddate() {
        return enddate;
    }

    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
