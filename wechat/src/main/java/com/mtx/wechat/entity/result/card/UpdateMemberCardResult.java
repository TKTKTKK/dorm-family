package com.mtx.wechat.entity.result.card;

import com.mtx.wechat.entity.WechatError;

/**
 * Created by wensheng on 1/28/2015.
 */
public class UpdateMemberCardResult extends WechatError {

    private Long result_bonus;
    private Long result_balance;
    private String openid;

    public Long getResult_bonus() {
        return result_bonus;
    }

    public void setResult_bonus(Long result_bonus) {
        this.result_bonus = result_bonus;
    }

    public Long getResult_balance() {
        return result_balance;
    }

    public void setResult_balance(Long result_balance) {
        this.result_balance = result_balance;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }
}
