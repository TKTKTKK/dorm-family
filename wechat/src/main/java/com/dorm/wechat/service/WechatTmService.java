package com.dorm.wechat.service;

import com.dorm.common.base.BaseService;
import com.dorm.wechat.entity.admin.WechatTm;
import com.dorm.wechat.mapper.WechatTmMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class WechatTmService extends BaseService<WechatTmMapper, WechatTm> {
    @Autowired
    public void setMapper(WechatTmMapper mapper) {
        super.setMapper(mapper);
    }

}
