package com.dorm.wechat.entity.message.request;

/**
 * Created by wensheng on 14-12-7.
 */
public class RequestVideoMessage extends BaseRequestMessage {

    //视频媒体ID
    private String MediaId;
    //缩略图媒体ID
    private String ThumbMediaId;

    public String getMediaId() {
        return MediaId;
    }

    public void setMediaId(String mediaId) {
        MediaId = mediaId;
    }

    public String getThumbMediaId() {
        return ThumbMediaId;
    }

    public void setThumbMediaId(String thumbMediaId) {
        ThumbMediaId = thumbMediaId;
    }
}
