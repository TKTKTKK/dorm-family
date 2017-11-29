package com.mtx.wechat.entity.card.color;

import java.util.List;

/**
 * Created by wensheng on 14-12-18.
 */
public class Colors {

    private int errcode;
    private String errmsg;
    private List<Color> colors;

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

    public List<Color> getColors() {
        return colors;
    }

    public void setColors(List<Color> colors) {
        this.colors = colors;
    }
}
