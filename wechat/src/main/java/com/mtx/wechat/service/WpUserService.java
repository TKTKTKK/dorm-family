package com.mtx.wechat.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.utils.CacheUtils;
import com.mtx.common.utils.DateUtils;
import com.mtx.common.utils.StringUtils;
import com.mtx.wechat.entity.WechatUser;
import com.mtx.wechat.entity.WechatUserList;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.mapper.WpUserMapper;
import com.mtx.wechat.utils.WechatBindingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * Created by wensheng on 12/26/2014.
 */
@Service
@Transactional
public class WpUserService extends BaseService<WpUserMapper,WpUser> {

    public static String WP_USER_CACHE = "wpuserCache";
    @Autowired
    private WechatBindingService wechatBindingService;

    @Autowired
    public void setMapper(WpUserMapper mapper) {
        super.setMapper(mapper);
    }


    /**
     *
     * @param bindid
     * @param openid
     * @return
     */
    public void saveWpUser(String bindid,String openid){
        WpUser wpUser = getWpUser(openid);
        if(wpUser == null || StringUtils.isBlank(wpUser.getUuid())){
            WechatUser wechatUser = WechatBindingUtil.getWechatUser(bindid, openid);
            wpUser = new WpUser();
            wpUser.setBindid(bindid);
            wpUser.setOpenid(openid);
            wpUser.setNickname(wechatUser.getNickname());
            wpUser.setHeadimgurl(wechatUser.getHeadimgurl());
            wpUser.setIfauth("N");
            insert(wpUser);
        }
    }


    /**
     *
     * @param openid
     * @return
     */
    public WpUser getWpUser(String openid){
        if(CacheUtils.get(WP_USER_CACHE,openid) != null){
            return (WpUser)CacheUtils.get(WP_USER_CACHE,openid);
        }else{
            WpUser wpUser = new WpUser();
            wpUser.setOpenid(openid);
            wpUser = queryForObjectByUniqueKey(wpUser);
            if (wpUser != null) {
                CacheUtils.put(WP_USER_CACHE,openid,wpUser);
            }
            return wpUser;
        }
    }

    /**
     *
     * 更新用户信息，并更新缓存
     *
     * @param wpUser
     */
    public void RefreshWpUser(WpUser wpUser){
        updatePartial(wpUser);
        CacheUtils.put(WP_USER_CACHE,wpUser.getOpenid(),wpUser);
    }

    /**
     * 同步关注用户信息
     */
    public void synAttentionUserInfo(){
        //获取关注者列表
        WechatUserList wechatUserList = WechatBindingUtil.getAllWechatUsers();
        List<String> allOpenidList = wechatUserList.getData().get("openid");

        //已保存的用户信息
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        Set<String> savedOpenidSet = this.mapper.selectWpUserByBindid(wechatBinding.getUuid());

        //用户表(wp_user)里不存在的openid
        List<WpUser> inexistOpenidList = new ArrayList<WpUser>();

        //找出用户表中不存在的openid
        for(String openid: allOpenidList){
            if(savedOpenidSet.add(openid)){
                WpUser wpUser = new WpUser();
                wpUser.setUuid(StringUtils.getUUID());
                wpUser.setBindid(wechatBinding.getUuid());
                wpUser.setOpenid(openid);
                wpUser.setIfauth("N");
                wpUser.setIfsubscribe("Y");
                String dt = DateUtils.formatSystemDateTimeMillis();
                wpUser.setCreateon(dt);
                wpUser.setCreateby("sys");
                wpUser.setModifyon(dt);
                wpUser.setModifyby("sys");
                wpUser.setVersionno(1);
                wpUser.setDelind("N");
                inexistOpenidList.add(wpUser);
            }
        }

        if(inexistOpenidList.size() > 0){
            //将用户表中不存在的openid批量添加到用户表
            System.out.println("***********start batch insert wpUser***********");
            this.mapper.batchInsertWpUser(inexistOpenidList);
            System.out.println("***********end batch insert wpUser***********");
        }
    }

    /**
     * 查询未认证的用户openid
     * @param bindid
     * @return
     */
    public List<String> queryUnautherizedWpUser(String bindid, String mediaid){
        return this.mapper.selectUnautherizedWpUser(bindid, mediaid);
    }

    /**
     * 查询所有关注用户信息（从wp_user表中查询）
     * @param bindid
     * @param pageBounds
     * @return
     */
    public PageList<WpUser> queryAllWpUsersByBindid(String bindid, PageBounds pageBounds){
        return this.mapper.selectAllWpUsersByBindid(bindid, pageBounds);
    }
}
