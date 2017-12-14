package com.mtx.family.service;

import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxUserMachine;
import com.mtx.family.mapper.MtxUserMachineMapper;
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

    public List<MtxUserMachine> queryMachineList(String userid) {
        return mapper.queryMachineList(userid);
    }
}
