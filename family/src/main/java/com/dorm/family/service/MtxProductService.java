package com.dorm.family.service;

import com.dorm.family.entity.MtxProduct;
import com.dorm.family.mapper.MtxProductMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseService;
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

    public PageList<MtxProduct> queryForListWithPagination(MtxProduct obj, PageBounds pageBounds,String flag) {
        return mapper.selectMxtProductList(obj,pageBounds,flag);
    }

    public List<MtxProduct> validModelIsExist(String model, String uuid) {
        return mapper.validModelIsExist(model,uuid);
    }

    public List<String> getAllModel() {
        return mapper.getAllModel();
    }
}
