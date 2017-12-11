package com.mtx.family.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;


@Table(name = "tb_mtx_point")
public class MtxPoint extends BaseEntity {

    @Column
    private String memberid;
    @Column
    private String productid;
    @Column
    private String goodid;
    @Column
    private String points;

    private String productname;

    private String membername;

    private String phone;

    public String getGoodid() {
        return goodid;
    }

    public void setGoodid(String goodid) {
        this.goodid = goodid;
    }

    public String getProductname() {
        return productname;
    }

    public void setProductname(String productname) {
        this.productname = productname;
    }

    public String getMembername() {
        return membername;
    }

    public void setMembername(String membername) {
        this.membername = membername;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMemberid() {
        return memberid;
    }

    public void setMemberid(String memberid) {
        this.memberid = memberid;
    }

    public String getPoints() {
        return points;
    }

    public void setPoints(String points) {
        this.points = points;
    }

    public String getProductid() {
        return productid;
    }

    public void setProductid(String productid) {
        this.productid = productid;
    }
}
