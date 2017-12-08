package com.mtx.common.service;

import com.mtx.common.base.BaseService;
import com.mtx.common.entity.BindRole;
import com.mtx.common.mapper.BindRoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class BindRoleService extends BaseService<BindRoleMapper,BindRole> {
    @Autowired
    public void setMapper(BindRoleMapper mapper) {
        super.setMapper(mapper);
    }
}
