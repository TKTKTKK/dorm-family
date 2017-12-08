package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.utils.StringUtils;
import com.mtx.common.utils.UserUtils;
import com.mtx.family.entity.Machine;
import com.mtx.family.entity.Merchant;
import com.mtx.family.entity.Order;
import com.mtx.family.mapper.MachineMapper;
import com.mtx.family.mapper.MerchantMapper;
import com.mtx.family.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;


@Service
@Transactional
public class OrderService extends BaseService<OrderMapper,Order> {

    @Autowired
    public void setMapper(OrderMapper mapper) {
        super.setMapper(mapper);
    }

    @Autowired
    private MachineMapper machineMapper;


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

    /**
     * 订单添加机器
     * @param orderId
     * @param machine
     */
    public String addMachineForOrder(String orderId, Machine machine) {
        String returnMsg = "";
        List<Machine> machineList = machineMapper.selectMachineForNoRepeat(machine);
        //机器已存在
        if(null != machineList && machineList.size() > 0){
            Machine tempMachine = machineList.get(0);
            if(machineList.size() == 2){
                returnMsg = "机器号与发动机号不匹配！";
            }else if(StringUtils.isNotBlank(tempMachine.getOrderid())){
                returnMsg = "机器"+tempMachine.getMachineno()+"已在订单内！";
            }else{
                tempMachine.setOrderid(orderId);
                machineMapper.updatePartial(tempMachine);
            }
        }else{
            machine.setOrderid(orderId);
            machineMapper.insert(machine);
        }
        return returnMsg;
    }

    public int deleteMachineForOrder(String machineId) {
        Machine tempMachine = new Machine();
        tempMachine.setUuid(machineId);
        Machine machine = machineMapper.retrieveByPk(tempMachine);
        machine.setOrderid(null);
        machineMapper.update(machine);
        return 1;
    }
}
