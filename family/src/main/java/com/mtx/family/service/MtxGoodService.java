package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxGood;
import com.mtx.family.entity.MtxProduct;
import com.mtx.family.mapper.MtxGoodMapper;
import com.mtx.family.mapper.MtxProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class MtxGoodService extends BaseService<MtxGoodMapper,MtxGood> {

    @Autowired
    public void setMapper(MtxGoodMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxGood> queryForListWithPagination(MtxGood obj, PageBounds pageBounds) {
        return mapper.selectMtxGoodList(obj,pageBounds);
    }
}
