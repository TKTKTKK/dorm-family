package com.mtx.common.utils;

import com.mtx.common.entity.Config;
import com.mtx.common.service.ConfigService;


public class ConfigUtil {

    private static ConfigService configService = ApplicationContextUtil.getBean(ConfigService.class);

    /**
     *
     * @param configName
     * @return
     */
    public static String getConfigByName(String configName){
        Config config = new Config();
        config.setConfigname(configName);
        config = configService.queryForObjectByUniqueKey(config);
        if(config != null){
            return config.getConfigvalue();
        }else{
            return null;
        }
    }

    /**
     *
     * @param configName
     * @return
     */
    public static Config getConfigObjByName(String configName){
        Config config = new Config();
        config.setConfigname(configName);
        return  configService.queryForObjectByUniqueKey(config);
    }

    /**
     *
     * @param configName
     * @return
     */
    public static String getConfigByNameAndBindid(String bindid,String configName){
        Config config = new Config();
        config.setBindid(bindid);
        config.setConfigname(configName);
        config = configService.queryForObjectByUniqueKey(config);
        if(config != null){
            return config.getConfigvalue();
        }else{
            return null;
        }
    }

    /**
     *
     * @param bindid
     * @param refId
     * @param configName
     * @return
     */
    public static String getConfigByRefId(String bindid,String refId,String configName){
        Config config = new Config();
        config.setBindid(bindid);
        config.setRefid(refId);
        config.setConfigname(configName);
        config = configService.queryForObjectByUniqueKey(config);
        if(config != null){
            return config.getConfigvalue();
        }else{
            return null;
        }
    }

    /**
     *
     * @param configName
     * @param configValue
     */
    public static void addConfig(String configName,String configValue){
        Config config = new Config();
        config.setConfigname(configName);
        config.setConfigvalue(configValue);
        configService.insert(config);
    }

    /**
     *
     * @param config
     */
    public static void updateConfig(Config config){
        configService.updatePartial(config);
    }

}
