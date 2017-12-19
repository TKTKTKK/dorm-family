package com.mtx.family.service;

import com.mtx.common.utils.StringUtils;
import com.mtx.family.entity.Machine;
import com.mtx.family.entity.MtxPoint;
import com.mtx.family.entity.MtxProduct;
import com.mtx.family.entity.MtxUserMachine;
import com.mtx.wechat.entity.WechatUser;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.service.WpUserService;
import com.mtx.wechat.utils.WechatBindingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxMemberService {

    @Autowired
    private MachineService machineService;
    @Autowired
    private MtxProductService mtxProductService;
    @Autowired
    private MtxPointService mtxPointService;
    @Autowired
    private WpUserService wpUserService;
    @Autowired
    private MtxUserMachineService mtxUserMachineService;

    public void insertMemberAndPoint(WpUser wpUser, WpUser wpUserTemp,String machineid) {
        Machine machine = new Machine();
        MtxPoint point = new MtxPoint();
        MtxUserMachine userMachine=new MtxUserMachine();
        MtxUserMachine userMachineTemp=new MtxUserMachine();
        wpUserTemp.setName(wpUser.getName());
        wpUserTemp.setContactno(wpUser.getContactno());
        wpUserTemp.setProvince(wpUser.getProvince());
        wpUserTemp.setCity(wpUser.getCity());
        wpUserTemp.setDistrict(wpUser.getDistrict());
        wpUserTemp.setAddress(wpUser.getAddress());
        wpUserTemp.setIfauth("Y");
        if (StringUtils.isNotBlank(machineid)) {
            machine.setUuid(machineid);
        }
        point.setUserid(wpUserTemp.getUuid());
        userMachine.setUserid(wpUserTemp.getUuid());
        machine = machineService.queryForObjectByPk(machine);
        if (machine != null) {
            userMachine.setMachineid(machine.getUuid());
            userMachineTemp.setMachineid(machine.getUuid());
            List<MtxUserMachine> userMachineTempList=mtxUserMachineService.queryForList(userMachineTemp);
            if(userMachineTempList.size()<=0){
                int p=0;
                if(machine.getPrice()!=null){
                    double price = machine.getPrice();
                    p = (int) price;
                }
                wpUserTemp.setPoints(p);
                point.setPoints(p);
                point.setName(machine.getMachinename());
                mtxPointService.insert(point);
                wpUserService.updatePartial(wpUserTemp);
            }
            mtxUserMachineService.insert(userMachine);
        }
    }
}
