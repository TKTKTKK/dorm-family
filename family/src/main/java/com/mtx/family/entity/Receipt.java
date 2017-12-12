package com.mtx.family.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by TK on 2017/12/4.
 */
@Table(name = "tb_mtx_receipt")
public class Receipt extends BaseEntity {

    @Column
    private String orderid;
    @Column
    private String question;
    @Column
    private String satisfaction;
    @Column
    private String receiptdt;

    public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getSatisfaction() {
        return satisfaction;
    }

    public void setSatisfaction(String satisfaction) {
        this.satisfaction = satisfaction;
    }

    public String getReceiptdt() {
        return receiptdt;
    }

    public void setReceiptdt(String receiptdt) {
        this.receiptdt = receiptdt;
    }


}
