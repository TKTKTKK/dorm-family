package com.mtx.common;

import java.io.Serializable;

/**
 * Created by wensheng on 14-12-8.
 */
public class OpenApiResult implements Serializable{

    private static final long serialVersionUID = 1417412334416197798L;

    private Integer errcode;
    private String errmsg;

    public Integer getErrcode() {
        return errcode;
    }

    public void setErrcode(Integer errcode) {
        this.errcode = errcode;
    }

    public String getErrmsg() {
        return errmsg;
    }

    public void setErrmsg(String errmsg) {
        this.errmsg = errmsg;
    }
}
