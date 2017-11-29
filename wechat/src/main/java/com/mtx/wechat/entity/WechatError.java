package com.mtx.wechat.entity;

import java.io.Serializable;

/**
 * Created by wensheng on 14-12-8.
 */
public class WechatError implements Serializable{

    private static final long serialVersionUID = 1417412664416197798L;

    private int errcode;
    private String errmsg;

    public int getErrcode() {
        return errcode;
    }

    public void setErrcode(int errcode) {
        this.errcode = errcode;
    }

    public String getErrmsg() {
        return errmsg;
    }

    public void setErrmsg(String errmsg) {
        this.errmsg = errmsg;
    }
}
