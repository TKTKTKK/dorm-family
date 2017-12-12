package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.utils.StringUtils;
import com.mtx.common.utils.UserUtils;
import com.mtx.family.entity.MtxMember;
import com.mtx.family.entity.MtxPoint;
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
    @Autowired
    private MtxPointService mtxPointService;

    public PageList<MtxMember> queryForListWithPagination(MtxMember obj, PageBounds pageBounds) {
        return mapper.selectMtxMemberList(obj,pageBounds);
    }

    public void insertMemberAndPoint(MtxMember mtxMember) {
        String bindid= UserUtils.getUserBindId();
        mtxMember.setBindid(bindid);
        MtxPoint point=new MtxPoint();
        this.insert(mtxMember);
        point.setMachineid(mtxMember.getMachineid());
        point.setUserid(mtxMember.getUuid());
        point.setPoints(mtxMember.getPoints());
        if(mtxMember.getPoints()!=null&&mtxMember.getPoints()!=0.0){
            mtxPointService.insert(point);
        }
    }
}
