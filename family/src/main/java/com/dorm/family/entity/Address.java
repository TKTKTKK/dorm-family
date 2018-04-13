package com.dorm.family.entity;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;


@Table(name = "tb_dorm_address")
public class Address extends BaseEntity {

    @Column
    private String dormitoryid;
    @Column
    private String layer;
    @Column
    private String roomno;
    @Column
    private double area;

    public String getDormitoryid() {
        return dormitoryid;
    }

    public void setDormitoryid(String dormitoryid) {
        this.dormitoryid = dormitoryid;
    }

    public String getLayer() {
        return layer;
    }

    public void setLayer(String layer) {
        this.layer = layer;
    }

    public String getRoomno() {
        return roomno;
    }

    public void setRoomno(String roomno) {
        this.roomno = roomno;
    }

    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }
}
