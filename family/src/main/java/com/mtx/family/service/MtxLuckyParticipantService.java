package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxActivityParticipant;
import com.mtx.family.entity.MtxLuckyParticipant;
import com.mtx.family.mapper.MtxActivityParticipantMapper;
import com.mtx.family.mapper.MtxLuckyParticipantMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxLuckyParticipantService extends BaseService<MtxLuckyParticipantMapper,MtxLuckyParticipant> {

    @Autowired
    public void setMapper(MtxLuckyParticipantMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxLuckyParticipant> queryForListWithPagination(MtxLuckyParticipant obj, PageBounds pageBounds) {
        return mapper.selectMtxLuckyParticipantList(obj,pageBounds);
    }

    public List<MtxLuckyParticipant> queryForLuckyParticipantList(MtxLuckyParticipant luckyParticipant) {
        return mapper.queryForLuckyParticipantList(luckyParticipant);
    }
}
