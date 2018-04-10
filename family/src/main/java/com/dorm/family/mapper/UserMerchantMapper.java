package com.dorm.family.mapper;

import com.dorm.family.entity.UserMerchant;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserMerchantMapper extends BaseMapper<UserMerchant> {
    int deleteUserMerchant(@Param("userMerchant") UserMerchant userMerchant);

    PageList<UserMerchant> selectUserMerchantListByUserId(@Param("userid")String userid, PageBounds pageBounds);

    UserMerchant selectUserMerchantInfoById(@Param("userMerchantId")String userMerchantId);
}
