package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.MtxPoint;
import com.mtx.family.entity.MtxVideo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MtxVideoMapper extends BaseMapper<MtxVideo> {
    public PageList<MtxVideo> selectMtxVideoList(@Param("mtxVideo") MtxVideo mtxVideo, PageBounds pageBounds);
}
