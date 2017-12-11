package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxMember;
import com.mtx.family.entity.MtxProduct;
import com.mtx.family.mapper.MtxMemberMapper;
import com.mtx.family.mapper.MtxProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class MtxMemberService extends BaseService<MtxMemberMapper,MtxMember> {

    @Autowired
    public void setMapper(MtxMemberMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxMember> queryForListWithPagination(MtxMember obj, PageBounds pageBounds) {
        return mapper.selectMtxMemberList(obj,pageBounds);
    }
}
