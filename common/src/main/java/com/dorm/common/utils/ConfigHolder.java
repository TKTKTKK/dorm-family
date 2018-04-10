package com.dorm.common.utils;

public class ConfigHolder {

    private static PropertiesUtil propertiesUtil = new PropertiesUtil("config.properties");


    public static String getConfigValue(String key) {

        return propertiesUtil.getProperty(key);
    }
}
