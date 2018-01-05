package com.mtx.family.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by TK on 2017/12/4.
 */
@Table(name = "tb_mtx_quality_management")
public class QualityMgmt extends BaseEntity {

    @Column
    private String snno;
    @Column
    private String machinemodel;
    @Column
    private String engineno;
    @Column
    private String machineno;
    @Column
    private String productiondt;
    @Column
    private String reportlocation;
    @Column
    private String reporter;
    @Column
    private String reportername;
    @Column
    private String reporterphone;
    @Column
    private String type;
    @Column
    private String program;
    @Column
    private String parts;
    @Column
    private Double price;
    @Column
    private String workarea;
    @Column
    private String effect;
    @Column
    private String damagecategory;
    @Column
    private String arrivetime;
    @Column
    private String merchantid;
    @Column
    private String servicedt;
    @Column
    private String evaluate;
    @Column
    private String evaluateremarks;
    @Column
    private String location;
    @Column
    private String status;
    @Column
    private String content;
    @Column
    private String remarks;
    @Column
    private String praisestatus;
    @Column
    private String praiseremarks;

    private String workerid;

    private String merchantname;

    private String worker;

    //状态数组
    private String[] statusArr;

    private String statusDesc;

    private String praisestatusDesc;

    public String getWorkerid() {
        return workerid;
    }

    public void setWorkerid(String workerid) {
        this.workerid = workerid;
    }

    public String getSnno() {
        return snno;
    }

    public void setSnno(String snno) {
        this.snno = snno;
    }

    public String getMachinemodel() {
        return machinemodel;
    }

    public void setMachinemodel(String machinemodel) {
        this.machinemodel = machinemodel;
    }

    public String getEngineno() {
        return engineno;
    }

    public void setEngineno(String engineno) {
        this.engineno = engineno;
    }

    public String getMachineno() {
        return machineno;
    }

    public void setMachineno(String machineno) {
        this.machineno = machineno;
    }

    public String getProductiondt() {
        return productiondt;
    }

    public void setProductiondt(String productiondt) {
        this.productiondt = productiondt;
    }

    public String getReportlocation() {
        return reportlocation;
    }

    public void setReportlocation(String reportlocation) {
        this.reportlocation = reportlocation;
    }

    public String getReporter() {
        return reporter;
    }

    public void setReporter(String reporter) {
        this.reporter = reporter;
    }

    public String getReportername() {
        return reportername;
    }

    public void setReportername(String reportername) {
        this.reportername = reportername;
    }

    public String getReporterphone() {
        return reporterphone;
    }

    public void setReporterphone(String reporterphone) {
        this.reporterphone = reporterphone;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getProgram() {
        return program;
    }

    public void setProgram(String program) {
        this.program = program;
    }

    public String getParts() {
        return parts;
    }

    public void setParts(String parts) {
        this.parts = parts;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getWorkarea() {
        return workarea;
    }

    public void setWorkarea(String workarea) {
        this.workarea = workarea;
    }

    public String getEffect() {
        return effect;
    }

    public void setEffect(String effect) {
        this.effect = effect;
    }

    public String getDamagecategory() {
        return damagecategory;
    }

    public void setDamagecategory(String damagecategory) {
        this.damagecategory = damagecategory;
    }

    public String getArrivetime() {
        return arrivetime;
    }

    public void setArrivetime(String arrivetime) {
        this.arrivetime = arrivetime;
    }

    public String getMerchantid() {
        return merchantid;
    }

    public void setMerchantid(String merchantid) {
        this.merchantid = merchantid;
    }

    public String getServicedt() {
        return servicedt;
    }

    public void setServicedt(String servicedt) {
        this.servicedt = servicedt;
    }

    public String getEvaluate() {
        return evaluate;
    }

    public void setEvaluate(String evaluate) {
        this.evaluate = evaluate;
    }

    public String getEvaluateremarks() {
        return evaluateremarks;
    }

    public void setEvaluateremarks(String evaluateremarks) {
        this.evaluateremarks = evaluateremarks;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public String getMerchantname() {
        return merchantname;
    }

    public void setMerchantname(String merchantname) {
        this.merchantname = merchantname;
    }

    public String getWorker() {
        return worker;
    }

    public void setWorker(String worker) {
        this.worker = worker;
    }

    public String[] getStatusArr() {
        return statusArr;
    }

    public void setStatusArr(String[] statusArr) {
        this.statusArr = statusArr;
    }

    public String getPraisestatus() {
        return praisestatus;
    }

    public void setPraisestatus(String praisestatus) {
        this.praisestatus = praisestatus;
    }

    public String getPraiseremarks() {
        return praiseremarks;
    }

    public void setPraiseremarks(String praiseremarks) {
        this.praiseremarks = praiseremarks;
    }

    public String getStatusDesc() {
        return statusDesc;
    }

    public void setStatusDesc(String statusDesc) {
        this.statusDesc = statusDesc;
    }

    public String getPraisestatusDesc() {
        return praisestatusDesc;
    }

    public void setPraisestatusDesc(String praisestatusDesc) {
        this.praisestatusDesc = praisestatusDesc;
    }
}
