package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.QualityMgmt;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QualityMgmtMapper extends BaseMapper<QualityMgmt> {

    List<QualityMgmt> selectQualityMgmtListForPhone(@Param("qualityMgmt") QualityMgmt qualityMgmt);

    PageList<QualityMgmt> selectQualityMgmtPageList(@Param("qualityMgmt") QualityMgmt qualityMgmt, @Param("startTime") String startDateTimeStr, @Param("endTime") String endDateTimeStr, PageBounds pageBounds);

    List<QualityMgmt> selectQualityMgmtListForExport(@Param("qualityMgmt") QualityMgmt qualityMgmt, @Param("startTime") String startDateStr, @Param("endTime") String endDateStr);
}
