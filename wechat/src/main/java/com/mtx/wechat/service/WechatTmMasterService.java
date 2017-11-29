package com.mtx.wechat.service;

import com.mtx.common.base.BaseService;
import com.mtx.wechat.entity.admin.WechatTmMaster;
import com.mtx.wechat.mapper.WechatTmMasterMapper;
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
