package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxConsult;
import com.mtx.family.entity.MtxConsultDetail;
import com.mtx.family.mapper.MtxConsultDetailMapper;
import com.mtx.family.mapper.MtxConsultMapper;
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
