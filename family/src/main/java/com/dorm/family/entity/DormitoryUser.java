package com.dorm.family.entity;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name = "tb_dorm_dormitory_user")
public class DormitoryUser extends BaseEntity {
    @Column
    private String userid;
    @Column
    private String dormitoryid;

    //getter & setter
    private String dormitoryname;

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getDormitoryid() {
        return dormitoryid;
    }

    public void setDormitoryid(String dormitoryid) {
        this.dormitoryid = dormitoryid;
    }

    public String getDormitoryname() {
        return dormitoryname;
    }

    public void setDormitoryname(String dormitoryname) {
        this.dormitoryname = dormitoryname;
    }
}
