package com.mtx.wechat.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.entity.PlatformUser;
import com.mtx.common.service.PlatformUserService;
import com.mtx.common.utils.StringUtils;
import com.mtx.wechat.entity.WechatUser;
import com.mtx.wechat.entity.WechatUserInfo;
import com.mtx.wechat.mapper.WechatUserInfoMapper;
import com.mtx.wechat.utils.WechatBindingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class WechatUserInfoService extends BaseService<WechatUserInfoMapper,WechatUserInfo> {
    @Autowired
    public void setMapper(WechatUserInfoMapper mapper) {
        super.setMapper(mapper);
    }
    @Autowired
    private PlatformUserService platformUserService;
    /**
     * 根据openid查找用户信息
     * @param openId
     * @return
     */
    public WechatUserInfo queryUserInfoByOpenId(String openId){
        WechatUserInfo userInfo = new WechatUserInfo();
        userInfo.setOpenid(openId);
        userInfo = mapper.retrieveByUniqueKey(userInfo);
        return userInfo;
    }


    public void batchInsert(List<WechatUserInfo> list){
        mapper.batchInsert(list);
    }

    /**
     * 查询STAFF的用户信息
     * @param wechatUserInfo
     * @param pageBounds
     * @return
     */
    public PageList<WechatUserInfo> selectWechatUserInfoForStaff(WechatUserInfo wechatUserInfo,PageBounds pageBounds){
        return mapper.selectWechatUserInfoForStaff(wechatUserInfo, pageBounds);
    }

    public PageList<WechatUserInfo> selectWechatUserInfoForStaff(WechatUserInfo wechatUserInfo){
        return mapper.selectWechatUserInfoForStaff(wechatUserInfo);
    }

    public PageList<WechatUserInfo> queryWechatUserInfoForPageList(WechatUserInfo wechatUserInfo, String ifsubscribe, String ifCreateAccount, PageBounds pageBounds) {
        return mapper.selectWechatUserInfoForPageList(wechatUserInfo,ifsubscribe,ifCreateAccount,pageBounds);
    }

    public WechatUserInfo queryUserInfoAndStatus(WechatUserInfo wechatUserInfo) {
        return mapper.selectUserInfoAndStatus(wechatUserInfo).get(0);
    }

    public int deleteWechatUserInfos(String wechatUserInfoIdsStr) {
        WechatUserInfo wechatUserInfo = new WechatUserInfo();
        String[] wechatUserInfoIds = wechatUserInfoIdsStr.split(",");
        for(String wechatUserInfoId : wechatUserInfoIds){
            wechatUserInfo.setUuid(wechatUserInfoId);
            mapper.delete(wechatUserInfo);
        }
        return 1;
    }

    public String checkwechatUserInfoIfBind(String wechatUserInfoIdsStr) {
        WechatUserInfo wechatUserInfo = new WechatUserInfo();
        PlatformUser platformUser = new PlatformUser();
        String resultStr = "";
        String[] wechatUserInfoIds = wechatUserInfoIdsStr.split(",");
        for(String wechatUserInfoId : wechatUserInfoIds){
            wechatUserInfo.setUuid(wechatUserInfoId);
            wechatUserInfo = this.queryForObjectByPk(wechatUserInfo);
            platformUser.setOpenid(wechatUserInfo.getOpenid());
            List<PlatformUser> platformUserList = platformUserService.queryForList(platformUser);
            if(null != platformUserList && platformUserList.size()>0){
                if(resultStr == ""){
                    resultStr +=  wechatUserInfo.getName();
                }else{
                    resultStr +=  (","+wechatUserInfo.getName());
                }
            }
        }
        return resultStr;
    }
    public WechatUserInfo getWechatUserInfo(String openid){
        return mapper.getWechatUserInfo(openid);
    }
    public void addStaffInfo(WechatUserInfo wechatUserInfo,String bindid,String openid) {
        WechatUserInfo wechatUserInfoTemp = this.getWechatUserInfo(openid);
        if (wechatUserInfoTemp == null || StringUtils.isBlank(wechatUserInfoTemp.getUuid())) {
            WechatUser wechatUser = WechatBindingUtil.getWechatUser(bindid, openid);
            if(wechatUser!=null){
                wechatUserInfo.setNickname(wechatUser.getNickname());
                wechatUserInfo.setHeadimgurl(wechatUser.getHeadimgurl());
            }
            this.insert(wechatUserInfo);
        }else{
            wechatUserInfoTemp.setName(wechatUserInfo.getName());
            wechatUserInfoTemp.setContactno(wechatUserInfo.getContactno());
            this.updatePartial(wechatUserInfoTemp);
        }
    }
}
