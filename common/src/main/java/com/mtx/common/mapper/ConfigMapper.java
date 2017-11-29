package com.mtx.common.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.common.entity.Config;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wensheng on 14-11-30.
 */
@Repository
public interface ConfigMapper extends BaseMapper<Config> {
    public PageList<Config> getAllConfig(@Param("userid") String userid, @Param("config") Config config, @Param("topAccount") String topAccount, PageBounds pageBounds);
    public List<Config> getAllConfigvalue(@Param("config")Config config);
    public void deleteByName(@Param("config")Config config);
    public Config queryConfigByConfigName(@Param("refid")String refid,@Param("configname") String configname);
}
