package com.mtx.wechat.provider.request;

import com.mtx.wechat.entity.message.request.BaseRequestMessage;

import java.util.Map;

/**
 *      获得请求消息
 *      Created by wensheng on 14-11-13.
 */
public interface RequestMessageProvider {

    public BaseRequestMessage provide(Map<String, String> requestMap);

}
