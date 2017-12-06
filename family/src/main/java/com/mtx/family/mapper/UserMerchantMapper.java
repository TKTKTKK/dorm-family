package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.UserMerchant;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserMerchantMapper extends BaseMapper<UserMerchant> {
    int deleteUserMerchant(@Param("userMerchant") UserMerchant userMerchant);

    PageList<UserMerchant> selectUserMerchantListByUserId(@Param("userid")String userid, PageBounds pageBounds);

    UserMerchant selectUserMerchantInfoById(@Param("userMerchantId")String userMerchantId);
}
