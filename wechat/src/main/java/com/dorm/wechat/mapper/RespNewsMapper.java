package com.dorm.wechat.mapper;

import com.dorm.wechat.entity.admin.RespNews;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by wensheng on 14-12-16.
 */
@Repository
public interface RespNewsMapper extends BaseMapper<RespNews> {
    public PageList<RespNews> selectRespNewsList(@Param("respNews")RespNews respNews,PageBounds pageBounds);
}
