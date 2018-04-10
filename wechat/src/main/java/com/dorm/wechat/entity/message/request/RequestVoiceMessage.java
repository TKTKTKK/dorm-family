package com.dorm.wechat.entity.message.request;

/**
 * 音频消息
 */
public class RequestVoiceMessage extends BaseRequestMessage {
    // 媒体ID
    private String MediaId;
    // 语音格式
    private String Format;
    //语音识别结果
    private String Recognition;

    public String getMediaId() {
        return MediaId;
    }

    public void setMediaId(String mediaId) {
        MediaId = mediaId;
    }

    public String getFormat() {
        return Format;
    }

    public void setFormat(String format) {
        Format = format;
    }

    public String getRecognition() {
        return Recognition;
    }

    public void setRecognition(String recognition) {
        Recognition = recognition;
    }
}

