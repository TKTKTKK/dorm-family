package com.dorm.common.service;

import com.dorm.common.base.BaseService;
import com.dorm.common.entity.PlatformRolePermit;
import com.dorm.common.mapper.PlatformRolePermitMapper;
import com.dorm.common.utils.StringUtils;
import com.dorm.common.entity.PlatformRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class PlatformRolePermitService extends BaseService<PlatformRolePermitMapper,PlatformRolePermit> {
    @Autowired
    public void setMapper(PlatformRolePermitMapper mapper){
        super.setMapper(mapper);
    }
    @Autowired
    PlatformRoleService platformRoleService;

    public List<PlatformRolePermit> getPermitList(String roleid){
        List<PlatformRolePermit> platformRolePermitList = new ArrayList<>();
        String permits="";
        PlatformRole platformRole = new PlatformRole();
        List<PlatformRole> platformRoleList = new ArrayList<>();
        if(StringUtils.isNoneBlank(roleid)){
            platformRole.setUuid(roleid);
            platformRoleList.add(platformRoleService.queryForObjectByPk(platformRole));
        }else{
            platformRoleList = platformRoleService.queryForList(platformRole);
        }
        for(PlatformRole platformRoleSample:platformRoleList){
            List<PlatformRolePermit> platformRolePermitListSample = mapper.getRolePermitListByRoleId(platformRoleSample.getUuid());
            for(PlatformRolePermit platformRolePermit:platformRolePermitListSample){
                permits += platformRolePermit.getPermitname()+",";
            }
            if(platformRolePermitListSample!=null&&platformRolePermitListSample.size()>0){
                PlatformRolePermit platformRolePermitSample = platformRolePermitListSample.get(0);
                platformRolePermitSample.setPermitnames(permits);
                platformRolePermitList.add(platformRolePermitSample);
            }else{
                PlatformRolePermit platformRolePermitSample = new PlatformRolePermit();
                platformRolePermitSample.setRolename(platformRoleSample.getRolename());
                platformRolePermitList.add(platformRolePermitSample);
            }
            permits="";
        }
        return platformRolePermitList;
    }

    public List<PlatformRolePermit> getPermitListByRoleId(String roleid){
        return mapper.getRolePermitListByRoleId(roleid);
    }

    /**
     * 根据角色ID删除
     * @param roleid
     * @return
     */
    public int deleteByRoleId(String roleid){
        PlatformRolePermit platformRolePermit = new PlatformRolePermit();
        platformRolePermit.setRoleid(roleid);
        List<PlatformRolePermit> platformRolePermitList = mapper.select(platformRolePermit);
        int flag = 0;
        for(PlatformRolePermit platformRolePermitSample:platformRolePermitList){
            flag = mapper.delete(platformRolePermitSample);
        }
        return flag;
    }
}
