package com.dorm.family.service;

import com.dorm.common.base.BaseService;
import com.dorm.family.entity.Logistics;
import com.dorm.family.mapper.LogisticsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class LogisticsService extends BaseService<LogisticsMapper,Logistics> {

    @Autowired
    public void setMapper(LogisticsMapper mapper) {
        super.setMapper(mapper);
    }

}
