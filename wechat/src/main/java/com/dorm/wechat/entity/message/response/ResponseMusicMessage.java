package com.dorm.wechat.entity.message.response;


import com.dorm.wechat.entity.message.Music;

/**
 * 音乐消息
 */
public class ResponseMusicMessage extends BaseResponseMessage {
    // 音乐
    private com.dorm.wechat.entity.message.Music Music;

    public Music getMusic() {
        return Music;
    }

    public void setMusic(Music music) {
        this.Music = music;
    }
}
