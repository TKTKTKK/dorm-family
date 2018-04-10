package com.dorm.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseService;
import com.dorm.family.entity.MtxUserMachine;
import com.dorm.family.mapper.MtxUserMachineMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxUserMachineService extends BaseService<MtxUserMachineMapper,MtxUserMachine> {

    @Autowired
    public void setMapper(MtxUserMachineMapper mapper) {
        super.setMapper(mapper);
    }

    public List<MtxUserMachine> queryMachineList(String userid,String type) {
        return mapper.queryMachineList(userid,type);
    }
    public PageList<MtxUserMachine> queryForListWithPagination(MtxUserMachine obj, PageBounds pageBounds) {
        return mapper.selectMtxUserMachineList(obj,pageBounds);
    }
}
