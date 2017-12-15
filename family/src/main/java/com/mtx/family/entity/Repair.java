package com.mtx.family.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by TK on 2017/12/4.
 */
@Table(name = "tb_mtx_repair")
public class Repair extends BaseEntity {

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
    private String reporter;
    @Column
    private String reportername;
    @Column
    private String reporterphone;
    @Column
    private String program;
    @Column
    private String parts;
    @Column
    private Double price;
    @Column
    private Double workarea;
    @Column
    private String effect;
    @Column
    private String damagecategory;
    @Column
    private Integer arrivetime;
    @Column
    private String merchantid;
    @Column
    private String repairdt;
    @Column
    private String evaluate;
    @Column
    private String location;
    @Column
    private String status;
    @Column
    private String content;
    @Column
    private String remarks;


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

    public Double getWorkarea() {
        return workarea;
    }

    public void setWorkarea(Double workarea) {
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

    public Integer getArrivetime() {
        return arrivetime;
    }

    public void setArrivetime(Integer arrivetime) {
        this.arrivetime = arrivetime;
    }

    public String getMerchantid() {
        return merchantid;
    }

    public void setMerchantid(String merchantid) {
        this.merchantid = merchantid;
    }

    public String getRepairdt() {
        return repairdt;
    }

    public void setRepairdt(String repairdt) {
        this.repairdt = repairdt;
    }

    public String getEvaluate() {
        return evaluate;
    }

    public void setEvaluate(String evaluate) {
        this.evaluate = evaluate;
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
}
