package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.MtxProduct;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MtxProductMapper extends BaseMapper<MtxProduct> {
    public PageList<MtxProduct> selectMxtProductList(@Param("mxtProduct") MtxProduct mxtProduct, PageBounds pageBounds);
}
