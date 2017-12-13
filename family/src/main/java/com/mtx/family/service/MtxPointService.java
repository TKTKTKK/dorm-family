package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxConsult;
import com.mtx.family.entity.MtxPoint;
import com.mtx.family.mapper.MtxConsultMapper;
import com.mtx.family.mapper.MtxPointMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxPointService extends BaseService<MtxPointMapper,MtxPoint> {

    @Autowired
    public void setMapper(MtxPointMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxPoint> queryForListWithPagination(MtxPoint obj, PageBounds pageBounds) {
        return mapper.selectMtxPointList(obj,pageBounds);
    }

    public List<MtxPoint> queryPointForList(MtxPoint point) {
        return mapper.queryPointForList(point);
    }

    public int queryCountConsumePoint(String userid) {
        return mapper.queryCountConsumePoint(userid);
    }
}
