package com.dorm.common.base;


import com.dorm.common.template.CRUDTemplate;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface BaseMapper<T extends BaseEntity> {
    @DeleteProvider(type = CRUDTemplate.class ,method = "delete")
    int delete(T obj);

    @InsertProvider(type = CRUDTemplate.class ,method = "insert")
    int insert(T obj);

    @UpdateProvider(type = CRUDTemplate.class ,method = "update")
    int update(T obj);

    @UpdateProvider(type = CRUDTemplate.class ,method = "updatePartial")
    int updatePartial(T obj);

    @UpdateProvider(type = CRUDTemplate.class ,method = "logicDelete")
    int logicDelete(T obj);

    /**
     * 需要在*Mapper.xml中定义selectResultMap
     * @param obj
     * @return
     */
    @SelectProvider(type = CRUDTemplate.class ,method = "select")
    @ResultMap("selectResultMap")
    List<T> select(T obj);

    @SelectProvider(type = CRUDTemplate.class ,method = "retrieveByPk")
    @ResultMap("selectResultMap")
    T retrieveByPk(T obj);

    @SelectProvider(type = CRUDTemplate.class ,method = "retrieveByUniqueKey")
    @ResultMap("selectResultMap")
    T retrieveByUniqueKey(T obj);

}
