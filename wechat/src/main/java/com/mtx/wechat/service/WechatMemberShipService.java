package com.mtx.wechat.service;

import com.mtx.wechat.entity.admin.WechatCardCode;
import com.mtx.wechat.entity.admin.WechatMemberShip;
import com.mtx.wechat.entity.param.card.UpdateMemberCard;
import com.mtx.wechat.entity.result.card.UpdateMemberCardResult;
import com.mtx.wechat.mapper.WechatMemberShipMapper;
import com.mtx.wechat.utils.IdGeneratorUtil;
import com.mtx.wechat.utils.WechatBindingUtil;
import com.mtx.common.base.BaseService;
import com.mtx.common.exception.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wensheng on 1/28/2015.
 */
@Service
@Transactional
public class WechatMemberShipService extends BaseService<WechatMemberShipMapper,WechatMemberShip> {

    @Autowired
    public void setMapper(WechatMemberShipMapper mapper) {
        super.setMapper(mapper);
    }
    @Autowired
    private WechatCardCodeService wechatCardCodeService;

    public int activateMemberCard(WechatMemberShip wechatMemberShip) {
        return activateMemberCard(wechatMemberShip, 0);
    }

    /**
     * 生成会员记录，如会员卡号有重复或有其他异常则重试不超过3次
     * @param wechatMemberShip
     * @param tryLimit
     * @return
     */
    public int activateMemberCard(WechatMemberShip wechatMemberShip, int tryLimit) {
        int i = tryLimit;
        wechatMemberShip.setMembershipno(IdGeneratorUtil.generateMemberShipNum());
        try {
            return insert(wechatMemberShip);
        } catch (Exception e) {
            if(i < 3){
                i++;
                activateMemberCard(wechatMemberShip , i);
            }else{
                throw new ServiceException(e);
            }
        }
        return 0;
    }

    /**
     * 根据CodeId & OpenId 查找对应绑定记录
     * @param codeId
     * @param openId
     * @return
     */
    public List<WechatMemberShip> queryBindRecordByCodeAndOpenId(String codeId,String openId){
        WechatMemberShip wechatMemberShip = new WechatMemberShip();
        wechatMemberShip.setCodeid(codeId);
        wechatMemberShip.setOpenid(openId);
        List<WechatMemberShip> memberShipList = queryForList(wechatMemberShip);
        return memberShipList;
    }

    /**
     * 绑定会员卡
     * @param bindId
     * @param cardType
     * @param memberShip
     * @return
     */
    public Map<String,Object> bindMemberCard(String bindId,String cardType,WechatMemberShip memberShip){
        Map<String,Object> returnMap = new HashMap<String, Object>();
        //查询是否已领取会员卡
        WechatCardCode cardCode = wechatCardCodeService.getCodeByBindIdAndOpenId(bindId,memberShip.getOpenid(),cardType);
        if(cardCode != null){
            //查询是否有激活或绑定记录
            List<WechatMemberShip> memberShipList = queryBindRecordByCodeAndOpenId(cardCode.getUuid(),cardCode.getOpenid());
            if(memberShipList.size() <= 0){
                //激活会员卡
                memberShip.setCodeid(cardCode.getUuid());
                activateMemberCard(memberShip);
                returnMap.put("status",1);
            }else {
                returnMap.put("status",0);
            }
        }else {
            returnMap.put("status",-1);
        }
        return  returnMap;
    }


    /**
     * 会员卡交易，通知微信记录积分/余额变化，并同步至系统数据库
     * @param bindId
     * @param updateMemberCard
     * @param wechatMemberShip
     * @return
     */
    public int consumeMemberCard(String bindId, UpdateMemberCard updateMemberCard, WechatMemberShip wechatMemberShip) {
        UpdateMemberCardResult updateMemberCardResult = WechatBindingUtil.updateMemberCard(bindId, updateMemberCard);
        wechatMemberShip.setBonus(updateMemberCardResult.getResult_bonus());
        wechatMemberShip.setBalance(updateMemberCardResult.getResult_balance());
        return updatePartial(wechatMemberShip);
    }

    /**
     * 更新个人信息
     * @param param
     * @param openId
     * @return
     */
    public Map<String,Object> completeUserInfo(WechatMemberShip param,String openId){
        Map<String, Object> returnMap = new HashMap<String, Object>();
        WechatMemberShip wechatMemberShip = new WechatMemberShip();
        wechatMemberShip.setOpenid(openId);
        WechatMemberShip query = queryForObjectByUniqueKey(wechatMemberShip);
        if(query != null) {
            try {
                query.setEmail(param.getEmail());
                query.setAddress(param.getAddress());
                update(query);
                returnMap.put("status", true);
            } catch (Exception e) {
                returnMap.put("status", false);
            }
        }else {
            returnMap.put("status", false);
        }
        return returnMap;
    }

    /**
     * 查询会员个人信息
     * @param openId
     * @return
     */
    public Map<String,Object> getMemberInfo(String openId){
        Map<String, Object> returnMap = new HashMap<String, Object>();
        WechatMemberShip wechatMemberShip = new WechatMemberShip();
        wechatMemberShip.setOpenid(openId);
        WechatMemberShip memberShip = queryForObjectByUniqueKey(wechatMemberShip);
        returnMap.put("member",memberShip);
        return returnMap;
    }

}
