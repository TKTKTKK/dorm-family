package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.MtxReserve;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MtxReserveMapper extends BaseMapper<MtxReserve> {
    public PageList<MtxReserve> selectMtxReserveList(@Param("mtxReserve") MtxReserve mtxReserve, PageBounds pageBounds);

    PageList<MtxReserve> queryMerchantReserve(@Param("mtxReserve")MtxReserve mtxReserve, PageBounds pageBounds,@Param("bindid")String bindid);

    MtxReserve queryByPK(@Param("mtxReserve")MtxReserve mtxReserve);
}
