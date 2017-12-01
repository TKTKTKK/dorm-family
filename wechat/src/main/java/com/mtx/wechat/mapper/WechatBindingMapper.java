package com.mtx.wechat.mapper;

import com.mtx.common.base.BaseMapper;
import com.mtx.wechat.entity.admin.WechatBinding;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wensheng on 12/10/2014.
 */
@Repository
public interface WechatBindingMapper extends BaseMapper<WechatBinding>{
    public List<WechatBinding> selectWechatBindingForUser(@Param("userid") String userid);
}
