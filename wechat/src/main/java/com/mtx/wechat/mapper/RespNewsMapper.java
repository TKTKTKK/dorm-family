package com.mtx.wechat.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.wechat.entity.admin.RespNews;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by wensheng on 14-12-16.
 */
@Repository
public interface RespNewsMapper extends BaseMapper<RespNews> {
    public PageList<RespNews> selectRespNewsList(@Param("respNews")RespNews respNews,PageBounds pageBounds);
}
