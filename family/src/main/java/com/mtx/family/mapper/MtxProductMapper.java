package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.MtxProduct;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MtxProductMapper extends BaseMapper<MtxProduct> {
    public PageList<MtxProduct> selectMxtProductList(@Param("mxtProduct") MtxProduct mxtProduct, PageBounds pageBounds);

    List<MtxProduct> validModelIsExist(@Param("model")String model,@Param("uuid") String uuid);
}
