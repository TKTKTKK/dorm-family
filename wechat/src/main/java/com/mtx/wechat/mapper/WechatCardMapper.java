package com.mtx.wechat.mapper;

import com.mtx.wechat.entity.admin.WechatBaseCard;
import com.mtx.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by wensheng on 1/16/2015.
 */
@Repository
public interface WechatCardMapper extends BaseMapper<WechatBaseCard> {
    public void updateCardAfterCreate(@Param("card_id")String card_id, @Param("org_card_id")String org_card_id);
}
