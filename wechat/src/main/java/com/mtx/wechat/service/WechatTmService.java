package com.mtx.wechat.service;

import com.mtx.wechat.entity.admin.WechatTm;
import com.mtx.wechat.mapper.WechatTmMapper;
import com.mtx.common.base.BaseService;
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
