package com.dorm.family.mapper;

import com.dorm.family.entity.MtxProduct;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MtxProductMapper extends BaseMapper<MtxProduct> {
    public PageList<MtxProduct> selectMxtProductList(@Param("mxtProduct") MtxProduct mxtProduct, PageBounds pageBounds,@Param("flag")String flag);

    List<MtxProduct> validModelIsExist(@Param("model")String model,@Param("uuid") String uuid);

    List<String> getAllModel();
}
