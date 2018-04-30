package com.dorm.family.service;

import com.dorm.common.base.BaseService;
import com.dorm.common.utils.StringUtils;
import com.dorm.common.utils.UserUtils;
import com.dorm.family.entity.Dormitory;
import com.dorm.family.mapper.DormitoryMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class DormitoryService extends BaseService<DormitoryMapper,Dormitory> {

    @Autowired
    public void setMapper(DormitoryMapper mapper) {
        super.setMapper(mapper);
    }


    public List<Dormitory> getAssignedDormitoryForUser() {
        String userid = UserUtils.getUserId();
        return mapper.selectDormitoryForUser(userid);
    }

    public PageList<Dormitory> getDormitoryForUserWithPagination(String userid, String topAccount, Dormitory dormitory, PageBounds pageBounds) {
        return mapper.selectDormitoryForUserWithPagination(userid,topAccount,dormitory,pageBounds);
    }

    public List<Dormitory> getDormitoryListNotInDormitoryUserTable(String userBindId, String userId) {
        return mapper.selectDormitoryListNotInDormitoryUserTable(userBindId,userId);
    }

    public Dormitory getDormitoryForSave(Dormitory dormitory) {
        return mapper.selectDormitoryForSave(dormitory);
    }

    public List<Dormitory> getDormitoryForUser() {
        String userid = UserUtils.getUserId();
        List<Dormitory> list = mapper.selectDormitoryForUser(userid);
        if(list == null || list.isEmpty()){
            String bindid = UserUtils.getUserBindId();
            if(StringUtils.isNotBlank(bindid)){
                Dormitory dormitory = new Dormitory();
                dormitory.setBindid(bindid);
                dormitory.setOrderby("createon");
                list = this.queryForList(dormitory);
            }
        }
        return list;
    }
}
