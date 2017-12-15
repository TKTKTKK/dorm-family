package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.utils.StringUtils;
import com.mtx.family.entity.*;
import com.mtx.family.mapper.MtxProductMapper;
import com.mtx.family.mapper.MtxVideoMapper;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.service.WpUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxVideoService extends BaseService<MtxVideoMapper,MtxVideo> {

    @Autowired
    public void setMapper(MtxVideoMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxVideo> queryForListWithPagination(MtxVideo obj, PageBounds pageBounds) {
        return mapper.selectMtxVideoList(obj,pageBounds);
    }
}
