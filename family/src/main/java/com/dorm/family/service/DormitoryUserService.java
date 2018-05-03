package com.dorm.family.service;

import com.dorm.common.base.BaseService;
import com.dorm.common.entity.PlatformUser;
import com.dorm.common.entity.PlatformUserRole;
import com.dorm.common.service.PlatformUserRoleService;
import com.dorm.common.service.PlatformUserService;
import com.dorm.common.utils.UserUtils;
import com.dorm.family.entity.DormitoryUser;
import com.dorm.family.mapper.DormitoryUserMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class DormitoryUserService extends BaseService<DormitoryUserMapper,DormitoryUser> {

    @Autowired
    public void setMapper(DormitoryUserMapper mapper) {
        super.setMapper(mapper);
    }

    @Autowired
    private PlatformUserService platformUserService;
    @Autowired
    private PlatformUserRoleService platformUserRoleService;


    public void modifyUserInfo(PlatformUser platformUser) {
        platformUserService.updatePartial(platformUser);

        //保存用户角色关系
        saveUserRole(platformUser);
    }

    private void saveUserRole(PlatformUser platformUser) {
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

    public void addUserInfo(PlatformUser platformUser) {
        platformUser.setBindid(UserUtils.getUserBindId());
        platformUserService.createUser(platformUser);

        String currentUserId = UserUtils.getUserId();
        DormitoryUser dormitoryUser = new DormitoryUser();
        dormitoryUser.setUserid(currentUserId);
        List<DormitoryUser> dormitoryUserList = this.mapper.select(dormitoryUser);
        if(null != dormitoryUserList && dormitoryUserList.size() > 0){
            for(DormitoryUser tempDormitoryUser : dormitoryUserList){
                DormitoryUser dormitoryUserForAdd = new DormitoryUser();
                dormitoryUserForAdd.setUserid(platformUser.getUuid());
                dormitoryUserForAdd.setDormitoryid(tempDormitoryUser.getDormitoryid());
                this.mapper.insert(dormitoryUserForAdd);
            }
        }

        //保存用户角色关系
        saveUserRole(platformUser);
    }

    public PageList<DormitoryUser> getDormitoryUserListByUserId(String userId, PageBounds pageBounds) {
        return this.mapper.selectDormitoryUserListByUserId(userId, pageBounds);
    }

    public DormitoryUser getDormitoryUserInfoById(String dormitoryUserId) {
        return this.mapper.selectDormitoryUserInfoById(dormitoryUserId);
    }

    public int deleteUserInfo(String userId, String dormitoryid) {
        //查询当前用户共几条dormitoryUser记录
        DormitoryUser dormitoryUser = new DormitoryUser();
        dormitoryUser.setUserid(userId);
        List<DormitoryUser> dormitoryUserList = this.queryForList(dormitoryUser);
        //没有，删除user-role, user
        if(null == dormitoryUserList || dormitoryUserList.size() == 0){
            platformUserRoleService.deleteUserRoleByUserId(userId);
            PlatformUser platformUser = new PlatformUser();
            platformUser.setUuid(userId);
            platformUserService.deleteUser(platformUser);
        }else if(dormitoryUserList.size() == 1){
            //一条，删除dormitoryUser， user-role, user
            this.deleteDormitoryUser(dormitoryUser);
            platformUserRoleService.deleteUserRoleByUserId(userId);
            PlatformUser platformUser = new PlatformUser();
            platformUser.setUuid(userId);
            platformUserService.deleteUser(platformUser);
        }else{
            //多于一条，dormitory
            dormitoryUser.setDormitoryid(dormitoryid);
            this.deleteDormitoryUser(dormitoryUser);
        }

        return 1;
    }

    private int deleteDormitoryUser(DormitoryUser dormitoryUser) {
        return this.mapper.deleteDormitoryUser(dormitoryUser);
    }
}
