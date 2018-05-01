package com.dorm.family.entity;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;


@Table(name = "tb_dorm_consult")
public class Consult extends BaseEntity {

    @Column
    private String stuid;
    @Column
    private String detail;
    @Column
    private String reply;
    @Column
    private String status;

    private String dormitoryid;

    private String dormitoryname;

    private String stuno;

    private String stuname;

    private String stuphone;

    private String nreplyCount;

    private String yreplyCount;

    private String nreplyPercent;

    private String yreplyPercent;

    public String getStuid() {
        return stuid;
    }

    public void setStuid(String stuid) {
        this.stuid = stuid;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDormitoryid() {
        return dormitoryid;
    }

    public void setDormitoryid(String dormitoryid) {
        this.dormitoryid = dormitoryid;
    }

    public String getStuno() {
        return stuno;
    }

    public void setStuno(String stuno) {
        this.stuno = stuno;
    }

    public String getStuname() {
        return stuname;
    }

    public void setStuname(String stuname) {
        this.stuname = stuname;
    }

    public String getDormitoryname() {
        return dormitoryname;
    }

    public void setDormitoryname(String dormitoryname) {
        this.dormitoryname = dormitoryname;
    }

    public String getStuphone() {
        return stuphone;
    }

    public void setStuphone(String stuphone) {
        this.stuphone = stuphone;
    }

    public String getNreplyCount() {
        return nreplyCount;
    }

    public void setNreplyCount(String nreplyCount) {
        this.nreplyCount = nreplyCount;
    }

    public String getYreplyCount() {
        return yreplyCount;
    }

    public void setYreplyCount(String yreplyCount) {
        this.yreplyCount = yreplyCount;
    }

    public String getNreplyPercent() {
        return nreplyPercent;
    }

    public void setNreplyPercent(String nreplyPercent) {
        this.nreplyPercent = nreplyPercent;
    }

    public String getYreplyPercent() {
        return yreplyPercent;
    }

    public void setYreplyPercent(String yreplyPercent) {
        this.yreplyPercent = yreplyPercent;
    }
}
