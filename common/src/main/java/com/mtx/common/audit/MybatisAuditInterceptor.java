package com.mtx.common.audit;

import com.mtx.common.base.BaseEntity;
import com.mtx.common.utils.StringUtils;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Statement;
import java.util.Properties;

@Intercepts({@Signature(
        type= Executor.class,
        method = "update",
        args = {MappedStatement.class,Object.class})})
public class MybatisAuditInterceptor implements Interceptor {
    private static Logger logger = LoggerFactory.getLogger(MybatisAuditInterceptor.class);
    static int MAPPED_STATEMENT_INDEX = 0;
    static int PARAMETER_INDEX = 1;

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        try {
            final Object[] queryArgs = invocation.getArgs();
            final MappedStatement ms = (MappedStatement)queryArgs[MAPPED_STATEMENT_INDEX];
            final Object parameter = queryArgs[PARAMETER_INDEX];
            if(parameter instanceof BaseEntity){
                BaseEntity baseEntity = (BaseEntity)parameter;
                String action = ms.getSqlCommandType().name();
                if (StringUtils.isBlank(baseEntity.getUuid())) {
                    baseEntity.setUuid(StringUtils.getUUID());
                }
                if(baseEntity.getNeedaudit() && !baseEntity.tableName().equalsIgnoreCase("tb_common_audit_log")){
                    AuditLogUtil.logToDb(baseEntity,action);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
        }
        return invocation.proceed();
    }

    @Override
    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }

    @Override
    public void setProperties(Properties properties) {

    }
}
