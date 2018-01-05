package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.utils.StringUtils;
import com.mtx.family.entity.Machine;
import com.mtx.family.entity.MtxPoint;
import com.mtx.family.entity.MtxProduct;
import com.mtx.family.entity.MtxUserMachine;
import com.mtx.family.mapper.MtxProductMapper;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.service.WpUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxProductService extends BaseService<MtxProductMapper,MtxProduct> {

    @Autowired
    public void setMapper(MtxProductMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<MtxProduct> queryForListWithPagination(MtxProduct obj, PageBounds pageBounds,String flag) {
        return mapper.selectMxtProductList(obj,pageBounds,flag);
    }

    public List<MtxProduct> validModelIsExist(String model, String uuid) {
        return mapper.validModelIsExist(model,uuid);
    }

    public List<String> getAllModel() {
        return mapper.getAllModel();
    }
}
