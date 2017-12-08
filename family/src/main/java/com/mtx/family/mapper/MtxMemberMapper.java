package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.MtxMember;
import com.mtx.family.entity.MtxProduct;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MtxMemberMapper extends BaseMapper<MtxMember> {
    public PageList<MtxMember> selectMtxMemberList(@Param("mtxMember") MtxMember mtxMember, PageBounds pageBounds);
}
