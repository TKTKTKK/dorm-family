package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxExchangeRecord;
import com.mtx.family.entity.MtxPartsCenter;
import com.mtx.family.mapper.MtxExchangeRecordMapper;
import com.mtx.family.mapper.MtxPartsCenterMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxExchangeRecordService extends BaseService<MtxExchangeRecordMapper,MtxExchangeRecord> {

    @Autowired
    public void setMapper(MtxExchangeRecordMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxExchangeRecord> queryForListWithPagination(MtxExchangeRecord obj, PageBounds pageBounds) {
        return mapper.selectMtxExchangeRecordList(obj,pageBounds);
    }
}
