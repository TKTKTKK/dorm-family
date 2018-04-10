package com.dorm.family.service;

import com.dorm.common.base.BaseService;
import com.dorm.family.entity.MtxConsultDetail;
import com.dorm.family.mapper.MtxConsultDetailMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxConsultDetailService extends BaseService<MtxConsultDetailMapper,MtxConsultDetail> {

    @Autowired
    public void setMapper(MtxConsultDetailMapper mapper) {
        super.setMapper(mapper);
    }

    public List<MtxConsultDetail> queryForListWithPagination(MtxConsultDetail obj) {
        return mapper.selectMtxConsultDetailList(obj);
    }
}
