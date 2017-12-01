package com.mtx.common.audit;


import com.mtx.common.base.BaseEntity;
import com.mtx.common.mapper.AuditLogMapper;
import com.mtx.common.utils.ApplicationContextUtil;

public class AuditLogUtil {

    public static void logToDb(BaseEntity baseEntity, String action){
        AuditLogMapper auditLogMapper = ApplicationContextUtil.getBean(AuditLogMapper.class);
        AuditLog auditLog = new AuditLog();
        auditLog.setAction(action);
        auditLog.setEntityname(baseEntity.tableName());
        auditLog.setEntityid(baseEntity.getUuid());
        auditLog.setDetail(baseEntity.getAuditDetails());
        if (auditLogMapper != null) {
            auditLogMapper.insert(auditLog);
        }
    }
}
