package com.dorm.common.audit;


import com.dorm.common.utils.ApplicationContextUtil;
import com.dorm.common.base.BaseEntity;
import com.dorm.common.mapper.AuditLogMapper;

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
