package com.mtx.wechat.mapper;

import com.mtx.common.base.BaseMapper;
import com.mtx.wechat.entity.admin.WechatCardCode;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wensheng on 1/16/2015.
 */
@Repository
public interface WechatCardCodeMapper extends BaseMapper<WechatCardCode> {
    public List<WechatCardCode> selectCodeByBindIdAndOpenIdList(@Param("bindid")String bindid,@Param("openid")String openid,@Param("cardType")String cardType);
}
