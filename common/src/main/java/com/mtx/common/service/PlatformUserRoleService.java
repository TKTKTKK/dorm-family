package com.mtx.common.service;

import com.mtx.common.entity.PlatformUserRole;
import com.mtx.common.mapper.PlatformUserRoleMapper;
import com.mtx.common.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class PlatformUserRoleService extends BaseService<PlatformUserRoleMapper,PlatformUserRole> {
    @Autowired
    public void setMapper(PlatformUserRoleMapper mapper) {
        super.setMapper(mapper);
    }

    /**
     * 根据userid删除用户角色关联
     * @param userid
     */
    public void deleteUserRoleByUserId(String userid){
        mapper.deleteUserRoleByUserId(userid);
    }

    /**
     * 管理员创建用户角色关系
     * @param userRole
     */
    public void createUserRole(PlatformUserRole userRole){
        mapper.insert(userRole);
    }


    /**
     * 管理员删除用户角色关系
     * @param userRole
     */
    public void deleteUserRole(PlatformUserRole userRole){
        mapper.delete(userRole);
    }
}
