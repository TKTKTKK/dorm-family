package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxPartsCenter;
import com.mtx.family.entity.MtxVideo;
import com.mtx.family.mapper.MtxPartsCenterMapper;
import com.mtx.family.mapper.MtxVideoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxPartsCenterService extends BaseService<MtxPartsCenterMapper,MtxPartsCenter> {

    @Autowired
    public void setMapper(MtxPartsCenterMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxPartsCenter> queryForListWithPagination(MtxPartsCenter obj, PageBounds pageBounds) {
        return mapper.selectMtxPartsCenterList(obj,pageBounds);
    }

    public List<MtxPartsCenter> ifMaterialCodeExist(String code, String uuid) {
        return mapper.ifMaterialCodeExist(code,uuid);
    }
}
