package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxProduct;
import com.mtx.family.mapper.MxtProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class MxtProductService extends BaseService<MxtProductMapper,MtxProduct> {

    @Autowired
    public void setMapper(MxtProductMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxProduct> queryForListWithPagination(MtxProduct obj, PageBounds pageBounds) {
        return mapper.selectMxtProductList(obj,pageBounds);
    }
}
