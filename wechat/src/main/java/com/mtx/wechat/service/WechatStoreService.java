package com.mtx.wechat.service;

import com.mtx.common.base.BaseService;
import com.mtx.wechat.entity.admin.WechatStore;
import com.mtx.wechat.mapper.WechatStoreMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by wensheng on 15-2-1.
 */
@Service
@Transactional
public class WechatStoreService extends BaseService<WechatStoreMapper,WechatStore> {

    @Autowired
    public void setMapper(WechatStoreMapper mapper) {
        super.setMapper(mapper);
    }
}
