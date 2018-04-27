package com.dorm.family.mapper;

import com.dorm.common.base.BaseMapper;
import com.dorm.family.entity.Address;
import com.dorm.family.entity.Echarge;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EchargeMapper extends BaseMapper<Echarge> {

    PageList<Echarge> selectEchargePageList(@Param("echarge") Echarge echarge,@Param("startDateTimeStr") String startDateTimeStr,@Param("endDateTimeStr") String endDateTimeStr, PageBounds pageBounds);
}
