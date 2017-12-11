package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxReserve;
import com.mtx.family.mapper.MtxReserveMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class MtxReserveService extends BaseService<MtxReserveMapper,MtxReserve> {

    @Autowired
    public void setMapper(MtxReserveMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxReserve> queryForListWithPagination(MtxReserve obj, PageBounds pageBounds) {
        return mapper.selectMtxReserveList(obj,pageBounds);
    }
}
