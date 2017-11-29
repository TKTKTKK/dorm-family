package com.mtx.common.mapper;

import com.mtx.common.base.BaseMapper;
import com.mtx.common.entity.PlatformRolePermit;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlatformRolePermitMapper extends BaseMapper<PlatformRolePermit> {
    public List<PlatformRolePermit> getRolePermitListByRoleId(@Param("roleid") String roleid);

}
