package com.dorm.wechat.service;

import com.dorm.wechat.entity.admin.RespArticle;
import com.dorm.wechat.entity.admin.RespNews;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseService;
import com.dorm.wechat.mapper.RespNewsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by wensheng on 14-12-16.
 */
@Service
@Transactional
public class RespNewsService extends BaseService<RespNewsMapper,RespNews> {

    @Autowired
    private RespArticleService respArticleService;

    @Autowired
    public void setMapper(RespNewsMapper mapper) {
        super.setMapper(mapper);
    }

    /**
     * 创建图文消息和第一个article并将图文消息的主键返回
     * @param respNews
     * @param respArticle
     * @return
     */
    public String saveNews(RespNews respNews,RespArticle respArticle){
        insert(respNews);
        respArticle.setNewsid(respNews.getUuid());
        respArticleService.insert(respArticle);
        return respNews.getUuid();
    }

    public PageList<RespNews> queryForListWithPagination(RespNews respNews,PageBounds pageBounds){
        return mapper.selectRespNewsList(respNews, pageBounds);
    }
}
