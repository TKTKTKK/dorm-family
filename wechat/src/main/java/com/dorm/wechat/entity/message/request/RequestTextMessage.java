package com.dorm.wechat.entity.message.request;

/**
 * 文本消息
 *
 */
public class RequestTextMessage extends BaseRequestMessage {
    // 消息内容
    private String Content;

    public String getContent() {
        return Content;
    }

    public void setContent(String content) {
        Content = content;
    }
}
