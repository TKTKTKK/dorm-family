package com.dorm.common.mapper;

import com.dorm.common.entity.PlatformRolePermit;
import com.dorm.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlatformRolePermitMapper extends BaseMapper<PlatformRolePermit> {
    public List<PlatformRolePermit> getRolePermitListByRoleId(@Param("roleid") String roleid);

}
