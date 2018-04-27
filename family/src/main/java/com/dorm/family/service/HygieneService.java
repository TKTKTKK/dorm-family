package com.dorm.family.service;

import com.dorm.common.base.BaseService;
import com.dorm.family.entity.Consult;
import com.dorm.family.entity.Hygiene;
import com.dorm.family.entity.Student;
import com.dorm.family.mapper.ConsultMapper;
import com.dorm.family.mapper.HygieneMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class HygieneService extends BaseService<HygieneMapper,Hygiene> {

    @Autowired
    public void setMapper(HygieneMapper mapper) {
        super.setMapper(mapper);
    }


    public Hygiene getHygieneForSave(Hygiene hygiene) {
        return mapper.selectHygieneForSave(hygiene);
    }

    public PageList<Hygiene> getHygienePageList(Hygiene hygiene, String startDateTimeStr, String endDateTimeStr, PageBounds pageBounds) {
        return mapper.selectHygienePageList(hygiene,startDateTimeStr,endDateTimeStr,pageBounds);
    }

    public List<Hygiene> queryHygieneListByStuId(String stuId) {
        return mapper.selectHygieneListByStuId(stuId);
    }
}
