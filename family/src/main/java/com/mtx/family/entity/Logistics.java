package com.mtx.family.entity;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by TK on 2017/12/4.
 */
@Table(name = "tb_mtx_logistics")
public class Logistics extends BaseEntity {

    @Column
    private String bindid;
    @Column
    private String orderid;
    @Column
    private String driverphone;
    @Column
    private String location;
    @Column
    private String platenumber;
    @Column
    private double freight;

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }

    public String getDriverphone() {
        return driverphone;
    }

    public void setDriverphone(String driverphone) {
        this.driverphone = driverphone;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPlatenumber() {
        return platenumber;
    }

    public void setPlatenumber(String platenumber) {
        this.platenumber = platenumber;
    }

    public double getFreight() {
        return freight;
    }

    public void setFreight(double freight) {
        this.freight = freight;
    }

}
