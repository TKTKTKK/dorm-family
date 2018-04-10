package com.dorm.wechat.entity.message.request;

/**
 * Created by wensheng on 14-12-7.
 */
public class RequestMenuEventMessage extends RequestEventMessage {

    private String EventKey;

    public String getEventKey() {
        return EventKey;
    }

    public void setEventKey(String eventKey) {
        EventKey = eventKey;
    }
}
