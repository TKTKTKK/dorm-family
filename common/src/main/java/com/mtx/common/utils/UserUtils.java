package com.mtx.common.utils;

import com.mtx.common.entity.PlatformPermit;
import com.mtx.common.entity.PlatformRole;
import com.mtx.common.service.PlatformRoleService;
import com.mtx.common.service.PlatformUserService;
import com.mtx.common.entity.PlatformUser;
import com.mtx.common.security.PlatformAuthorizingRealm;
import com.mtx.common.service.PlatformPermitService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.UnavailableSecurityManagerException;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 用户工具类
 */


public class UserUtils {

    private static Logger logger = LoggerFactory.getLogger(UserUtils.class);

    private static PlatformUserService platformUserService = ApplicationContextUtil.getBean(PlatformUserService.class);
    private static PlatformRoleService platformRoleService = ApplicationContextUtil.getBean(PlatformRoleService.class);
    private static PlatformPermitService platformPermitService = ApplicationContextUtil.getBean(PlatformPermitService.class);

    public static final String CACHE_USER = "CACHE_USER";

    public static PlatformUser getUser(){
        PlatformUser platformUser = (PlatformUser)getCache(CACHE_USER);
        if (platformUser == null){
            try{
                Subject subject = SecurityUtils.getSubject();
                PlatformAuthorizingRealm.Principal principal = (PlatformAuthorizingRealm.Principal)subject.getPrincipal();
                if (principal!=null){
                    platformUser = platformUserService.getPlatformUserById(principal.getId());
                    if(platformUser!= null){
                        platformUser.setPassword(null);
                        putCache(CACHE_USER, platformUser);
                    }
                }
            }catch (UnavailableSecurityManagerException e) {
                logger.error(e.getMessage());
            }catch (InvalidSessionException e){
                logger.error(e.getMessage());
            }
        }

        if (platformUser == null){
            platformUser = new PlatformUser();
        }
        return platformUser;
    }

    /**
     *
     * @param isRefresh
     * @return
     */
    public static PlatformUser getUser(boolean isRefresh){
        if (isRefresh){
            removeCache(CACHE_USER);
        }
        return getUser();
    }

    /**
     *
     * @return
     */
    public static String getUserId(){
        PlatformUser platformUser = getUser();
        return StringUtils.isNotBlank(platformUser.getUuid())? platformUser.getUuid() : "guest";
    }


    /**
     *
     * @return
     */
    public static String getUserBindId(){
        PlatformUser platformUser = getUser();
        return StringUtils.isNotBlank(platformUser.getBindid())? platformUser.getBindid() : null;
    }

    /**
     *获取当前用户菜单
     * @return
     */
    public static List<PlatformPermit> getMenuList(){
        String userId = getUserId();
        List<PlatformPermit> menuList = buildMenu(userId,"MENU");
        CacheUtils.put("menuList",menuList);
        return menuList;
    }

    /**
     * 创建菜单结点
     * @param userid
     * @return
     */
    private static List<PlatformPermit> buildMenu(String userid, String permittype){
        //父结点
        //该role下的父结点
        List<PlatformPermit> firstLevelPermitList = platformPermitService.getPermitListByRoleId(userid, null, permittype);

        //获取该role下的所有子结点
        List<PlatformPermit> allChildPermits = platformPermitService.getPermitListByRoleId(userid, "CHILD", permittype);

        for(PlatformPermit permit : firstLevelPermitList){
            //添加子结点
            appendChild(permit, allChildPermits);
        }
        return firstLevelPermitList;
    }

    /**
     * 添加子结点
     * @param parentPermit
     * @param allChildPermits
     */
    private static void appendChild(PlatformPermit parentPermit, List<PlatformPermit> allChildPermits){
        for(PlatformPermit permit : allChildPermits){
            if(permit.getParentpermitid().equals(parentPermit.getUuid())){
                parentPermit.getChildPermits().add(permit);
                //递归添加子结点
                appendChild(permit, allChildPermits);
            }
        }
    }

