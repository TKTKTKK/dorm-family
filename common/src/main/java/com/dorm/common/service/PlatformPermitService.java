package com.dorm.common.service;

import com.dorm.common.base.BaseService;
import com.dorm.common.entity.PlatformPermit;
import com.dorm.common.mapper.PlatformPermitMapper;
import com.dorm.common.utils.CacheUtils;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Transactional
public class PlatformPermitService extends BaseService<PlatformPermitMapper,PlatformPermit> {
    @Autowired
    public void setMapper(PlatformPermitMapper mapper) {
        super.setMapper(mapper);
    }

    public List<PlatformPermit> getPermitListByRoleId(String userid, String parentpermitid, String permittype){
        return mapper.getPermitListByRoleId(userid, parentpermitid, permittype);
    }

    public PageList<PlatformPermit> getPermitList( PageBounds pageBounds){
        return mapper.getPermitList(pageBounds);
    }

    public List<PlatformPermit> queryPermitList(String parentpermitid){
        return mapper.queryPermitList(parentpermitid);
    }


    /**
     * 根据菜单名称查询菜单
     * @param permitName
     * @return
     */
    public PlatformPermit queryPermitIdByMenuName(String permitName){
        PlatformPermit platformPermit = null;
        List<PlatformPermit> platformPermitList = mapper.queryPermitIdByMenuName(permitName);
        if(null != platformPermitList && platformPermitList.size()> 0){
            platformPermit = platformPermitList.get(0);
        }
        return platformPermit;
    }

    /**
     * 根据菜单ID查询菜单
     * @param permitid
     * @return
     */
    public PlatformPermit queryPermitIdByMenuId(String permitid){
        PlatformPermit platformPermit = mapper.queryPermitIdByMenuId(permitid);
        return platformPermit;
    }

    /**
     * 根据菜单地址查询菜单
     * @param permitresource
     * @return
     */
    public PlatformPermit queryPermitIdByResource(String permitresource){
        PlatformPermit platformPermit = null;
        List<PlatformPermit> platformPermitList = mapper.queryPermitIdByResource(permitresource);
        if(null != platformPermitList && platformPermitList.size()> 0){
            platformPermit = platformPermitList.get(0);
        }
        return platformPermit;
    }

    /**
     * 根据角色查询权限
     * @param roleid
     * @return
     */
    public List<PlatformPermit> queryPermitListByRoleId(String roleid, String parentPermitId, String permittype){
        return this.mapper.queryPermitListByRoleId(roleid, parentPermitId, permittype);
    }

    public List<PlatformPermit> queryPermitListByUserId(String userid){
        return this.mapper.queryPermitListByUserId(userid);
    }

    /**
     * 获取系统全部受限权限
     * @return
     */
    public Set<String> queryAllPermitList(){
        Set<String> permissions = (Set<String>) CacheUtils.get("PLATFORMPERMITS");
        if(permissions != null && !permissions.isEmpty()){
            return permissions;
        }else{
            List<PlatformPermit> platformPermits = this.mapper.select(new PlatformPermit());
            permissions = new HashSet<String>();
            for(PlatformPermit permit : platformPermits){
                permissions.add("/"+permit.getPermitresource().toLowerCase());
            }
            CacheUtils.put("PLATFORMPERMITS",permissions);
            return permissions;
        }
    }
}
