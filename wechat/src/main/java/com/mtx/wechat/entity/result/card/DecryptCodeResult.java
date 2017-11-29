package com.mtx.wechat.entity.result.card;

import com.mtx.wechat.entity.WechatError;

/**
 * Created by wensheng on 1/28/2015.
 */
public class DecryptCodeResult extends WechatError {
    private String code;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
