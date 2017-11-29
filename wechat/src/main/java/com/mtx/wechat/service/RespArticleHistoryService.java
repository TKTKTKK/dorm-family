package com.mtx.wechat.service;

import com.mtx.wechat.mapper.RespArticleHistoryMapper;
import com.mtx.common.base.BaseService;
import com.mtx.common.utils.DateUtils;
import com.mtx.common.utils.StringUtils;
import com.mtx.wechat.entity.admin.RespArticleHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class RespArticleHistoryService extends BaseService<RespArticleHistoryMapper, RespArticleHistory> {
    @Autowired
    public void setMapper(RespArticleHistoryMapper mapper) {
        super.setMapper(mapper);
    }

    /**
     * 保存发送图文历史
     * @param mediaid
     * @param openidList
     */
    public void saveRespArticleHistory(String mediaid, List<String> openidList){
        if(null != openidList && openidList.size() > 0){
            List<RespArticleHistory> articleHistoryList = new ArrayList<RespArticleHistory>();
            for(String openid: openidList){
                RespArticleHistory articleHistory = new RespArticleHistory();
                articleHistory.setMediaid(mediaid);
                articleHistory.setOpenid(openid);

                articleHistory.setUuid(StringUtils.getUUID());
                String dt = DateUtils.formatSystemDateTimeMillis();
                articleHistory.setCreateby("sys");
                articleHistory.setModifyby("sys");
                articleHistory.setCreateon(dt);
                articleHistory.setModifyon(dt);
                articleHistory.setVersionno(1);
                articleHistory.setDelind("N");

                articleHistoryList.add(articleHistory);
            }

            this.mapper.batchInsertRespArticleHistory(articleHistoryList);
        }
    }
}
