package com.dorm.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseMapper;
import com.dorm.family.entity.MtxExchangeRecord;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MtxExchangeRecordMapper extends BaseMapper<MtxExchangeRecord> {
    public PageList<MtxExchangeRecord> selectMtxExchangeRecordList(@Param("mtxExchangeRecord") MtxExchangeRecord mtxExchangeRecord, PageBounds pageBounds);

    List<MtxExchangeRecord> queryExchangeRecordList(@Param("userid")String userid);
}
