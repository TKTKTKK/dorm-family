package com.dorm.wechat.service;


import com.dorm.common.base.BaseService;
import com.dorm.common.entity.PlatformUser;
import com.dorm.common.mapper.PlatformUserMapper;
import com.dorm.common.utils.CacheUtils;
import com.dorm.common.utils.StringUtils;
import com.dorm.common.utils.UserUtils;
import com.dorm.wechat.WechatConstants;
import com.dorm.wechat.entity.admin.WechatBinding;
import com.dorm.wechat.mapper.WechatBindingMapper;
import com.dorm.wechat.utils.AdvancedUtil;
import com.dorm.wechat.utils.WechatBindingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by wensheng on 12/10/2014.
 */
@Service
@Transactional
public class WechatBindingService extends BaseService<WechatBindingMapper,WechatBinding> {

    @Autowired
    public void setMapper(WechatBindingMapper mapper) {
        super.setMapper(mapper);
    }

    @Autowired
    private PlatformUserMapper platformUserMapper;

    @Value("${bindid}")
    private String bindid;

    public String getBindid() {
        return bindid;
    }

    /**
     * 绑定微信公众号
     * @param wechatBinding
     */
    public void bindingPublicAccount(WechatBinding wechatBinding){
        insert(wechatBinding);
        PlatformUser platformUser = new PlatformUser();
        platformUser.setUuid(UserUtils.getUserId());
        platformUser = platformUserMapper.retrieveByPk(platformUser);
        platformUser.setBindid(wechatBinding.getUuid());
        platformUserMapper.updatePartial(platformUser);
        UserUtils.putCache(UserUtils.CACHE_USER, platformUser);
    }

    /**
     * 根据微信原始id获取bindid
     * @param toUserName
     * @return
     */
    public String getBindIdByWechatOrigId(String toUserName){
        String bindId = (String)CacheUtils.get(WechatConstants.ORIGID_BIND_MAP_CACHE,toUserName);
        if(StringUtils.isBlank(bindId)){
            WechatBinding wechatBinding = new WechatBinding();
            wechatBinding.setWechatorigid(toUserName);
            List<WechatBinding> wechatBindings = queryForList(wechatBinding);
            wechatBinding = wechatBindings.get(0);
            CacheUtils.put(WechatConstants.ORIGID_BIND_MAP_CACHE,toUserName,wechatBinding.getUuid());
            return wechatBinding.getUuid();
        }else{
            return bindId;
        }

    }

    /**
     * 根据bindid获取token
     * @param bindid
     * @return
     */
    public String getTokenByBindid(String bindid){
        WechatBinding wechatBinding = getWechatBindingByBindId(bindid);
        return wechatBinding.getToken();
    }

    /**
     * 根据当前登录用户获取WechatBinding
     * 如果cache中没有则从数据库中查询
     * 以及wechatbinding放入cache
     * @return
     */
    public WechatBinding getWechatBindingByUser(){
        String bindId = UserUtils.getUserBindId();
        if(StringUtils.isEmpty(bindId)){
            return null;
        }else{
            return getWechatBindingByBindId(bindId);
        }
    }

    /**
     * 根据bindId获取wechatBinding
     * @param bindId
     * @return
     */
    public WechatBinding getWechatBindingByBindId(String bindId) {
        WechatBinding wechatBinding = (WechatBinding) CacheUtils.get(WechatConstants.BIND_DETAILS_CACHE, bindId);
        if (wechatBinding == null) {
            wechatBinding = new WechatBinding();
            wechatBinding.setUuid(bindId);
            wechatBinding = queryForObjectByPk(wechatBinding);
            if (wechatBinding != null) {
                CacheUtils.put(WechatConstants.BIND_DETAILS_CACHE, wechatBinding.getUuid(), wechatBinding);
            }
        }
        return wechatBinding;
    }

    /**
     * 根据appId获取wechatBinding
     * @param appId
     * @return
     */
    public WechatBinding getWechatBindingByAppId(String appId) {
        WechatBinding wechatBinding = (WechatBinding) CacheUtils.get(WechatConstants.BIND_DETAILS_CACHE, appId);
        if (wechatBinding == null && StringUtils.isNotBlank(appId)) {
            wechatBinding = new WechatBinding();
            wechatBinding.setAppid(appId);
            List<WechatBinding> wechatBindingList = queryForList(wechatBinding);
            if (wechatBindingList != null && wechatBindingList.size() > 0) {
                wechatBinding = wechatBindingList.get(0);
                CacheUtils.put(WechatConstants.BIND_DETAILS_CACHE, appId, wechatBinding);
            }
        }
        return wechatBinding;
    }

    /**
     * 根据appId获取wechatBinding 不使用cache
     * @param appId
     * @return
     */
    public WechatBinding getWechatBindingByAppIdNoCache(String appId) {
            WechatBinding wechatBinding = new WechatBinding();
            wechatBinding.setAppid(appId);
            List<WechatBinding> wechatBindingList = queryForList(wechatBinding);
            if (wechatBindingList != null && wechatBindingList.size() > 0) {
                wechatBinding = wechatBindingList.get(0);
            }
        return wechatBinding;
    }

    /**
     * 上传商户LOGO
     * @param logoname
     */
    public String updateBrandLogo(String logoname){

        // 调用接口获取access_tokn
        String at = WechatBindingUtil.getAccessToken();

        String requestUrl = WechatConstants.WECHAT_UPLOAD_IMG_URL;
        requestUrl = requestUrl.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,at);
        Map map = AdvancedUtil.httpsUploadRequest(requestUrl, logoname, Map.class);
        System.out.println(map.get("url"));

        return String.valueOf(map.get("url"));
    }

    /**
     * 查询用户对应的公众号信息
     * @return
     */
    public List<WechatBinding> queryWechatBindingForUser(){
        String userid = UserUtils.getUserId();
        List<WechatBinding> wechatBindingList = mapper.selectWechatBindingForUser(userid);
        if(null == wechatBindingList || wechatBindingList.size() == 0){
            WechatBinding wechatBinding = new WechatBinding();
            wechatBinding.setOrderby("createon");
            wechatBindingList = queryForList(wechatBinding);
        }
        return wechatBindingList;
    }


}
