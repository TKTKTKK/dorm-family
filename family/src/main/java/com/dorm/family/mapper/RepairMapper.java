package com.dorm.family.mapper;

import com.dorm.common.base.BaseMapper;
import com.dorm.family.entity.Address;
import com.dorm.family.entity.Repair;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RepairMapper extends BaseMapper<Repair> {


    PageList<Repair> selectRepairPageList(@Param("repair") Repair repair,@Param("startDateTimeStr") String startDateTimeStr,@Param("endDateTimeStr") String endDateTimeStr, PageBounds pageBounds);
}
