package com.dorm.family.mapper;

import com.dorm.common.base.BaseMapper;
import com.dorm.family.entity.Consult;
import com.dorm.family.entity.Hygiene;
import com.dorm.family.entity.Student;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface HygieneMapper extends BaseMapper<Hygiene> {

    Hygiene selectHygieneForSave(@Param("hygiene") Hygiene hygiene);

    PageList<Hygiene> selectHygienePageList(@Param("hygiene") Hygiene hygiene,@Param("startDateTimeStr") String startDateTimeStr,@Param("endDateTimeStr") String endDateTimeStr, PageBounds pageBounds);
}
