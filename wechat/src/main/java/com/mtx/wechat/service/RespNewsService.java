package com.mtx.wechat.service;

import com.mtx.wechat.entity.admin.RespArticle;
import com.mtx.wechat.entity.admin.RespNews;
import com.mtx.common.base.BaseService;
import com.mtx.wechat.mapper.RespNewsMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
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
