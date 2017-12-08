package com.mtx.wechat.utils;


import com.mtx.common.utils.ApplicationContextUtil;
import com.mtx.wechat.entity.admin.WechatTm;
import com.mtx.wechat.entity.admin.WechatTmMaster;
import com.mtx.wechat.service.WechatTmMasterService;
import com.mtx.wechat.service.WechatTmService;

import java.util.List;

public class WechatMasterUtil {
    private static WechatTmMasterService wechatTmMasterService = ApplicationContextUtil.getBean(WechatTmMasterService.class);
    private static WechatTmService wechatTmService = ApplicationContextUtil.getBean(WechatTmService.class);

    /**
     * 根据模板名称查询shortid
     * @param tmName
     * @return
     */
    public static String queryTmIdShortByName(String tmName){
        WechatTmMaster wechatTmMaster = new WechatTmMaster();
        wechatTmMaster.setTmname(tmName);
        List<WechatTmMaster> wechatTmMasterList = wechatTmMasterService.queryForList(wechatTmMaster);
        String tmIdShort = "";
        if(null != wechatTmMasterList && wechatTmMasterList.size() > 0){
            tmIdShort = wechatTmMasterList.get(0).getTmidshort();
        }
        return tmIdShort;
    }

    /**
     * 根据bindid以及图文类型查找
     * @param bindid
     * @param tmType
     * @return
     */
    public static String getTMByTypeAndBindid(String bindid,String tmType){
        WechatTm wechatTm = new WechatTm();
        wechatTm.setBindid(bindid);
        wechatTm.setTmtype(tmType);
        wechatTm = wechatTmService.queryForObjectByUniqueKey(wechatTm);
        if(wechatTm != null){
            return wechatTm.getTmid();
        }else{
            return null;
        }
    }
}
