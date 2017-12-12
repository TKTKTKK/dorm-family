package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxProduct;
import com.mtx.family.mapper.MtxProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxProductService extends BaseService<MtxProductMapper,MtxProduct> {

    @Autowired
    public void setMapper(MtxProductMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxProduct> queryForListWithPagination(MtxProduct obj, PageBounds pageBounds) {
        return mapper.selectMxtProductList(obj,pageBounds);
    }

    public List<MtxProduct> validModelIsExist(String model, String uuid) {
        return mapper.validModelIsExist(model,uuid);
    }
}
