package com.dorm.family.service;

import com.dorm.common.base.BaseService;
import com.dorm.family.entity.Address;
import com.dorm.family.entity.Consult;
import com.dorm.family.mapper.AddressMapper;
import com.dorm.family.mapper.ConsultMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class ConsultService extends BaseService<ConsultMapper,Consult> {

    @Autowired
    public void setMapper(ConsultMapper mapper) {
        super.setMapper(mapper);
    }


    public PageList<Consult> getConsultPageList(Consult consult, String startDateTimeStr, String endDateTimeStr, PageBounds pageBounds) {
        return mapper.selectConsultPageList(consult,startDateTimeStr,endDateTimeStr,pageBounds);
    }
}
