package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.utils.StringUtils;
import com.mtx.common.utils.UserUtils;
import com.mtx.family.entity.Logistics;
import com.mtx.family.entity.Machine;
import com.mtx.family.entity.MtxPoint;
import com.mtx.family.entity.MtxUserMachine;
import com.mtx.family.mapper.LogisticsMapper;
import com.mtx.family.mapper.MachineMapper;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.service.WpUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MachineService extends BaseService<MachineMapper,Machine> {

    @Autowired
    public void setMapper(MachineMapper mapper) {
        super.setMapper(mapper);
    }
    @Autowired
    private MtxPointService mtxPointService;
    @Autowired
    private MtxUserMachineService mtxUserMachineService;
    @Autowired
    private WpUserService wpUserService;

    public List<Machine> queryMachineForNoRepeat(Machine machine) {
        return this.mapper.selectMachineForMachineNoRepeat(machine);
    }

    public PageList<Machine> queryMachineList(Machine machine, String startDateTimeStr, String endDateTimeStr, PageBounds pageBounds) {
        return this.mapper.selectMachineList(machine,startDateTimeStr,endDateTimeStr,pageBounds);
    }

    public List<Machine> queryMachineByOrderId(String orderId, PageBounds pageBounds) {
        return this.mapper.selectMachineByOrderId(orderId, UserUtils.getUserBindId(),pageBounds);
    }

    public List<Machine> queryMachineListForAuto(String machineno) {

        return this.mapper.selectMachineListForAuto(machineno,UserUtils.getUserBindId());
    }

    public PageList<Machine> queryForListWithPagination(Machine machine, PageBounds pageBounds) {
        return this.mapper.queryForListWithPagination(machine,pageBounds);
    }

    public String addUserMachine(Machine machine, String userid) {
        String message="";
        if(StringUtils.isNotBlank(userid)&&StringUtils.isNotBlank(machine.getMachineno())){
            Machine machineTemp=new Machine();
            machineTemp.setMachineno(machine.getMachineno());
            machine=this.queryForObjectByUniqueKey(machineTemp);
            if(machine!=null){
                MtxUserMachine mtxUserMachine=new MtxUserMachine();
                mtxUserMachine.setUserid(userid);
                mtxUserMachine.setMachineid(machine.getUuid());
                List<MtxUserMachine> mtxUserMachineList=mtxUserMachineService.queryForList(mtxUserMachine);
                if(mtxUserMachineList.size()>0){
                    message="产品已存在！";
                    return message;
                }else{
                    MtxUserMachine mtxUserMachineTemp=new MtxUserMachine();
                    mtxUserMachineTemp.setMachineid(machine.getUuid());
                    List<MtxUserMachine> mtxUserMachineTempList=mtxUserMachineService.queryForList(mtxUserMachineTemp);
                    if(mtxUserMachineTempList.size()<=0){
                        MtxPoint point =new MtxPoint();
                        point.setUserid(userid);
                        point.setName(machine.getMachinename());
                        int p;
                        double pp=machine.getPrice();
                        p=(int)pp;
                        point.setPoints(p);
                        WpUser user=new WpUser();
                        user.setUuid(userid);
                        user=wpUserService.queryForObjectByPk(user);
                        if(user!=null){
                            user.setPoints(user.getPoints()+p);
                        }
                        wpUserService.updatePartial(user);
                        mtxPointService.insert(point);
                    }
                    mtxUserMachine.setType("PARTS");
                    mtxUserMachineService.insert(mtxUserMachine);
                    message="添加成功！";
                    return message;
                }
            }
        }
        message="添加失败！";
        return message;
    }
}