    /**
     * 根据角色查询权限
     * @param roleId
     * @param permittype
     * @return
     */
    public static List<PlatformPermit> queryPermitListByRoleId(String roleId, String permittype){
        List<PlatformPermit> firstLevelPermitList = platformPermitService.queryPermitListByRoleId(roleId, null, permittype);
        List<PlatformPermit> childPermitList = platformPermitService.queryPermitListByRoleId(roleId, "CHILD", permittype);
        for(PlatformPermit permit: firstLevelPermitList){
            //添加子结点
            appendChild(permit, childPermitList);
        }
        return firstLevelPermitList;
    }

    // ============== User Cache ==============

    public static Object getCache(String key) {
        return getCache(key, null);
    }

    public static Object getCache(String key, Object defaultValue) {
        Object obj = getCacheMap().get(key);
        return obj==null?defaultValue:obj;
    }

    public static void putCache(String key, Object value) {
        getCacheMap().put(key, value);
    }

    public static void removeCache(String key) {
        getCacheMap().remove(key);
    }

    public static Map<String, Object> getCacheMap(){
        Map<String, Object> map = new HashMap<String, Object>();
        try{
            Subject subject = SecurityUtils.getSubject();
            PlatformAuthorizingRealm.Principal principal = (PlatformAuthorizingRealm.Principal)subject.getPrincipal();
            return principal!=null?principal.getCacheMap():map;
        }catch (UnavailableSecurityManagerException e) {
            logger.error(e.getMessage());
        }catch (InvalidSessionException e){
            logger.error(e.getMessage());
        }
        return map;
    }

    /**
     * 根据id查询用户名
     * @param userId
     * @return
     */
    public static String queryUserNameById(String userId){
        PlatformUser user = platformUserService.getPlatformUserById(userId);
        String userName = "";
        if(null != user){
            userName = user.getUsername();
        }
        return userName;
    }

    /**
     *
     * @param roleId
     * @return
     */
    public static String queryRoleById(String roleId){
        PlatformRole role = new PlatformRole();
        role.setUuid(roleId);
        role = platformRoleService.queryForObjectByPk(role);
        String roleName = "";
        if(null != role){
            roleName = role.getRolename();
        }
        return roleName;
    }

    /**
     * 根据id查询用户姓名
     * @param userId
     * @return
     */
    public static String queryNameById(String userId){
        PlatformUser user = platformUserService.getPlatformUserById(userId);
        String name = "";
        if(null != user){
            name = user.getName();
        }
        return name;
    }

    /**
     * 根据用户名查询用户
     * @param userName
     * @return
     */
    public static PlatformUser queryUserByUserName(String userName){
        return platformUserService.getPlatformUserByUserName(userName);
    }



    /**
     * 根据角色查询逐层上报的openids
     * @param bindid
     * @param communityid
     * @param rolekey
     * @return
     */
    public static List<String> queryOpenidsByRole(String bindid, String communityid, String rolekey){
        List<String> openidList = new ArrayList<String>();
        PlatformUser platformUser = new PlatformUser();
        platformUser.setBindid(bindid);
        platformUser.setCommunityid(communityid);
        //角色
        platformUser.setTitle(rolekey);
        List<PlatformUser> platformUserList = platformUserService.selectUsersForStep(platformUser);
        for(PlatformUser pu: platformUserList){
            if(StringUtils.isNotBlank(pu.getOpenid())){
                openidList.add(pu.getOpenid());
            }
        }
        return openidList;
    }

    /**
     * 根据小区和角色查询用户列表
     * @param bindId
     * @param communityId
     * @param roleKey
     * @return
     */
    public static List<PlatformUser> queryUserListByCommunityAndRole(String bindId, String communityId, String roleKey){
        List<PlatformUser> userList = platformUserService.queryUsersByRoleAndCommunity(bindId, communityId, roleKey);
        return userList;
    }

}
