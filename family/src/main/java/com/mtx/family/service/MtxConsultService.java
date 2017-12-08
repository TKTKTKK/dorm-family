package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxConsult;
import com.mtx.family.mapper.MtxConsultMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class MtxConsultService extends BaseService<MtxConsultMapper,MtxConsult> {

    @Autowired
    public void setMapper(MtxConsultMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxConsult> queryForListWithPagination(MtxConsult obj, PageBounds pageBounds) {
        return mapper.selectMtxConsultList(obj,pageBounds);
    }
}
