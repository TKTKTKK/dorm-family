package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.Logistics;
import com.mtx.family.entity.Machine;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MachineMapper extends BaseMapper<Machine> {


    List<Machine> selectMachineForNoRepeat(@Param("machine") Machine machine);

    PageList<Machine> selectMachineList(@Param("machine") Machine machine,@Param("startTime") String startDateTimeStr,@Param("endTime") String endDateTimeStr, PageBounds pageBounds);

    List<Machine> selectMachineByOrderId(@Param("orderId") String orderId, @Param("bindid") String userBindId, PageBounds pageBounds);
}
