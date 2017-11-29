package com.mtx.wechat.entity.param.card;

/**
 * Created by wensheng on 1/28/2015.
 */
public class UpdateMemberCard {
    private String code;
    private Long add_bonus;
    private String record_bonus;
    private Long add_balance;
    private String record_balance;
    private String card_id;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Long getAdd_bonus() {
        return add_bonus;
    }

    public void setAdd_bonus(Long add_bonus) {
        this.add_bonus = add_bonus;
    }

    public String getRecord_bonus() {
        return record_bonus;
    }

    public void setRecord_bonus(String record_bonus) {
        this.record_bonus = record_bonus;
    }

    public Long getAdd_balance() {
        return add_balance;
    }

    public void setAdd_balance(Long add_balance) {
        this.add_balance = add_balance;
    }

    public String getRecord_balance() {
        return record_balance;
    }

    public void setRecord_balance(String record_balance) {
        this.record_balance = record_balance;
    }

    public String getCard_id() {
        return card_id;
    }

    public void setCard_id(String card_id) {
        this.card_id = card_id;
    }
}
