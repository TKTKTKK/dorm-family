package com.dorm.family.mapper;

import com.dorm.common.base.BaseMapper;
import com.dorm.family.entity.Dormitory;
import com.dorm.family.entity.Machine;
import com.dorm.family.entity.Merchant;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DormitoryMapper extends BaseMapper<Dormitory> {


    List<Dormitory> selectDormitoryForUser(@Param("userid") String userid);

    PageList<Dormitory> selectDormitoryForUserWithPagination(@Param("userid") String userid,@Param("topAccount") String topAccount,@Param("dormitory") Dormitory dormitory, PageBounds pageBounds);

    List<Dormitory> selectDormitoryListNotInDormitoryUserTable(@Param("userBindId") String userBindId,@Param("userId") String userId);

    Dormitory selectDormitoryForSave(@Param("dormitory") Dormitory dormitory);
}
