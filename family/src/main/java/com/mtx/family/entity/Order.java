package com.mtx.family.entity;

import com.mtx.common.base.BaseEntity;
import org.apache.ibatis.annotations.Param;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by TK on 2017/12/4.
 */
@Table(name = "tb_mtx_order")
public class Order extends BaseEntity {

    @Column
    private String bindid;
    @Column
    private String merchantid;
    @Column
    private String snno;
    @Column
    private String machinemodel;
    @Column
    private String quantity;
    @Column
    private String electricstart;
    @Column
    private String rowspace;
    @Column
    private String transversetime;
    @Column
    private String seedlingneedle;
    @Column
    private String entrusttransport;
    @Column
    private String seedlingbasket;
    @Column
    private String coverall;
    @Column
    private String plasticcover;
    @Column
    private String fueltank;
    @Column
    private String merchantremarks;
    @Column
    private String status;
    @Column
    private String remarks;

    //状态数组
    private String[] statusArr;
    //经销商
    private String merchantname;

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getMerchantid() {
        return merchantid;
    }

    public void setMerchantid(String merchantid) {
        this.merchantid = merchantid;
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

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getElectricstart() {
        return electricstart;
    }

    public void setElectricstart(String electricstart) {
        this.electricstart = electricstart;
    }

    public String getRowspace() {
        return rowspace;
    }

    public void setRowspace(String rowspace) {
        this.rowspace = rowspace;
    }

    public String getTransversetime() {
        return transversetime;
    }

    public void setTransversetime(String transversetime) {
        this.transversetime = transversetime;
    }

    public String getSeedlingneedle() {
        return seedlingneedle;
    }

    public void setSeedlingneedle(String seedlingneedle) {
        this.seedlingneedle = seedlingneedle;
    }

    public String getEntrusttransport() {
        return entrusttransport;
    }

    public void setEntrusttransport(String entrusttransport) {
        this.entrusttransport = entrusttransport;
    }

    public String getSeedlingbasket() {
        return seedlingbasket;
    }

    public void setSeedlingbasket(String seedlingbasket) {
        this.seedlingbasket = seedlingbasket;
    }

    public String getCoverall() {
        return coverall;
    }

    public void setCoverall(String coverall) {
        this.coverall = coverall;
    }

    public String getPlasticcover() {
        return plasticcover;
    }

    public void setPlasticcover(String plasticcover) {
        this.plasticcover = plasticcover;
    }

    public String getFueltank() {
        return fueltank;
    }

    public void setFueltank(String fueltank) {
        this.fueltank = fueltank;
    }

    public String getMerchantremarks() {
        return merchantremarks;
    }

    public void setMerchantremarks(String merchantremarks) {
        this.merchantremarks = merchantremarks;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String[] getStatusArr() {
        return statusArr;
    }

    public void setStatusArr(String[] statusArr) {
        this.statusArr = statusArr;
    }

    public String getMerchantname() {
        return merchantname;
    }

    public void setMerchantname(String merchantname) {
        this.merchantname = merchantname;
    }
}
