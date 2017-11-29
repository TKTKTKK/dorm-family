package com.mtx.wechat.mapper;

import com.mtx.common.base.BaseMapper;
import com.mtx.wechat.entity.admin.RespArticleHistory;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RespArticleHistoryMapper extends BaseMapper<RespArticleHistory> {

    public void batchInsertRespArticleHistory(List<RespArticleHistory> respArticleHistoryList);
}
