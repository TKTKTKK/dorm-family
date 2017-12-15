package com.mtx.family.service;

import com.mtx.common.base.BaseService;
import com.mtx.family.entity.Repair;
import com.mtx.family.entity.RepairWorker;
import com.mtx.family.mapper.RepairMapper;
import com.mtx.family.mapper.RepairWorkerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class RepairWorkerService extends BaseService<RepairWorkerMapper,RepairWorker> {

    @Autowired
    public void setMapper(RepairWorkerMapper mapper) {
        super.setMapper(mapper);
    }

}
