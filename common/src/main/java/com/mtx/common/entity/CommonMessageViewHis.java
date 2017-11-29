package com.mtx.common.entity;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name="tb_common_message_view_his")
public class CommonMessageViewHis extends BaseEntity {

    @Column
    private String msgid;
    @Column
    private String openid;
    @Column
    private String upvote;

    public String getMsgid() {
        return msgid;
    }

    public void setMsgid(String msgid) {
        this.msgid = msgid;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getUpvote() {
        return upvote;
    }

    public void setUpvote(String upvote) {
        this.upvote = upvote;
    }
}
