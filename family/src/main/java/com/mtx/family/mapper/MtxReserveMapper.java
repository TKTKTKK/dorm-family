package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.MtxReserve;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MtxReserveMapper extends BaseMapper<MtxReserve> {
    public PageList<MtxReserve> selectMtxReserveList(@Param("mtxReserve") MtxReserve mtxReserve, PageBounds pageBounds);

    PageList<MtxReserve> queryMerchantReserve(@Param("mtxReserve")MtxReserve mtxReserve, PageBounds pageBounds,@Param("bindid")String bindid,@Param("list")List<String> list);

    MtxReserve queryByPK(@Param("mtxReserve")MtxReserve mtxReserve);
}
