package com.dorm.family.mapper;

import com.dorm.family.entity.QualityMgmt;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QualityMgmtMapper extends BaseMapper<QualityMgmt> {

    List<QualityMgmt> selectQualityMgmtListForPhone(@Param("qualityMgmt") QualityMgmt qualityMgmt);

    PageList<QualityMgmt> selectQualityMgmtPageList(@Param("qualityMgmt") QualityMgmt qualityMgmt, @Param("startTime") String startDateTimeStr, @Param("endTime") String endDateTimeStr, PageBounds pageBounds);

    List<QualityMgmt> selectQualityMgmtListForExport(@Param("qualityMgmt") QualityMgmt qualityMgmt, @Param("startTime") String startDateStr, @Param("endTime") String endDateStr);

    List<QualityMgmt> selectQualityMgmtAsy(@Param("qualityMgmt") QualityMgmt qualityMgmt);
}
