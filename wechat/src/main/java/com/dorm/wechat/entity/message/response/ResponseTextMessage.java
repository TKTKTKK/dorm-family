package com.dorm.wechat.entity.message.response;

/**
 * 文本消息
 */
public class ResponseTextMessage extends BaseResponseMessage {
    // 回复的消息内容
    private String Content;

    public String getContent() {
        return Content;
    }

    public void setContent(String content) {
        Content = content;
    }
}
