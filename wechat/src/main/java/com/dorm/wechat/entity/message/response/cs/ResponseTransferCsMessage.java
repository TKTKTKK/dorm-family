package com.dorm.wechat.entity.message.response.cs;

import com.dorm.wechat.entity.message.response.BaseResponseMessage;

/**
 * Created by wensheng on 15-4-2.
 */
public class ResponseTransferCsMessage extends BaseResponseMessage {
    private TransInfo TransInfo;

    public TransInfo getTransInfo() {
        return TransInfo;
    }

    public void setTransInfo(TransInfo transInfo) {
        TransInfo = transInfo;
    }
}
