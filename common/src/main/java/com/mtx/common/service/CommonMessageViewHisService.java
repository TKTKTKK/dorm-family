package com.mtx.common.service;

import com.mtx.common.mapper.CommonMessageViewHisMapper;
import com.mtx.common.base.BaseService;
import com.mtx.common.entity.CommonMessageViewHis;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CommonMessageViewHisService extends BaseService<CommonMessageViewHisMapper,CommonMessageViewHis> {
    @Autowired
    public void setMapper(CommonMessageViewHisMapper mapper) {
        super.setMapper(mapper);
    }

    public int queryMsgViewCount(String msgId){

        return this.mapper.selectMsgViewCount(msgId);

    }

    /**
     * 记录用户点击阅读消息，并返该消息的总阅读数
     * @param msgId
     * @param openid
     */
    public int viewMessage(String msgId,String openid){
        CommonMessageViewHis commonMessageViewHis = new CommonMessageViewHis();
        commonMessageViewHis.setMsgid(msgId);
        commonMessageViewHis.setOpenid(openid);
        List<CommonMessageViewHis> viewHisList = this.mapper.select(commonMessageViewHis);

        if(viewHisList == null || viewHisList.size() == 0){
            this.mapper.insert(commonMessageViewHis);
        }
        return this.mapper.selectMsgViewCount(msgId);
    }
}
