package com.dorm.family.service;

import com.dorm.common.base.BaseService;
import com.dorm.family.entity.Worker;
import com.dorm.family.mapper.WorkerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class WorkerService extends BaseService<WorkerMapper,Worker> {

    @Autowired
    public void setMapper(WorkerMapper mapper) {
        super.setMapper(mapper);
    }

}
