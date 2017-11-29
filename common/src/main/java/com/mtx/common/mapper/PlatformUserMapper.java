package com.mtx.common.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.common.entity.PlatformUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wensheng on 12/10/2014.
 */
@Repository
public interface PlatformUserMapper extends BaseMapper<PlatformUser> {
    public PageList<PlatformUser> selectNonSuperUsers(@Param("platformUser")PlatformUser platformUser,@Param("topAccount") String topAccount, PageBounds pageBounds);

    public List<PlatformUser> selectUsersForTitle(@Param("platformUser")PlatformUser platformUser);

    public List<PlatformUser> selectManagersByCommunityid(@Param("communityid")String communityid, @Param("bindid")String bindid);

    public List<PlatformUser> selectUserByRole(@Param("bindid")String bindid,@Param("communityid")String communityid,@Param("role")String role);

    public List<PlatformUser> selectBindUserByRole(@Param("bindid")String bindid,@Param("role")String role);

    public List<PlatformUser> selectUsersForStep(@Param("platformUser")PlatformUser platformUser);

    public List<PlatformUser> selectUsersForSuppliertype(@Param("platformUser")PlatformUser platformUser,@Param("amyBindid")String amyBindid);

    List<PlatformUser> selectUsersForSpecialHousehold(@Param("platformUser")PlatformUser platformUser, @Param("bindid")String bindid);

    public List<PlatformUser> selectNonSuperUsersForVIP(@Param("platformUser")PlatformUser platformUser);

    List<PlatformUser> selectManagersByCurrentCommunityid(@Param("communityid")String communityid, @Param("bindid")String bindid);

    PageList<PlatformUser> selectWorkersByCommunityId(@Param("communityid")String communityid,
                                                              @Param("bindid")String bindid,
                                                              @Param("repairbpm")String repairbpm,
                                                              PageBounds pageBounds);

    PageList<PlatformUser> selectNormalRepairWorkersStatistic(@Param("communityid")String communityid,
                                                              @Param("bindid")String bindid,
                                                              PageBounds pageBounds);

    List<PlatformUser> selectUserByRoleList(@Param("bindid")String bindid,
                                            @Param("communityid")String communityid,
                                            @Param("roleArr") String[] roleArr);

    List<String> selectPlatformUserTitleDropdownList(@Param("bindId") String bindId,@Param("platformUserTitle") String platformUserTitle);

    List<PlatformUser> selectExpressCreatePerson(@Param("bindId") String bindId,@Param("communityId") String communityId);
}
