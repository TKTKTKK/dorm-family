package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.utils.UserUtils;
import com.mtx.family.entity.Logistics;
import com.mtx.family.entity.Machine;
import com.mtx.family.mapper.LogisticsMapper;
import com.mtx.family.mapper.MachineMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MachineService extends BaseService<MachineMapper,Machine> {

    @Autowired
    public void setMapper(MachineMapper mapper) {
        super.setMapper(mapper);
    }

    public List<Machine> queryMachineForNoRepeat(Machine machine) {
        return this.mapper.selectMachineForNoRepeat(machine);
    }

    public PageList<Machine> queryMachineList(Machine machine, String startDateTimeStr, String endDateTimeStr, PageBounds pageBounds) {
        return this.mapper.selectMachineList(machine,startDateTimeStr,endDateTimeStr,pageBounds);
    }

    public List<Machine> queryMachineByOrderId(String orderId, PageBounds pageBounds) {
        return this.mapper.selectMachineByOrderId(orderId, UserUtils.getUserBindId(),pageBounds);
    }
}
