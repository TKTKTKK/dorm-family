package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.Repair;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RepairMapper extends BaseMapper<Repair> {


    List<Repair> selectRepairForSnnoRepeat(@Param("repair") Repair repair);

    PageList<Repair> selectRepairList(@Param("repair") Repair repair,@Param("startTime") String startDateTimeStr,@Param("endTime") String endDateTimeStr, PageBounds pageBounds);

}
