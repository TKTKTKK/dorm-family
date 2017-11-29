package com.mtx.wechat.entity.admin;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wensheng on 1/28/2015.
 */
@Table(name = "tb_wechat_membership")
public class WechatMemberShip extends BaseEntity {
    @Column
    private String codeid;
    @Column
    private String membershipno;
    @Column
    private String openid;
    @Column
    private String name;
    @Column
    private String cellphone;
    @Column
    private String email;
    @Column
    private String address;
    @Column
    private Long bonus;
    @Column
    private Long balance;
    @Column
    private String bonus_url;
    @Column
    private String balance_url;

    public String getCodeid() {
        return codeid;
    }

    public void setCodeid(String codeid) {
        this.codeid = codeid;
    }

    public String getMembershipno() {
        return membershipno;
    }

    public void setMembershipno(String membershipno) {
        this.membershipno = membershipno;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCellphone() {
        return cellphone;
    }

    public void setCellphone(String cellphone) {
        this.cellphone = cellphone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Long getBonus() {
        return bonus;
    }

    public void setBonus(Long bonus) {
        this.bonus = bonus;
    }

    public Long getBalance() {
        return balance;
    }

    public void setBalance(Long balance) {
        this.balance = balance;
    }

    public String getBonus_url() {
        return bonus_url;
    }

    public void setBonus_url(String bonus_url) {
        this.bonus_url = bonus_url;
    }

    public String getBalance_url() {
        return balance_url;
    }

    public void setBalance_url(String balance_url) {
        this.balance_url = balance_url;
    }
}
