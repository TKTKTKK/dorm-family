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

    public PageList<Order> queryOrderList(Order order, String ifHqUser, String startTime, String endTime, PageBounds pageBounds) {
        return this.mapper.selectOrderList(order,ifHqUser,startTime,endTime,pageBounds);
    }

    public int sendOrder(Order order) {
        order.setStatus("NEW");
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
        Machine tempMachine = new Machine();
        tempMachine.setMachinemodel(machine.getMachinemodel());
        tempMachine.setMachineno(machine.getMachineno());
        tempMachine.setEngineno(machine.getEngineno());

        List<Machine> machineList = machineMapper.select(tempMachine);
        if(null != machineList && machineList.size() > 0){
            if(StringUtils.isNotBlank(machineList.get(0).getOrderid())){
                Order tempOrder = new Order();
                tempOrder.setUuid(machineList.get(0).getOrderid());
                tempOrder = this.mapper.retrieveByPk(tempOrder);
                returnMsg = "机器已在订单"+tempOrder.getSnno()+"内！";
            }else{
                machine = machineList.get(0);
                machine.setOrderid(orderId);
                machineMapper.updatePartial(machine);
            }
        }else{
            machine.setOrderid(orderId);
            machine.setType("MACHINE");
            machineMapper.insert(machine);
        }
        Order order = new Order();
        order.setUuid(orderId);
        order = this.mapper.retrieveByPk(order);
        order.setStatus("INPLAN");
        this.mapper.updatePartial(order);

        return returnMsg;

        /*List<Machine> machineNoRepeatList = machineMapper.selectMachineForMachineNoRepeat(machine);
        List<Machine> engineNoRepeatList = machineMapper.selectMachineForEngineNoRepeat(machine);
        if(null!=machineNoRepeatList && null!=engineNoRepeatList && machineNoRepeatList.size()>0 && engineNoRepeatList.size()>0){
            Machine noRepeatMachine = machineNoRepeatList.get(0);
            Machine engineNoRepeatMachine = engineNoRepeatList.get(0);
            if(noRepeatMachine.getUuid().equals(engineNoRepeatMachine.getUuid())){
                if(StringUtils.isNotBlank(noRepeatMachine.getOrderid())){
                    returnMsg = "机器"+noRepeatMachine.getMachineno()+"已在订单内！";
                }else{
                    noRepeatMachine.setOrderid(orderId);
                    machineMapper.updatePartial(noRepeatMachine);
                }
            }
        }else if(machineNoRepeatList.size() == 0 && engineNoRepeatList.size()==0){
            machine.setOrderid(orderId);
            machineMapper.insert(machine);
        }else{
            returnMsg = "机器号与发动机号不匹配！";
        }*/
    }

    public int deleteMachineForOrder(String machineId) {
        Machine tempMachine = new Machine();
        tempMachine.setUuid(machineId);
        Machine machine = machineMapper.retrieveByPk(tempMachine);
        machine.setOrderid(null);
        machineMapper.update(machine);
        return 1;
    }

    public int finishOrder(Order order) {
        order.setStatus("FILED");
        this.mapper.updatePartial(order);
        return 1;
    }

    public int finishAddMachine(Order order) {
        order.setStatus("INLOGISTICS");
        this.mapper.updatePartial(order);
        return 1;
    }

    public List<Order> queryOrderListForHomeData(Order order) {
        return this.mapper.selectOrderListForHomeData(order);
    }
}
