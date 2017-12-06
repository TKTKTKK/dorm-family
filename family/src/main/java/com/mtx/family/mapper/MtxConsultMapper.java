package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.MtxConsult;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MtxConsultMapper extends BaseMapper<MtxConsult> {
    public PageList<MtxConsult> selectMtxConsultList(@Param("mtxConsult") MtxConsult mtxConsult, PageBounds pageBounds);
}
