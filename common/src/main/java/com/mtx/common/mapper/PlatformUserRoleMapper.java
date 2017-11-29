package com.mtx.common.mapper;

import com.mtx.common.entity.PlatformUserRole;
import com.mtx.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by wensheng on 14-12-12.
 */
@Repository
public interface PlatformUserRoleMapper extends BaseMapper<PlatformUserRole> {
    public void deleteUserRoleByUserId(@Param("userid")String userid);
}
