package com.mtx.family.entity;

import com.mtx.common.base.BaseEntity;
import javax.persistence.Column;
import javax.persistence.Table;


@Table(name = "tb_mtx_product")
public class MtxProduct extends BaseEntity {

    @Column
    private String model;
    @Column
    private String name;
    @Column
    private String img;
    @Column
    private String status;
    @Column
    private Double price;
    @Column
    private String detail;
    @Column
    private Integer points;
    @Column
    private String type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getPoints() {
        return points;
    }

    public void setPoints(Integer points) {
        this.points = points;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
