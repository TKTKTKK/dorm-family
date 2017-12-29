package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxActivity;
import com.mtx.family.entity.MtxActivityParticipant;
import com.mtx.family.entity.MtxLuckyParticipant;
import com.mtx.family.mapper.MtxActivityParticipantMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxActivityParticipantService extends BaseService<MtxActivityParticipantMapper,MtxActivityParticipant> {

    @Autowired
    public void setMapper(MtxActivityParticipantMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxActivityParticipant> queryForListWithPagination(MtxActivityParticipant obj, PageBounds pageBounds) {
        return mapper.selectMtxActivityParticipantList(obj,pageBounds);
    }

    public List<MtxActivityParticipant> queryForParticipantList(MtxActivityParticipant participant) {
        return mapper.selectWpUserParticipantList(participant);
    }

    public List<MtxActivityParticipant> queryForWaitDrawingList(MtxActivityParticipant activityParticipant) {
        return mapper.queryForWaitDrawingList(activityParticipant);
    }
}
