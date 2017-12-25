package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.MtxActivity;
import com.mtx.family.entity.MtxActivityParticipant;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MtxActivityParticipantMapper extends BaseMapper<MtxActivityParticipant> {
    public PageList<MtxActivityParticipant> selectMtxActivityParticipantList(@Param("mtxActivityParticipant") MtxActivityParticipant MtxActivityParticipant, PageBounds pageBounds);
}
