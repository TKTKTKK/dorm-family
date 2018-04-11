package com.dorm.family.mapper;

import com.dorm.common.base.BaseMapper;
import com.dorm.family.entity.Dormitory;
import com.dorm.family.entity.DormitoryUser;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DormitoryUserMapper extends BaseMapper<DormitoryUser> {


    PageList<DormitoryUser> selectDormitoryUserListByUserId(@Param("userId") String userId, PageBounds pageBounds);

    DormitoryUser selectDormitoryUserInfoById(@Param("dormitoryUserId") String dormitoryUserId);

    int deleteDormitoryUser(@Param("dormitoryUser") DormitoryUser dormitoryUser);
}
