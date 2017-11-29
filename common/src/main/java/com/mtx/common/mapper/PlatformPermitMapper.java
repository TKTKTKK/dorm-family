package com.mtx.common.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.common.entity.PlatformPermit;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlatformPermitMapper extends BaseMapper<PlatformPermit> {

    public List<PlatformPermit> getPermitListByRoleId(@Param("userid") String userid, @Param("parentpermitid") String parentpermitid, @Param("permittype") String permittype);

    public List<PlatformPermit> queryPermitIdByMenuName(@Param("permitname") String permitname);

    public PageList<PlatformPermit> getPermitList( PageBounds pageBounds);

    public PlatformPermit queryPermitIdByMenuId(@Param("permitid") String permitid);

    public List<PlatformPermit> queryPermitList(@Param("parentpermitid") String parentpermitid);

//    public List<PlatformPermit> queryParentPermitList();

    public List<PlatformPermit> queryPermitIdByResource(@Param("permitresource") String permitresource);

    List<PlatformPermit> queryPermitListByRoleId(@Param("roleid") String roleid,
                                                 @Param("parentpermitid") String parentpermitid,
                                                 @Param("permittype") String permittype);

    public List<PlatformPermit> queryPermitListByUserId(@Param("userid") String userid);
}
