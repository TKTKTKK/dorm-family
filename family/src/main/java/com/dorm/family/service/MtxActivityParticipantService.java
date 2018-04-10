package com.dorm.family.service;

import com.dorm.family.entity.MtxActivityParticipant;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseService;
import com.dorm.family.mapper.MtxActivityParticipantMapper;
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
