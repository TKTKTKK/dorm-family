package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.utils.StringUtils;
import com.mtx.common.utils.UserUtils;
import com.mtx.family.entity.Merchant;
import com.mtx.family.entity.Order;
import com.mtx.family.mapper.MerchantMapper;
import com.mtx.family.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class OrderService extends BaseService<OrderMapper,Order> {

    @Autowired
    public void setMapper(OrderMapper mapper) {
        super.setMapper(mapper);
    }


    public List<Order> queryOrderForSnnoRepeat(Order order) {
        return this.mapper.selectOrderForSnnoRepeat(order);
    }

    public PageList<Order> queryOrderList(Order order, String startTime, String endTime, PageBounds pageBounds) {
        return this.mapper.selectOrderList(order,startTime,endTime,pageBounds);
    }

    public int sendOrder(Order order) {
        order.setStatus("OUT");
        this.mapper.updatePartial(order);
        return 1;
    }
}
