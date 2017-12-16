package com.mtx.common.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.entity.PlatformRole;
import com.mtx.common.entity.PlatformUser;
import com.mtx.common.entity.PlatformUserRole;
import com.mtx.common.mapper.PlatformRoleMapper;
import com.mtx.common.mapper.PlatformUserMapper;
import com.mtx.common.mapper.PlatformUserRoleMapper;
import com.mtx.common.utils.Digests;
import com.mtx.common.utils.Encodes;
import com.mtx.common.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class PlatformUserService  extends BaseService<PlatformUserMapper,PlatformUser> {

    public static final String HASH_ALGORITHM = "SHA-1";
    public static final int HASH_INTERATIONS = 1024;
    public static final int SALT_SIZE = 8;

    @Autowired
    public void setMapper(PlatformUserMapper mapper) {
        super.setMapper(mapper);
    }
    @Autowired
    private PlatformRoleMapper platformRoleMapper;
    @Autowired
    private PlatformUserRoleMapper platformUserRoleMapper;


    /**
     * @param UserName
     * @return
     */
    public PlatformUser getPlatformUserByUserName(String UserName){
        PlatformUser platformUser = new PlatformUser();
        platformUser.setUsername(UserName);
        return queryForObjectByUniqueKey(platformUser);
    }

    /**
     *
     * @param userid
     * @return
     */
    public List<PlatformRole> getUserRoleList(String userid){
        return platformRoleMapper.getUserRoleList(userid);
    }

    /**
     *
     * @param platformUser
     * @return
     */
    public int registerPlatformUser(PlatformUser platformUser) {
        platformUser.setPlainpassword(platformUser.getPassword());
        String password= entryptPassword(platformUser.getPassword());
        platformUser.setPassword(password);
        PlatformRole defaultRole = new PlatformRole();
        defaultRole.setRolekey("WP_SUPER");
        defaultRole = platformRoleMapper.retrieveByUniqueKey(defaultRole);
        insert(platformUser);
        PlatformUserRole platformUserRole = new PlatformUserRole();
        platformUserRole.setUserid(platformUser.getUuid());
        platformUserRole.setRoleid(defaultRole.getUuid());
        return platformUserRoleMapper.insert(platformUserRole);
    }

    /**
     * @param Id
     * @return
     */
    public PlatformUser getPlatformUserById(String Id){
        PlatformUser platformUser = new PlatformUser();
        platformUser.setUuid(Id);
        return queryForObjectByPk(platformUser);
    }

    /**
     * 生成安全的密码，生成随机的16位salt并经过1024次 sha-1 hash
     */
    private static String entryptPassword(String plainPassword) {
        byte[] salt = Digests.generateSalt(SALT_SIZE);
        byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt, HASH_INTERATIONS);
        return Encodes.encodeHex(salt)+Encodes.encodeHex(hashPassword);
    }

    /**
     * 修改密码
     * @param oldPwd
     * @param newPwd
     * @return
     */
    public boolean changPassword(String oldPwd,String newPwd){
        boolean changed = false;
        PlatformUser platformUser = UserUtils.getUser();
        if(platformUser != null){
            platformUser = getPlatformUserById(platformUser.getUuid());
            byte[] salt = Encodes.decodeHex(platformUser.getPassword().substring(0, 16));
            byte[] hashPassword = Digests.sha1(oldPwd.getBytes(), salt, HASH_INTERATIONS);
            if(platformUser.getPassword().equals(Encodes.encodeHex(salt)+Encodes.encodeHex(hashPassword))){
                String newPassword = entryptPassword(newPwd);
                platformUser.setPassword(newPassword);
                update(platformUser);
                changed = true;
            }
        }
        return changed;
    }

    /**
     * 查询该bindid下的用户
     * @return
     */
    public PageList<PlatformUser> selectNonSuperUsers(String topAccount, String merchantid, PageBounds pageBounds, String username, String name){
        PlatformUser platformUser = new PlatformUser();
        platformUser.setBindid(UserUtils.getUserBindId());
        platformUser.setUuid(UserUtils.getUserId());
        platformUser.setMerchantid(merchantid);
        platformUser.setUsername(username);
        platformUser.setName(name);
        return mapper.selectNonSuperUsers(platformUser,topAccount, pageBounds);
    }

    /**
     * 根据职位、小区、bindid查询用户信息
     * @param platformUser
     * @return
     */
    public List<PlatformUser> selectUsersForTitle(PlatformUser platformUser){
        return mapper.selectUsersForTitle(platformUser);
    }

    /**
     * 查询小区的负责人
     * @param communityid
     * @return
     */
    public List<PlatformUser> selectManagersByCommunityid(String communityid, String bindid){
        return mapper.selectManagersByCommunityid(communityid, bindid);
    }

    /**
     * 根据职位、小区、bindid查询逐层上报的用户信息
     * @param platformUser
     * @return
     */
    public List<PlatformUser> selectUsersForStep(PlatformUser platformUser){
        return mapper.selectUsersForStep(platformUser);
    }

    /**
     * 管理员创建用户
     * 根据配置同步用户信息至工作流引擎
     * @param platformUser
     */
    public void createUser(PlatformUser platformUser){
        String password = entryptPassword(platformUser.getPassword());
        platformUser.setPassword(password);
        mapper.insert(platformUser);
    }


    /**
     * 管理员删除用户
     * 根据配置同步用户信息至工作流引擎
     * @param platformUser
     */
    public void deleteUser(PlatformUser platformUser){
        mapper.delete(platformUser);
    }


    public List<PlatformUser> queryUsersByRole(String bindid, String rolename){
        return mapper.selectBindUserByRole(bindid, rolename);
    }

    /**
     * 查询当前小区下的管理人员
     * @param communityid
     * @param bindid
     * @return
     */
    public List<PlatformUser> queryManagersByCurrentCommunity(String communityid, String bindid){
        return mapper.selectManagersByCurrentCommunityid(communityid, bindid);
    }

    /**
     * 根据经销商id查询维修人员
     * @return
     */
    public List<PlatformUser> queryWorkersByMerchantId(String merchantId){
        return mapper.selectWorkersByMerchantId(merchantId);
    }

    /**
     * 根据角色和小区查询用户列表
     * @param bindid
     * @param rolename
     * @return
     */
    public List<PlatformUser> queryUsersByRoleAndCommunity(String bindid, String communityid, String rolename){
        return mapper.selectUserByRole(bindid, communityid, rolename);
    }

    /**
     * 根据小区id统计一般模式工作人员维修数据
     * @param bindId
     * @param communityId
     * @param pageBounds
     * @return
     */
    public PageList<PlatformUser> queryNormalRepairWorkersStatistic(String communityId, String bindId, PageBounds pageBounds){
        return mapper.selectNormalRepairWorkersStatistic(communityId, bindId, pageBounds);
    }

    /**
     * 管家角色列表查询用户
     * @param bindId
     * @param communityId
     * @param roleArr
     * @return
     */
    public List<PlatformUser> queryUserByRoleList(String bindId, String communityId, String[] roleArr){
        return mapper.selectUserByRoleList(bindId, communityId, roleArr);
    }

    /**
     * 查询已有的职位列表
     * @param bindId
     * @param platformUserTitle
     * @return
     */
    public List<String> queryPlatformUserTitleDropdownList(String bindId, String platformUserTitle) {
        return mapper.selectPlatformUserTitleDropdownList(bindId,platformUserTitle);
    }

    public String resetPassword(PlatformUser platformUser) {
        String password= entryptPassword(platformUser.getPassword());
        platformUser.setPassword(password);
        this.mapper.updatePartial(platformUser);
        return "Y";
    }

    public List<PlatformUser> queryExpressCreatePerson(String communityId) {
        return mapper.selectExpressCreatePerson(UserUtils.getUserBindId(),communityId);
    }
}
