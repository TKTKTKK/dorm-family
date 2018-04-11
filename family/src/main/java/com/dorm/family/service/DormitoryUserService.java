package com.dorm.family.service;

import com.dorm.common.base.BaseService;
import com.dorm.common.entity.PlatformUser;
import com.dorm.common.entity.PlatformUserRole;
import com.dorm.common.service.PlatformUserRoleService;
import com.dorm.common.service.PlatformUserService;
import com.dorm.common.utils.UserUtils;
import com.dorm.family.entity.Dormitory;
import com.dorm.family.entity.DormitoryUser;
import com.dorm.family.entity.UserMerchant;
import com.dorm.family.mapper.DormitoryMapper;
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
        //当前用户有片区信息时，默认为新创建的用户添加同样片区
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
}
