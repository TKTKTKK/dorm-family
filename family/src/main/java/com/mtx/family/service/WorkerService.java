package com.mtx.family.service;

import com.mtx.common.base.BaseService;
import com.mtx.family.entity.Worker;
import com.mtx.family.mapper.WorkerMapper;
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
