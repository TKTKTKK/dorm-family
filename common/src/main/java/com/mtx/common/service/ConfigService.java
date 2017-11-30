package com.mtx.common.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.entity.Config;
import com.mtx.common.mapper.ConfigMapper;
import com.mtx.common.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by wensheng on 14-11-30.
 */
@Service
@Transactional
public class ConfigService extends BaseService<ConfigMapper,Config> {

    @Autowired
    public void setMapper(ConfigMapper mapper) {
        super.setMapper(mapper);
    }
    /**
     * 获取Value为多个值的数组
     * @param configName
     * @param regex
     * @return
     */
    public String[] getValueArray(String configName,String regex){
        Config config = new Config();
        config.setConfigname(configName);
        config = this.queryForObjectByUniqueKey(config);
        String value = config.getConfigvalue();
        return value.split(regex);
    }

    /**
     * 获取所有的配置
     *
     *
     * @param userid
     * @param topAccount
     * @param pageBounds
     * @return
     */
    public PageList<Config> getAllConfig(String userid, Config config, String topAccount, PageBounds pageBounds){
        return this.mapper.getAllConfig(userid, config, topAccount, pageBounds);
    }

    /**
     * 获取所有配置的Value
     * @return
     */
    public List<Config> getAllConfigvalue(Config config){
        return this.mapper.getAllConfigvalue(config);
    }

    /**
     * 根据name删除配置
     * @return
     */
    public int  deleteByName(Config config){
        this.mapper.deleteByName(config);
        return 1;
    }

    /**
     * 查询用户输入的configname的值是否重复
     * @param configname
     * @return
     */
    public Config queryConfigByConfigName(String refid,String configname){
        return this.mapper.queryConfigByConfigName(refid,configname);
    }

    public Config queryConfigByBindidAndName(String bindid,String configname){
        return this.mapper.queryConfigByBindidAndName(bindid,configname);
    }

    public Config getWpCommunityConfigInfo(Config config) {
        config.setBindid(UserUtils.getUserBindId());
        List<Config> configList = queryForList(config);
        if(configList != null && configList.size() > 0){
            return configList.get(0);
        }else{
            return null;
        }
    }
}
