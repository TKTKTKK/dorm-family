package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.entity.PlatformUser;
import com.mtx.common.entity.PlatformUserRole;
import com.mtx.common.service.PlatformUserRoleService;
import com.mtx.common.service.PlatformUserService;
import com.mtx.common.utils.UserUtils;
import com.mtx.family.entity.UserMerchant;
import com.mtx.family.mapper.UserMerchantMapper;
import com.mtx.common.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserMerchantService extends BaseService<UserMerchantMapper, UserMerchant> {
    @Autowired
    public void setMapper(UserMerchantMapper mapper) {
        super.setMapper(mapper);
    }

    @Autowired
    private PlatformUserService platformUserService;
    @Autowired
    private PlatformUserRoleService platformUserRoleService;

    public int deleteUserMerchant(UserMerchant userMerchant){
        return this.mapper.deleteUserMerchant(userMerchant);
    }

    /**
     * 修改用户信息
     * @param platformUser
     */
    public void modifyUserInfo(PlatformUser platformUser){
        platformUserService.updatePartial(platformUser);

        //保存用户角色关系
        saveUserRole(platformUser);
    }

    /**
     * 保存用户角色关系
     * @param platformUser
     */
    public void saveUserRole(PlatformUser platformUser){
        //根据userid删除用户角色关联
        platformUserRoleService.deleteUserRoleByUserId(platformUser.getUuid());

        //用户角色
        if(null != platformUser.getRoles() && platformUser.getRoles().length > 0){
            for(String roleid : platformUser.getRoles()){
                PlatformUserRole platformUserRole = new PlatformUserRole();
                platformUserRole.setUserid(platformUser.getUuid());
                platformUserRole.setRoleid(roleid);
                platformUserRoleService.createUserRole(platformUserRole);
            }
        }
    }

    /**
     * 添加用户信息
     * @param platformUser
     */
    public void addUserInfo(PlatformUser platformUser){
        platformUser.setBindid(UserUtils.getUserBindId());
        platformUserService.createUser(platformUser);

        String currentUserId = UserUtils.getUserId();
        UserMerchant userMerchant = new UserMerchant();
        userMerchant.setUserid(currentUserId);
        List<UserMerchant> wpUserMerchantList = this.mapper.select(userMerchant);
        //当前用户有片区信息时，默认为新创建的用户添加同样片区
        if(null != wpUserMerchantList && wpUserMerchantList.size() > 0){
            for(UserMerchant tempWpUserMerchant : wpUserMerchantList){
                UserMerchant userMerchantForAdd = new UserMerchant();
                userMerchantForAdd.setUserid(platformUser.getUuid());
                userMerchantForAdd.setMerchantid(tempWpUserMerchant.getMerchantid());
                this.mapper.insert(userMerchantForAdd);
            }
        }

        //保存用户角色关系
        saveUserRole(platformUser);
    }

    /**
     * 删除用户信息
     * @param userId
     */
    public void deleteUserInfo(String userId, String merchantid){
        //查询当前用户共几条user-community记录
        UserMerchant userMerchant = new UserMerchant();
        userMerchant.setUserid(userId);
        List<UserMerchant> userMerchantList = this.queryForList(userMerchant);
        //没有，删除user-role, user
        if(null == userMerchantList || userMerchantList.size() == 0){
            platformUserRoleService.deleteUserRoleByUserId(userId);
            PlatformUser platformUser = new PlatformUser();
            platformUser.setUuid(userId);
            platformUserService.deleteUser(platformUser);
        }else if(userMerchantList.size() == 1){
            //一条，删除user-merchant， user-role, user
            this.deleteUserMerchant(userMerchant);
            platformUserRoleService.deleteUserRoleByUserId(userId);
            PlatformUser platformUser = new PlatformUser();
            platformUser.setUuid(userId);
            platformUserService.deleteUser(platformUser);
        }else{
            //多于一条，只删除当前merchant下对应的user-merchant记录
            userMerchant.setMerchantid(merchantid);
            this.deleteUserMerchant(userMerchant);
        }
    }

    /**
     * 根据用户id查询用户小区关系列表
     * @param userId
     * @param pageBounds
     * @return
     */
    public PageList<UserMerchant> queryUserCommunityListByUserId(String userId, PageBounds pageBounds){
        return this.mapper.selectUserMerchantListByUserId(userId, pageBounds);
    }

    /**
     * 根据id查询用户小区关系信息
     * @return
     */
    public UserMerchant queryUserMerchantInfoById(String userMerchantId){
        return this.mapper.selectUserMerchantInfoById(userMerchantId);
    }
}
