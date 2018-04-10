package com.dorm.family.mapper;

import com.dorm.family.entity.MtxActivityParticipant;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MtxActivityParticipantMapper extends BaseMapper<MtxActivityParticipant> {
    public PageList<MtxActivityParticipant> selectMtxActivityParticipantList(@Param("mtxActivityParticipant") MtxActivityParticipant MtxActivityParticipant, PageBounds pageBounds);

    List<MtxActivityParticipant> selectWpUserParticipantList(@Param("participant")MtxActivityParticipant participant);

    List<MtxActivityParticipant> queryForWaitDrawingList(@Param("participant")MtxActivityParticipant participant);
}
