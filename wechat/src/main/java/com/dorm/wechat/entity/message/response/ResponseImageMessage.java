package com.dorm.wechat.entity.message.response;

import com.dorm.wechat.entity.message.Image;

/**
 * Created by wensheng on 14-12-7.
 */
public class ResponseImageMessage extends BaseResponseMessage {

    private com.dorm.wechat.entity.message.Image Image;

    public Image getImage() {
        return Image;
    }

    public void setImage(Image image) {
        Image = image;
    }
}
