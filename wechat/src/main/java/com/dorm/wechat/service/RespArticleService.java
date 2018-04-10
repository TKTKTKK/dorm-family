package com.dorm.wechat.service;

import com.dorm.wechat.entity.admin.RespArticle;
import com.dorm.wechat.mapper.RespArticleMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by wensheng on 12/10/2014.
 */
@Service
@Transactional
public class RespArticleService extends BaseService<RespArticleMapper,RespArticle> {
    @Autowired
    public void setMapper(RespArticleMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<RespArticle> queryForListWithPagination(RespArticle respArticle,PageBounds pageBounds){
        return mapper.selectRespArticleList(respArticle, pageBounds);
    }
}
