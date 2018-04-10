package com.dorm.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseMapper;
import com.dorm.family.entity.MtxLuckyParticipant;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MtxLuckyParticipantMapper extends BaseMapper<MtxLuckyParticipant> {
    public PageList<MtxLuckyParticipant> selectMtxLuckyParticipantList(@Param("mtxLuckyParticipant") MtxLuckyParticipant MtxLuckyParticipant, PageBounds pageBounds);

    List<MtxLuckyParticipant> queryForLuckyParticipantList(@Param("mtxLuckyParticipant")MtxLuckyParticipant luckyParticipant,@Param("flag")String flag);
}
