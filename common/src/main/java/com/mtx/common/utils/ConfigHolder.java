package com.mtx.common.utils;

public class ConfigHolder {

    private static PropertiesUtil propertiesUtil = new PropertiesUtil("config.properties");

    private static String amyBindid;
    private static String phExpressUrl;
    private static String phExpressTrackUrl;
    private static String phExpressTrackId;
    private static String phExpressTrackPsd;
    private static String phUsername;
    private static String phPassword;
    private static String phAddress;
    private static boolean cacheEnable;

    public static String getAmyBindid() {
        return amyBindid;
    }

    public void setAmyBindid(String amyBindid) {
        ConfigHolder.amyBindid = amyBindid;
    }

    public static String getConfigValue(String key) {

        return propertiesUtil.getProperty(key);
    }

    public static String getPhExpressUrl() {
        return phExpressUrl;
    }

    public void setPhExpressUrl(String phExpressUrl) {
        ConfigHolder.phExpressUrl = phExpressUrl;
    }

    public static String getPhExpressTrackUrl() {
        return phExpressTrackUrl;
    }

    public void setPhExpressTrackUrl(String phExpressTrackUrl) {
        ConfigHolder.phExpressTrackUrl = phExpressTrackUrl;
    }

    public static String getPhExpressTrackId() {
        return phExpressTrackId;
    }

    public void setPhExpressTrackId(String phExpressTrackId) {
        ConfigHolder.phExpressTrackId = phExpressTrackId;
    }

    public static String getPhExpressTrackPsd() {
        return phExpressTrackPsd;
    }

    public void setPhExpressTrackPsd(String phExpressTrackPsd) {
        ConfigHolder.phExpressTrackPsd = phExpressTrackPsd;
    }

    public static String getPhUsername() {
        return phUsername;
    }

    public void setPhUsername(String phUsername) {
        ConfigHolder.phUsername = phUsername;
    }

    public static String getPhPassword() {
        return phPassword;
    }

    public void setPhPassword(String phPassword) {
        ConfigHolder.phPassword = phPassword;
    }

    public static String getPhAddress() {
        return phAddress;
    }

    public void setPhAddress(String phAddress) {
        ConfigHolder.phAddress = phAddress;
    }

    /**
     * 第三方用户唯一凭证
     * @return
     */
    public static String getAppId(){
        return ConfigHolder.getConfigValue("appId");
    }

    /**
     * 第三方用户唯一凭证密钥
     * @return
     */
    public static String getAppSecret(){
        return ConfigHolder.getConfigValue("appSecret");
    }

    /**
     * 查询前台特殊的bindid
     * @return
     */
    public static String getFrontSpecialBindid(){
        return amyBindid;
    }

    public void setCacheEnable(String cacheEnable) {
        ConfigHolder.cacheEnable = Boolean.parseBoolean(cacheEnable);
    }

    public static boolean isCacheEnable(){
        return ConfigHolder.cacheEnable;
    }
}
