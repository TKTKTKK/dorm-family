package com.dorm.family.service;

import com.dorm.family.entity.MtxVideo;
import com.dorm.family.mapper.MtxVideoMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class MtxVideoService extends BaseService<MtxVideoMapper,MtxVideo> {

    @Autowired
    public void setMapper(MtxVideoMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxVideo> queryForListWithPagination(MtxVideo obj, PageBounds pageBounds) {
        return mapper.selectMtxVideoList(obj,pageBounds);
    }
}
