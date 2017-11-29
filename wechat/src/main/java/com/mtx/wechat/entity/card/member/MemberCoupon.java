package com.mtx.wechat.entity.card.member;

import com.mtx.wechat.entity.card.base.Coupon;

/**
 * Created by wensheng on 12/17/2014.
 */
public class MemberCoupon extends Coupon {

    private Boolean supply_bonus;
    private Boolean supply_balance;
    private String bonus_cleared;
    private String bonus_rules;
    private String balance_rules;
    private String prerogative;
    //绑定旧卡的url，与activate_url字段二选一必填
    private String bind_old_card_url;
    //激活会员卡的url，与bind_old_card_url字段二选一必填
    private String activate_url;

    public Boolean getSupply_bonus() {
        return supply_bonus;
    }

    public void setSupply_bonus(Boolean supply_bonus) {
        this.supply_bonus = supply_bonus;
    }

    public Boolean getSupply_balance() {
        return supply_balance;
    }

    public void setSupply_balance(Boolean supply_balance) {
        this.supply_balance = supply_balance;
    }

    public String getBonus_cleared() {
        return bonus_cleared;
    }

    public void setBonus_cleared(String bonus_cleared) {
        this.bonus_cleared = bonus_cleared;
    }

    public String getBonus_rules() {
        return bonus_rules;
    }

    public void setBonus_rules(String bonus_rules) {
        this.bonus_rules = bonus_rules;
    }

    public String getBalance_rules() {
        return balance_rules;
    }

    public void setBalance_rules(String balance_rules) {
        this.balance_rules = balance_rules;
    }

    public String getPrerogative() {
        return prerogative;
    }

    public void setPrerogative(String prerogative) {
        this.prerogative = prerogative;
    }

    public String getBind_old_card_url() {
        return bind_old_card_url;
    }

    public void setBind_old_card_url(String bind_old_card_url) {
        this.bind_old_card_url = bind_old_card_url;
    }

    public String getActivate_url() {
        return activate_url;
    }

    public void setActivate_url(String activate_url) {
        this.activate_url = activate_url;
    }
}
