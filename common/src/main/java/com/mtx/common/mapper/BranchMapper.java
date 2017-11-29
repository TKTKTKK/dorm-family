package com.mtx.common.mapper;

import com.mtx.common.base.BaseMapper;
import com.mtx.common.entity.Branch;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by wensheng on 15-1-7.
 */
@Repository
public interface BranchMapper extends BaseMapper<Branch> {
    public PageList<Branch> selectBranchListForAdmin(@Param("branch")Branch wpCommunity,PageBounds pageBounds);

    public Branch selectBranchForSave(@Param("branch")Branch branch);
}
