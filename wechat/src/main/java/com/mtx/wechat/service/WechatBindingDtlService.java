package com.mtx.wechat.service;

import com.mtx.common.base.BaseService;
import com.mtx.wechat.entity.admin.WechatBindingDtl;
import com.mtx.wechat.mapper.WechatBindingDtlMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class WechatBindingDtlService extends BaseService<WechatBindingDtlMapper,WechatBindingDtl> {
    @Autowired
    public void setMapper(WechatBindingDtlMapper mapper) {
        super.setMapper(mapper);
    }
}
