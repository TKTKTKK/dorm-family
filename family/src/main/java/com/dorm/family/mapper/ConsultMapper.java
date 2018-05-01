package com.dorm.family.mapper;

import com.dorm.common.base.BaseMapper;
import com.dorm.family.entity.Address;
import com.dorm.family.entity.Consult;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ConsultMapper extends BaseMapper<Consult> {

    PageList<Consult> selectConsultPageList(@Param("consult") Consult consult,@Param("startDateTimeStr") String startDateTimeStr,@Param("endDateTimeStr") String endDateTimeStr, PageBounds pageBounds);

    List<Consult> selectConsultAsy(@Param("consult") Consult consult);

    PageList<Consult> selectConsultReportPageList(@Param("consult") Consult consult,@Param("startDateTimeStr") String startDateTimeStr,@Param("endDateTimeStr") String endDateTimeStr, PageBounds pageBounds);

    List<Consult> selectConsultReportListForExport(@Param("consult") Consult consult,@Param("startDateTimeStr") String startDateTimeStr,@Param("endDateTimeStr") String endDateTimeStr);
}
