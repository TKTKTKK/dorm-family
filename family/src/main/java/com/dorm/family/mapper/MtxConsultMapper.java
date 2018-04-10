package com.dorm.family.mapper;

import com.dorm.family.entity.MtxConsult;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MtxConsultMapper extends BaseMapper<MtxConsult> {
    public PageList<MtxConsult> selectMtxConsultList(@Param("mtxConsult") MtxConsult mtxConsult, PageBounds pageBounds);
}
