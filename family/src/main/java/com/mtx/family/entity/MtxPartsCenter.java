package com.mtx.family.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;


@Table(name = "tb_mtx_parts")
public class MtxPartsCenter extends BaseEntity {
    @Column
    private String name;
    @Column
    private String material_code;
    @Column
    private Double price;
    @Column
    private String fitmodel;
    @Column
    private String address;
    @Column
    private String status;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMaterial_code() {
        return material_code;
    }

    public void setMaterial_code(String material_code) {
        this.material_code = material_code;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getFitmodel() {
        return fitmodel;
    }

    public void setFitmodel(String fitmodel) {
        this.fitmodel = fitmodel;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
