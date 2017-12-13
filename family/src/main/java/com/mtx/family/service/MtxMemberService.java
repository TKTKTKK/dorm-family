package com.mtx.family.service;

import com.mtx.common.utils.StringUtils;
import com.mtx.family.entity.Machine;
import com.mtx.family.entity.MtxPoint;
import com.mtx.family.entity.MtxProduct;
import com.mtx.wechat.entity.WechatUser;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.service.WpUserService;
import com.mtx.wechat.utils.WechatBindingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
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

    public void insertMemberAndPoint(WpUser wpUser, String machineid,String bindid,String openid) {
        WpUser wpUserTemp = wpUserService.getWpUser(openid);
        if (wpUserTemp == null || StringUtils.isBlank(wpUserTemp.getUuid())) {
            Machine machine = new Machine();
            MtxProduct product = new MtxProduct();
            MtxPoint point = new MtxPoint();
            List<MtxProduct> productList = new ArrayList<MtxProduct>();
            WechatUser wechatUser = WechatBindingUtil.getWechatUser(bindid, openid);
            if(wechatUser!=null){
                wpUser.setNickname(wechatUser.getNickname());
                wpUser.setHeadimgurl(wechatUser.getHeadimgurl());
            }
            wpUser.setIfauth("Y");
            wpUserService.insert(wpUser);
            if (StringUtils.isNotBlank(machineid)) {
                point.setMachineid(machineid);
                machine.setUuid(machineid);
            }
            point.setUserid(wpUser.getUuid());
            machine = machineService.queryForObjectByPk(machine);
            if (machine != null) {
                product.setModel(machine.getMachinemodel());
                productList = mtxProductService.queryForList(product);
                if (productList.size() > 0) {
                    int p;
                    double price = productList.get(0).getPrice();
                    p = (int) price;
                    point.setPoints(p);
                    wpUser.setPoints(p);
                    mtxPointService.insert(point);
                    wpUserService.updatePartial(wpUser);
                }
            }

        }
    }
}
