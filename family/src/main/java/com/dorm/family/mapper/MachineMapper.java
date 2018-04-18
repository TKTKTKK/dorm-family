package com.dorm.family.mapper;

import com.dorm.family.entity.Machine;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MachineMapper extends BaseMapper<Machine> {


    List<Machine> selectMachineForMachineNoRepeat(@Param("machine") Machine machine);

    PageList<Machine> selectMachineList(@Param("machine") Machine machine,@Param("startTime") String startDateTimeStr,@Param("endTime") String endDateTimeStr, PageBounds pageBounds);

    List<Machine> selectMachineByOrderId(@Param("orderId") String orderId, @Param("bindid") String userBindId, PageBounds pageBounds);

    List<Machine> selectMachineListForAuto(@Param("machineno") String machineno,@Param("bindid") String userBindId);

    List<Machine> selectMachineForEngineNoRepeat(@Param("machine") Machine machine);

    PageList<Machine> queryForListWithPagination(@Param("machine")Machine machine, PageBounds pageBounds);

    void batchInsert(@Param("list")List<Machine> machineList);

    void deleteAll();
}