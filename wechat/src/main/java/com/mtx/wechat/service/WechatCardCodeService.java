package com.mtx.wechat.service;

import com.mtx.wechat.entity.admin.WechatCardCode;
import com.mtx.wechat.mapper.WechatCardCodeMapper;
import com.mtx.common.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by wensheng on 1/16/2015.
 */
@Service
@Transactional
public class WechatCardCodeService extends BaseService<WechatCardCodeMapper,WechatCardCode> {
    @Autowired
    public void setMapper(WechatCardCodeMapper mapper) {
        super.setMapper(mapper);
    }

    /**
     * 获取会员卡code
     * @param bindId
     * @param openId
     * @param cardType
     * @return
     */
    public WechatCardCode getCodeByBindIdAndOpenId(String bindId,String openId,String cardType){
        List<WechatCardCode> cardCodeList = mapper.selectCodeByBindIdAndOpenIdList(bindId,openId,cardType);
        if(cardCodeList.size()>0){
            return cardCodeList.get(0);
        }else{
            return null;
        }
    }
}
