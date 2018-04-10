package com.dorm.wechat.entity.param.custom;

/**
 * Created by wensheng on 2016/1/5.
 */
public class CustomTextMsg {

    public CustomTextMsg() {
    }

    public CustomTextMsg(String touser, String textText) {
        this.touser = touser;
        this.msgtype = "text";
        CustomText customText = new CustomText();
        customText.setContent(textText);
        this.text = customText;
    }

    private String touser;
    private String msgtype;
    private CustomText text;

    public String getMsgtype() {
        return msgtype;
    }

    public void setMsgtype(String msgtype) {
        this.msgtype = msgtype;
    }

    public CustomText getText() {
        return text;
    }

    public void setText(CustomText text) {
        this.text = text;
    }
}
