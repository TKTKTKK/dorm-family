package com.mtx.wechat.entity.message.response;

import com.mtx.wechat.entity.message.Voice;

/**
 * Created by wensheng on 14-12-7.
 */
public class ResponseVoiceMessage extends BaseResponseMessage {

    private Voice Voice;

    public Voice getVoice() {
        return Voice;
    }

    public void setVoice(Voice voice) {
        Voice = voice;
    }
}
