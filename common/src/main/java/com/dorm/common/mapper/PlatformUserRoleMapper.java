package com.dorm.common.mapper;

import com.dorm.common.base.BaseMapper;
import com.dorm.common.entity.PlatformUserRole;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by wensheng on 14-12-12.
 */
@Repository
public interface PlatformUserRoleMapper extends BaseMapper<PlatformUserRole> {
    public void deleteUserRoleByUserId(@Param("userid")String userid);
}
