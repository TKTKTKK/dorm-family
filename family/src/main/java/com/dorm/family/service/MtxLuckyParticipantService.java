package com.dorm.family.service;

import com.dorm.family.entity.MtxLuckyParticipant;
import com.dorm.family.mapper.MtxLuckyParticipantMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseService;
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

    public List<MtxLuckyParticipant> queryForLuckyParticipantList(MtxLuckyParticipant luckyParticipant,String flag) {
        return mapper.queryForLuckyParticipantList(luckyParticipant,flag);
    }

}
