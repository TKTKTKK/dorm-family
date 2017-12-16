package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.MtxConsultDetail;
import com.mtx.family.entity.MtxExchangeRecord;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MtxExchangeRecordMapper extends BaseMapper<MtxExchangeRecord> {
    public PageList<MtxExchangeRecord> selectMtxExchangeRecordList(@Param("mtxExchangeRecord") MtxExchangeRecord mtxExchangeRecord, PageBounds pageBounds);
}
