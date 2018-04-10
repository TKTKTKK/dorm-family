package com.dorm.family.service;

import com.dorm.family.entity.Machine;
import com.dorm.family.entity.MtxPoint;
import com.dorm.family.entity.MtxProduct;
import com.dorm.family.entity.MtxUserMachine;
import com.dorm.wechat.entity.WpUser;
import com.dorm.wechat.service.WpUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxMemberService {

    @Autowired
    private MtxPointService mtxPointService;
    @Autowired
    private WpUserService wpUserService;
    @Autowired
    private MtxUserMachineService mtxUserMachineService;
    @Autowired
    private MtxProductService mtxProductService;

    public void insertMemberAndPoint(WpUser wpUser, WpUser wpUserTemp,Machine machine) {
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
        wpUserTemp.setPoints(0);
        point.setUserid(wpUserTemp.getUuid());
        userMachine.setUserid(wpUserTemp.getUuid());
        userMachine.setMachineid(machine.getUuid());
        userMachine.setType("MACHINE");
        userMachineTemp.setMachineid(machine.getUuid());
        List<MtxUserMachine> userMachineTempList=mtxUserMachineService.queryForList(userMachineTemp);
        if(userMachineTempList.size()<=0){
            int p=0;
            MtxProduct product=new MtxProduct();
            product.setModel(machine.getMachinemodel());
            product=mtxProductService.queryForObjectByUniqueKey(product);
            if(null!=product && product.getPoints()!=null){
                p=product.getPoints();
            }
            wpUserTemp.setPoints(p);
            point.setPoints(p);
            point.setName(machine.getMachinename()+"("+machine.getMachineno()+")");
            mtxPointService.insert(point);
        }
        wpUserService.updatePartial(wpUserTemp);
        mtxUserMachineService.insert(userMachine);
    }
}
