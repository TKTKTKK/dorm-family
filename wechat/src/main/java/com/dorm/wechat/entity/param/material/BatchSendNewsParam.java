package com.dorm.wechat.entity.param.material;

import java.util.List;

/**
 * Created by wensheng on 2015/12/28.
 */
public class BatchSendNewsParam {
    private List<String> touser;
    private String msgtype = "mpnews";
    private Media mpnews;

    public List<String> getTouser() {
        return touser;
    }

    public void setTouser(List<String> touser) {
        this.touser = touser;
    }

    public String getMsgtype() {
        return msgtype;
    }

    public void setMsgtype(String msgtype) {
        this.msgtype = msgtype;
    }

    public Media getMpnews() {
        return mpnews;
    }

    public void setMpnews(Media mpnews) {
        this.mpnews = mpnews;
    }
}
