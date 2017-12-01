package com.mtx.common.base;

import com.mtx.common.exception.ServiceException;
import com.mtx.common.utils.ReflectUtil;
import com.mtx.common.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.Column;
import java.lang.reflect.Field;
import java.util.List;

/**
 * Created by wensheng on 14-11-28.
 */
public class BaseService<T extends BaseMapper<E>, E extends BaseEntity> {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    protected T mapper;

    public void setMapper(T mapper) {
        this.mapper = mapper;
    }

    public E queryForObjectByPk(E obj) {
        return (E) mapper.retrieveByPk(obj);
    }

    public E queryForObjectByUniqueKey(E obj) {
        return (E) mapper.retrieveByUniqueKey(obj);
    }

    public List<E> queryForList(E obj) {
        return mapper.select(obj);
    }

    public int insert(E obj) {
        return mapper.insert(obj);
    }

    public int update(E obj) {
        setAuditDetails(obj,false);
        int i = mapper.update(obj);
        if(i == 0){
            throw new ServiceException("Concurrency Update!");
        }
        return i;
    }

    public int updatePartial(E obj){
        setAuditDetails(obj,true);
        int i = mapper.updatePartial(obj);
        if(i == 0){
            throw new ServiceException("Concurrency Update!");
        }
        return i;
    }

    public int delete(E obj) {
        obj = mapper.retrieveByPk(obj);
        return mapper.delete(obj);
    }

    /**
     * 注意传值的对象中只能有主键和version不能有其他内容
     * @param obj
     * @return
     */
    public int logicDelete(E obj) {
        return mapper.logicDelete(obj);
    }

    /**
     *
     * @param obj
     * @param ignoreNullValue
     * @return
     */
    private String getAuditDetails(E obj, boolean ignoreNullValue) {
        StringBuilder sb = new StringBuilder();
        if (obj.getNeedaudit()) {
            E oldObj = mapper.retrieveByPk(obj);
            for (Field field : ReflectUtil.getDeclaredFields(obj)) {
                if (field.isAnnotationPresent(Column.class)) {
                    String newFieldValue = StringUtils.defaultString(String.valueOf(ReflectUtil.getFieldValue(obj, field.getName())));
                    String oldFieldValue = StringUtils.defaultString(String.valueOf(ReflectUtil.getFieldValue(oldObj, field.getName())));

                    if (ignoreNullValue) {
                        if (StringUtils.isNotBlank(newFieldValue)) {
                            if (!newFieldValue.equals(oldFieldValue)) {
                                sb.append(field.getName() + ":" + oldFieldValue + "->" + newFieldValue + " ");
                            }
                        }
                    } else {
                        if (!newFieldValue.equals(oldFieldValue)) {
                            sb.append(field.getName() + ":" + oldFieldValue + "->" + newFieldValue + " ");
                        }
                    }
                }
            }
            return sb.toString();
        }
        return null;
    }

    /**
     *
     * @param obj
     * @param ignoreNullValue
     */
    private void setAuditDetails(E obj, boolean ignoreNullValue){
        try {
            String auditDetails = this.getAuditDetails(obj,ignoreNullValue);
            obj.setAuditDetails(auditDetails);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
        }
    }
}
