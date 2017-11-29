package com.mtx.wechat.factory;

import com.mtx.wechat.processor.RequestMessageProcessor;

/**
 * Created by wensheng on 14-11-15.
 */
public class RequestMessageProcessorFactory {

    private RequestMessageProcessor processor;

    public RequestMessageProcessorFactory(String processorName) {
        try {
            this.processor =
                    (RequestMessageProcessor)Class.forName(processorName).newInstance();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public RequestMessageProcessor getProcessor(){
        return this.processor;
    }
}
