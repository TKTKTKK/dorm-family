package com.mtx.common.service;

import com.mtx.common.base.BaseService;
import com.mtx.common.entity.PlatformRole;
import com.mtx.common.mapper.PlatformRoleMapper;
import com.mtx.common.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by wensheng on 14-12-12.
 */
@Service
@Transactional
public class PlatformRoleService extends BaseService<PlatformRoleMapper,PlatformRole> {
    @Autowired
    public void setMapper(PlatformRoleMapper mapper) {
        super.setMapper(mapper);
    }

    public List<PlatformRole> getUserRoleList(String userid){
        return mapper.getUserRoleList(userid);
    }

    /**
     * 获取默认Role
     * @return
     */
    public PlatformRole getDefaultRole(String rolekey){
        PlatformRole platformRole = new PlatformRole();
        platformRole.setRolekey(rolekey);
        return queryForObjectByUniqueKey(platformRole);
    }

    /**
     * 查询非超级管理员角色
     * @return
     */
    public List<PlatformRole> selectNonSuperRoles(){
        String bindid = UserUtils.getUserBindId();
        return mapper.selectNonSuperRoles(bindid);
    }

    /**
     * 根据openid查询用户角色
     * @param bindid
     * @param openid
     * @return
     */
    public List<PlatformRole> queryUserRoleListByOpenId(String bindid, String openid){
        return this.mapper.selectUserRoleListByOpenId(bindid, openid);
    }

    /**
     * 管理员创建角色
     * 根据配置同步角色信息至工作流引擎
     * @param role
     */
    public void createRole(PlatformRole role){
        mapper.insert(role);
    }


    /**
     * 管理员删除角色
     * 根据配置同步角色信息至工作流引擎
     * @param role
     */
    public void deleteRole(PlatformRole role){
        mapper.delete(role);
    }

    /**
     *
     * @return
     */
    public List<PlatformRole> queryBindRoleList(){
        String bindid = UserUtils.getUserBindId();
        return this.mapper.queryBindRoleList(bindid);
    }

    /**
     * 根据bindid查询角色列表
     * @return
     */
    public List<PlatformRole> queryRolesByBindId(){
        String bindid = UserUtils.getUserBindId();
        return this.mapper.selectRolesByBindId(bindid);
    }
}
