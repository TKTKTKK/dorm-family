package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxActivity;
import com.mtx.family.entity.MtxReserve;
import com.mtx.family.mapper.MtxActivityMapper;
import com.mtx.family.mapper.MtxReserveMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class MtxActivityService extends BaseService<MtxActivityMapper,MtxActivity> {

    @Autowired
    public void setMapper(MtxActivityMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxActivity> queryForListWithPagination(MtxActivity obj, PageBounds pageBounds) {
        return mapper.selectMtxActivityList(obj,pageBounds);
    }
}
