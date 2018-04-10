package com.dorm.common.mapper;

import com.dorm.common.base.BaseMapper;
import com.dorm.common.entity.PlatformRole;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wensheng on 14-12-12.
 */
@Repository
public interface PlatformRoleMapper extends BaseMapper<PlatformRole> {

    public List<PlatformRole> getUserRoleList(@Param("userid") String userid);

    public List<PlatformRole> queryBindRoleList(@Param("bindid") String bindid);

    public List<PlatformRole> selectNonSuperRoles(@Param("bindid") String bindid);

    List<PlatformRole> selectUserRoleListByOpenId(@Param("bindid")String bindid, @Param("openid")String openid);

    List<PlatformRole> selectRolesByBindId(@Param("bindid")String bindid);

    public List<PlatformRole> querySuperRole(@Param("uuid")String uuid);
}
