package com.dorm.wechat.mapper;

import com.dorm.wechat.entity.admin.RespArticle;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by wensheng on 12/10/2014.
 */
@Repository
public interface RespArticleMapper extends BaseMapper<RespArticle> {

    public PageList<RespArticle> selectRespArticleList(@Param("respArticle")RespArticle respArticle,PageBounds pageBounds);
}
