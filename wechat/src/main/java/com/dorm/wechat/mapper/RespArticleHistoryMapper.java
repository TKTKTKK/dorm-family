package com.dorm.wechat.mapper;

import com.dorm.common.base.BaseMapper;
import com.dorm.wechat.entity.admin.RespArticleHistory;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RespArticleHistoryMapper extends BaseMapper<RespArticleHistory> {

    public void batchInsertRespArticleHistory(List<RespArticleHistory> respArticleHistoryList);
}
