package com.mtx.family.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;


@Table(name = "tb_mtx_member")
public class MtxMember extends BaseEntity {

    @Column
    private String merchantid;
    @Column
    private String name;
    @Column
    private String phone;
    @Column
    private String province;
    @Column
    private String city;
    @Column
    private String district;
    @Column
    private String address;
    @Column
    private String wechatname;
    @Column
    private String wechatimg;
    @Column
    private Double points;

    private String merchantname;

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMerchantid() {
        return merchantid;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getWechatimg() {
        return wechatimg;
    }

    public void setWechatimg(String wechatimg) {
        this.wechatimg = wechatimg;
    }

    public Double getPoints() {
        return points;
    }

    public void setPoints(Double points) {
        this.points = points;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getWechatname() {
        return wechatname;
    }

    public void setWechatname(String wechatname) {
        this.wechatname = wechatname;
    }

    public String getMerchantname() {
        return merchantname;
    }

    public void setMerchantname(String merchantname) {
        this.merchantname = merchantname;
    }
}
