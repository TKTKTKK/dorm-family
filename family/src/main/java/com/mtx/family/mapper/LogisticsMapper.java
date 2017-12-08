package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.Logistics;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LogisticsMapper extends BaseMapper<Logistics> {


}
