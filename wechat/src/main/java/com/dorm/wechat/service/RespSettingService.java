package com.dorm.wechat.service;

import com.dorm.wechat.entity.admin.RespSetting;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseService;
import com.dorm.wechat.mapper.RespSettingMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by wensheng on 12/10/2014.
 */
@Service
@Transactional
public class RespSettingService extends BaseService<RespSettingMapper,RespSetting> {

    @Autowired
    public void setMapper(RespSettingMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<RespSetting> queryForListWithPagination(RespSetting respNews,PageBounds pageBounds){
        return mapper.selectRespSettingList(respNews, pageBounds);
    }

    /**
     * 查询回复配置信息
     * @param respSetting
     * @return
     */
    public RespSetting queryRespSettingInfo(RespSetting respSetting){
        return mapper.selectRespSettingInfo(respSetting);
    }

}
