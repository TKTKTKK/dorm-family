package com.mtx.wechat.entity.param.card;

/**
 * Created by wensheng on 1/28/2015.
 */
public class ActivateMemberCard {
    private Long init_bonus;
    private Long init_balance;
    private String membership_number;
    private String code;
    private String card_id;
    private String bonus_url;
    private String balance_url;

    public Long getInit_bonus() {
        return init_bonus;
    }

    public void setInit_bonus(Long init_bonus) {
        this.init_bonus = init_bonus;
    }

    public Long getInit_balance() {
        return init_balance;
    }

    public void setInit_balance(Long init_balance) {
        this.init_balance = init_balance;
    }

    public String getMembership_number() {
        return membership_number;
    }

    public void setMembership_number(String membership_number) {
        this.membership_number = membership_number;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCard_id() {
        return card_id;
    }

    public void setCard_id(String card_id) {
        this.card_id = card_id;
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
