package com.mtx.common.mapper;

import com.mtx.common.audit.AuditLog;
import com.mtx.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AuditLogMapper extends BaseMapper<AuditLog> {
    public List<AuditLog> selectAuditLogListByEntity(@Param("entityid")String entityid, @Param("entityname")String entityname);
}
