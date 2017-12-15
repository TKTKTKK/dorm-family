package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.MtxPartsCenter;
import com.mtx.family.entity.MtxVideo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MtxPartsCenterMapper extends BaseMapper<MtxPartsCenter> {
    public PageList<MtxPartsCenter> selectMtxPartsCenterList(@Param("mtxPartsCenter") MtxPartsCenter mtxPartsCenter, PageBounds pageBounds);

    List<MtxPartsCenter> ifMaterialCodeExist(@Param("code") String code, @Param("uuid") String uuid);
}
