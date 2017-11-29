package com.mtx.wechat.entity.message.response;


import com.mtx.wechat.entity.message.Music;

/**
 * 音乐消息
 */
public class ResponseMusicMessage extends BaseResponseMessage {
    // 音乐
    private com.mtx.wechat.entity.message.Music Music;

    public Music getMusic() {
        return Music;
    }

    public void setMusic(Music music) {
        this.Music = music;
    }
}
