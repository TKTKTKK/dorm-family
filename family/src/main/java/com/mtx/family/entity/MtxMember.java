package com.mtx.family.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;


@Table(name = "tb_wp_user")
public class MtxMember extends BaseEntity {

    @Column
    private String bindid;
    @Column
    private String openid;
    @Column
    private String name;
    @Column
    private String contactno;
    @Column
    private String province;
    @Column
    private String city;
    @Column
    private String district;
    @Column
    private String address;
    @Column
    private String nickname;
    @Column
    private String headimgurl;
    @Column
    private Integer points;
    @Column
    private String type;//用户的类型是普通用户，还是经销商还是。。。。
    @Column
    private String ifsubscribe;//是否关注
    @Column
    private String ifauth;//是否是会员

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContactno() {
        return contactno;
    }

    public void setContactno(String contactno) {
        this.contactno = contactno;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getHeadimgurl() {
        return headimgurl;
    }

    public void setHeadimgurl(String headimgurl) {
        this.headimgurl = headimgurl;
    }

    public Integer getPoints() {
        return points;
    }

    public void setPoints(Integer points) {
        this.points = points;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getIfsubscribe() {
        return ifsubscribe;
    }

    public void setIfsubscribe(String ifsubscribe) {
        this.ifsubscribe = ifsubscribe;
    }

    public String getIfauth() {
        return ifauth;
    }

    public void setIfauth(String ifauth) {
        this.ifauth = ifauth;
    }

}
