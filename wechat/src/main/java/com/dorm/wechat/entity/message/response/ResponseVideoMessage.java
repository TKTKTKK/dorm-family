package com.dorm.wechat.entity.message.response;

import com.dorm.wechat.entity.message.Video;

/**
 * Created by wensheng on 14-12-7.
 */
public class ResponseVideoMessage extends BaseResponseMessage {

    private com.dorm.wechat.entity.message.Video Video;

    public Video getVideo() {
        return Video;
    }

    public void setVideo(Video video) {
        Video = video;
    }
}
