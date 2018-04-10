package com.dorm.wechat.factory;

import com.dorm.wechat.provider.request.RequestMessageProvider;
import com.dorm.wechat.entity.message.request.BaseRequestMessage;

import java.util.Map;

/**
 * Created by wensheng on 14-11-13.
 */
public class RequestMessageFactory {

    private RequestMessageProvider messageProvider;

    public RequestMessageFactory(String providerName) {
        try {
            this.messageProvider =
                    (RequestMessageProvider)Class.forName(providerName).newInstance();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

    }

    public BaseRequestMessage getRequestMessage(Map <String, String> requestMap){
        return messageProvider.provide(requestMap);

    }
}
