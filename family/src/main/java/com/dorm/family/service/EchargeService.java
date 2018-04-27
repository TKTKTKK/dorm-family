package com.dorm.family.service;

import com.dorm.common.base.BaseService;
import com.dorm.family.entity.Address;
import com.dorm.family.entity.Echarge;
import com.dorm.family.mapper.AddressMapper;
import com.dorm.family.mapper.EchargeMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class EchargeService extends BaseService<EchargeMapper,Echarge> {

    @Autowired
    public void setMapper(EchargeMapper mapper) {
        super.setMapper(mapper);
    }


    public PageList<Echarge> getEchargePageList(Echarge echarge, String startDateTimeStr, String endDateTimeStr, PageBounds pageBounds) {
        return  mapper.selectEchargePageList(echarge,startDateTimeStr,endDateTimeStr,pageBounds);
    }
}
