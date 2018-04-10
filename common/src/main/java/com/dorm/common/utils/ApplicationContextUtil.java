package com.dorm.common.utils;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class ApplicationContextUtil implements ApplicationContextAware {

    private static ApplicationContext applicationContext;

    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        ApplicationContextUtil.applicationContext = applicationContext;
    }

    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }

    public static Object getBean(String beanName){
        if (applicationContext == null){
            return null;
        }else {
            return applicationContext.getBean(beanName);
        }
    }

    public static <T> T getBean(Class<T> clazz){
        if (applicationContext == null){
            return null;
        }else {
            return applicationContext.getBean(clazz);
        }
    }
}
