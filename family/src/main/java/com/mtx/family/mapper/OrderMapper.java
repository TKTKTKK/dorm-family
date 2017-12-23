package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.Merchant;
import com.mtx.family.entity.Order;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderMapper extends BaseMapper<Order> {


    List<Order> selectOrderForSnnoRepeat(@Param("order") Order order);

    PageList<Order> selectOrderList(@Param("order") Order order,@Param("ifHqUser") String ifHqUser, @Param("startTime") String startTime, @Param("endTime") String endTime, PageBounds pageBounds);
}
