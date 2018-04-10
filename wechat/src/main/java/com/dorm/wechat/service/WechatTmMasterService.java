package com.dorm.wechat.service;

import com.dorm.common.base.BaseService;
import com.dorm.wechat.entity.admin.WechatTmMaster;
import com.dorm.wechat.mapper.WechatTmMasterMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class WechatTmMasterService extends BaseService<WechatTmMasterMapper, WechatTmMaster> {
    @Autowired
    public void setMapper(WechatTmMasterMapper mapper) {
        super.setMapper(mapper);
    }
}
