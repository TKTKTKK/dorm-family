package com.dorm.family.entity;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;


@Table(name = "tb_dorm_repair")
public class Repair extends BaseEntity {

    @Column
    private String bindid;
    @Column
    private String snno;
    @Column
    private String dormitoryid;
    @Column
    private String layer;
    @Column
    private String roomno;
    @Column
    private String type;
    @Column
    private String reporter;
    @Column
    private String reporterstuno;
    @Column
    private String reportername;
    @Column
    private String reporterphone;
    @Column
    private String worker;
    @Column
    private String servicedt;
    @Column
    private String repairdt;
    @Column
    private String status;
    @Column
    private String content;
    @Column
    private String remarks;
    @Column
    private Double price;

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getSnno() {
        return snno;
    }

    public void setSnno(String snno) {
        this.snno = snno;
    }

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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getReporter() {
        return reporter;
    }

    public void setReporter(String reporter) {
        this.reporter = reporter;
    }

    public String getReporterphone() {
        return reporterphone;
    }

    public void setReporterphone(String reporterphone) {
        this.reporterphone = reporterphone;
    }

    public String getServicedt() {
        return servicedt;
    }

    public void setServicedt(String servicedt) {
        this.servicedt = servicedt;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getReporterstuno() {
        return reporterstuno;
    }

    public void setReporterstuno(String reporterstuno) {
        this.reporterstuno = reporterstuno;
    }

    public String getReportername() {
        return reportername;
    }

    public void setReportername(String reportername) {
        this.reportername = reportername;
    }

    public String getWorker() {
        return worker;
    }

    public void setWorker(String worker) {
        this.worker = worker;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRepairdt() {
        return repairdt;
    }

    public void setRepairdt(String repairdt) {
        this.repairdt = repairdt;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
