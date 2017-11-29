package com.mtx.wechat.service;

import com.mtx.wechat.entity.admin.RespArticle;
import com.mtx.wechat.mapper.RespArticleMapper;
import com.mtx.common.base.BaseService;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
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
