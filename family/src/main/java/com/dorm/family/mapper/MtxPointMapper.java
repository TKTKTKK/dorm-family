package com.dorm.family.mapper;

import com.dorm.family.entity.MtxPoint;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MtxPointMapper extends BaseMapper<MtxPoint> {
    public PageList<MtxPoint> selectMtxPointList(@Param("mtxPoint") MtxPoint mtxPoint, PageBounds pageBounds);

    List<MtxPoint> queryPointForList(@Param("mtxPoint")MtxPoint point);

    public int queryCountConsumePoint(@Param("userid")String userid);
}
