package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.utils.StringUtils;
import com.mtx.family.entity.Machine;
import com.mtx.family.entity.MtxPoint;
import com.mtx.family.entity.MtxProduct;
import com.mtx.family.entity.MtxUserMachine;
import com.mtx.family.mapper.MtxProductMapper;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.service.WpUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxProductService extends BaseService<MtxProductMapper,MtxProduct> {

    @Autowired
    public void setMapper(MtxProductMapper mapper) {
        super.setMapper(mapper);
    }
    @Autowired
    private MachineService machineService;
    @Autowired
    private MtxPointService mtxPointService;
    @Autowired
    private MtxUserMachineService mtxUserMachineService;
    @Autowired
    private WpUserService wpUserService;

    public PageList<MtxProduct> queryForListWithPagination(MtxProduct obj, PageBounds pageBounds,String flag) {
        return mapper.selectMxtProductList(obj,pageBounds,flag);
    }

    public List<MtxProduct> validModelIsExist(String model, String uuid) {
        return mapper.validModelIsExist(model,uuid);
    }

    public String addUserMachine(Machine machine, String userid) {
        String message="";
        if(StringUtils.isNotBlank(userid)&&StringUtils.isNotBlank(machine.getMachineno())){
            Machine machineTemp=new Machine();
            machineTemp.setMachineno(machine.getMachineno());
            machine=machineService.queryForObjectByUniqueKey(machineTemp);
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
                        point.setPoints(machine.getPrice().intValue());
                        WpUser user=new WpUser();
                        user.setUuid(userid);
                        user=wpUserService.queryForObjectByPk(user);
                        if(user!=null){
                            user.setPoints(user.getPoints()+machine.getPrice().intValue());
                            wpUserService.updatePartial(user);
                        }
                        mtxPointService.insert(point);
                    }
                    mtxUserMachine.setType("MACHINE");
                    mtxUserMachineService.insert(mtxUserMachine);
                    message="添加成功！";
                    return message;
                }
            }
        }
        message="添加失败！";
        return message;
    }

    public List<String> getAllModel() {
        return mapper.getAllModel();
    }
}
