package com.dorm.common.template;


import com.dorm.common.base.BaseEntity;
import com.dorm.common.utils.DateUtils;
import com.dorm.common.utils.ReflectUtil;
import com.dorm.common.utils.StringUtils;
import com.dorm.common.utils.UserUtils;
import org.apache.ibatis.jdbc.SQL;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Version;
import java.lang.reflect.Field;

public class CRUDTemplate<T extends BaseEntity> {

    private SQL sql = new SQL();

    /**
     * 根据主键删除
     * @param obj
     * @return sql
     */
    public String delete(T obj) {
        sql.DELETE_FROM(obj.tableName());
        sql.WHERE(obj.id() + " = #{" + obj.id() + "}");
        return sql.toString();
    }

    /**
     * 根据主键逻辑删除
     * @param obj
     * @return sql
     */
    public String logicDelete(T obj) {
        return updatePartial(obj);
    }

    /**
     *
     * @param obj
     * @return
     */
    public String insert(T obj) {
        String dt = DateUtils.formatSystemDateTimeMillis();
        if (StringUtils.isBlank(obj.getUuid())) {
            obj.setUuid(StringUtils.getUUID());
        }
        obj.setCreateby(UserUtils.getUserId());
        obj.setModifyby(UserUtils.getUserId());
        obj.setCreateon(dt);
        obj.setModifyon(dt);
        obj.setVersionno(1);
        obj.setDelind("N");
        sql.INSERT_INTO(obj.tableName());
        for (Field field : ReflectUtil.getDeclaredFields(obj)) {
            if (field.isAnnotationPresent(Id.class) || field.isAnnotationPresent(Column.class)) {
                sql.VALUES(field.getName(), "#{" + field.getName() + "}");
            }
        }
        return sql.toString();
    }

    /**
     * 全部更新
     * @param obj
     * @return
     */
    public String update(T obj) {
        String dt = DateUtils.formatSystemDateTimeMillis();
        obj.setModifyby(UserUtils.getUserId());
        obj.setModifyon(dt);
        sql.UPDATE(obj.tableName());
        for (Field field : ReflectUtil.getDeclaredFields(obj)){
            if(field.isAnnotationPresent(Column.class)){
                if(!field.isAnnotationPresent(Version.class)){
                    sql.SET(field.getName() + " = #{" + field.getName() + "}");
                }else{
                    sql.SET(field.getName() + " = #{" + field.getName() + "} + 1");
                }
            }
        }
        sql.WHERE(obj.id() + " = #{" + obj.id() + "}");
        sql.WHERE(obj.versionColumn() + " = #{" + obj.versionColumn() + "}");
        return sql.toString();
    }

    /**
     * 不更新空值
     * aram obj
     * @return
     */
    public String updatePartial(T obj) {
        String dt = DateUtils.formatSystemDateTimeMillis();
        obj.setModifyby(UserUtils.getUserId());
        obj.setModifyon(dt);
        sql.UPDATE(obj.tableName());
        for (Field field : ReflectUtil.getDeclaredFields(obj)){
            if (field.isAnnotationPresent(Column.class)&& ReflectUtil.getFieldValue(obj, field.getName()) != null) {
                if(!field.isAnnotationPresent(Version.class)){
                    sql.SET(field.getName() + " = #{" + field.getName() + "}");
                }else{
                    sql.SET(field.getName() + " = #{" + field.getName() + "} + 1");
                }
            }
        }
        sql.WHERE(obj.id() + " = #{" + obj.id() + "}");
        sql.WHERE(obj.versionColumn() + " = #{" + obj.versionColumn() + "}");
        return sql.toString();
    }

    /**
     * 根据主键查询
     * @param obj
     * @return
     */
    public String retrieveByPk(T obj) {
        sql.SELECT("*");
        sql.FROM(obj.tableName());
        sql.WHERE(obj.id() + " = #{" + obj.id() + "}");
        return sql.toString();
    }

    /**
     * 根据唯一键查询,注意只传唯一建的值
     * @param obj
     * @return
     */
    public String retrieveByUniqueKey(T obj) {
        sql.SELECT("*");
        sql.FROM(obj.tableName());
        for (Field field : ReflectUtil.getDeclaredFields(obj)) {
            if (field.isAnnotationPresent(Column.class) && ReflectUtil.getFieldValue(obj, field.getName()) != null) {
                sql.WHERE(field.getName() + " = #{" + field.getName() + "}");
            }
        }
        return sql.toString();
    }

    /**
     * 根据obj非空属性查询，只支持"AND"和"="
     * @param obj
     * @return
     */
    public String select(T obj) {
        sql.SELECT("*");
        sql.FROM(obj.tableName());
        for (Field field : ReflectUtil.getDeclaredFields(obj)) {
            if (field.isAnnotationPresent(Column.class) && ReflectUtil.getFieldValue(obj, field.getName()) != null) {
                sql.WHERE(field.getName() + " = #{" + field.getName() + "}");
            }
        }
        if(StringUtils.isNotBlank(obj.getOrderby())){
            sql.ORDER_BY(obj.getOrderby());
        }
        return sql.toString();
    }

}
