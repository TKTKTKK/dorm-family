package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.Logistics;
import com.mtx.family.entity.Order;
import com.mtx.family.mapper.LogisticsMapper;
import com.mtx.family.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class LogisticsService extends BaseService<LogisticsMapper,Logistics> {

    @Autowired
    public void setMapper(LogisticsMapper mapper) {
        super.setMapper(mapper);
    }

}
