package com.dorm.family.mapper;

import com.dorm.common.base.BaseMapper;
import com.dorm.family.entity.MtxConsultDetail;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MtxConsultDetailMapper extends BaseMapper<MtxConsultDetail> {
    public List<MtxConsultDetail> selectMtxConsultDetailList(@Param("mtxConsultDetail") MtxConsultDetail mtxConsultDetail);
}
