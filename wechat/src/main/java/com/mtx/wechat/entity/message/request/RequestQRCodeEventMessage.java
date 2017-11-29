package com.mtx.wechat.entity.message.request;

/**
 * Created by wensheng on 14-12-7.
 */
public class RequestQRCodeEventMessage extends RequestEventMessage {

    private String EventKey;
    private String Ticket;

    public String getEventKey() {
        return EventKey;
    }

    public void setEventKey(String eventKey) {
        EventKey = eventKey;
    }

    public String getTicket() {
        return Ticket;
    }

    public void setTicket(String ticket) {
        Ticket = ticket;
    }
}
