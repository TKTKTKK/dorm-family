package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.MtxGood;
import com.mtx.family.entity.MtxProduct;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MtxGoodMapper extends BaseMapper<MtxGood> {
    public PageList<MtxGood> selectMtxGoodList(@Param("mtxGood") MtxGood mtxGood, PageBounds pageBounds);
}
