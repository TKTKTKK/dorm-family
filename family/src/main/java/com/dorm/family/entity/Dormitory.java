package com.dorm.family.entity;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;


@Table(name = "tb_dorm_dormitory")
public class Dormitory extends BaseEntity {

    @Column
    private String bindid;
    @Column
    private String name;
    @Column
    private String contactno;
    @Column
    private String frequentcontacts;
    @Column
    private String contactsphone;
    @Column
    private String address;
    @Column
    private String logo;
    @Column
    private String type;
    @Column
    private String remarks;
    @Column
    private String electricfence;

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContactno() {
        return contactno;
    }

    public void setContactno(String contactno) {
        this.contactno = contactno;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getElectricfence() {
        return electricfence;
    }

    public void setElectricfence(String electricfence) {
        this.electricfence = electricfence;
    }

    public String getFrequentcontacts() {
        return frequentcontacts;
    }

    public void setFrequentcontacts(String frequentcontacts) {
        this.frequentcontacts = frequentcontacts;
    }

    public String getContactsphone() {
        return contactsphone;
    }

    public void setContactsphone(String contactsphone) {
        this.contactsphone = contactsphone;
    }
}
