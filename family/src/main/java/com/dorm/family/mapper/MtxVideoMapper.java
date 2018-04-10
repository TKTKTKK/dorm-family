package com.dorm.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseMapper;
import com.dorm.family.entity.MtxVideo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MtxVideoMapper extends BaseMapper<MtxVideo> {
    public PageList<MtxVideo> selectMtxVideoList(@Param("mtxVideo") MtxVideo mtxVideo, PageBounds pageBounds);
}
