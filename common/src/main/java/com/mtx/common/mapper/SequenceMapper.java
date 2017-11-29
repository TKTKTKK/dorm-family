package com.mtx.common.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by wensheng on 15-1-7.
 */
@Repository
public interface SequenceMapper  {

    public Integer selectNextVal(@Param("sequenceName") String sequenceName);
}
