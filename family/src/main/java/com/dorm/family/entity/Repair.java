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

    //状态数组
    private String[] statusArr;

    private String statusDesc;

    private String dormitoryname;

    private String workername;



    private String countByStudent;

    private String countByDormitoryManage;

    private String newCount;

    private String repairingCount;

    private String finishCount;

    private String newPercent;

    private String repairingPercent;

    private String finishPercent;

    private String totalMoney;




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

    public String[] getStatusArr() {
        return statusArr;
    }

    public void setStatusArr(String[] statusArr) {
        this.statusArr = statusArr;
    }

    public String getStatusDesc() {
        return statusDesc;
    }

    public void setStatusDesc(String statusDesc) {
        this.statusDesc = statusDesc;
    }

    public String getDormitoryname() {
        return dormitoryname;
    }

    public void setDormitoryname(String dormitoryname) {
        this.dormitoryname = dormitoryname;
    }

    public String getWorkername() {
        return workername;
    }

    public void setWorkername(String workername) {
        this.workername = workername;
    }

    public String getCountByStudent() {
        return countByStudent;
    }

    public void setCountByStudent(String countByStudent) {
        this.countByStudent = countByStudent;
    }

    public String getCountByDormitoryManage() {
        return countByDormitoryManage;
    }

    public void setCountByDormitoryManage(String countByDormitoryManage) {
        this.countByDormitoryManage = countByDormitoryManage;
    }

    public String getNewCount() {
        return newCount;
    }

    public void setNewCount(String newCount) {
        this.newCount = newCount;
    }

    public String getRepairingCount() {
        return repairingCount;
    }

    public void setRepairingCount(String repairingCount) {
        this.repairingCount = repairingCount;
    }

    public String getFinishCount() {
        return finishCount;
    }

    public void setFinishCount(String finishCount) {
        this.finishCount = finishCount;
    }

    public String getNewPercent() {
        return newPercent;
    }

    public void setNewPercent(String newPercent) {
        this.newPercent = newPercent;
    }

    public String getRepairingPercent() {
        return repairingPercent;
    }

    public void setRepairingPercent(String repairingPercent) {
        this.repairingPercent = repairingPercent;
    }

    public String getFinishPercent() {
        return finishPercent;
    }

    public void setFinishPercent(String finishPercent) {
        this.finishPercent = finishPercent;
    }

    public String getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(String totalMoney) {
        this.totalMoney = totalMoney;
    }
}
