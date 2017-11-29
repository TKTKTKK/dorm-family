package com.mtx.common.service;

import com.mtx.common.mapper.BranchMapper;
import com.mtx.common.base.BaseService;
import com.mtx.common.entity.Branch;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wensheng on 15-1-7.
 */
@Service
@Transactional
public class BranchService extends BaseService<BranchMapper,Branch> {
    @Autowired
    public void setMapper(BranchMapper mapper) {
        super.setMapper(mapper);
    }


    public PageList<Branch> queryForListWithPaginationForAdmin(Branch obj,PageBounds pageBounds) {
        return mapper.selectBranchListForAdmin(obj,pageBounds);
    }

    public Branch selectBranchForSave(Branch branch){
        return mapper.selectBranchForSave(branch);
    }

    /**
     * 根据bindId获取branch
     * @return
     */
    public List<Branch> getBranchByBindId(String bindId){
        List<Branch> branches = new ArrayList<Branch>();
        Branch param = new Branch();
        param.setBindid(bindId);
        branches = queryForList(param);
        return branches;
    }
}
