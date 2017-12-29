package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxExchangeRecord;
import com.mtx.family.entity.MtxPoint;
import com.mtx.family.entity.MtxProduct;
import com.mtx.family.mapper.MtxExchangeRecordMapper;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.service.WpUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxExchangeRecordService extends BaseService<MtxExchangeRecordMapper,MtxExchangeRecord> {

    @Autowired
    public void setMapper(MtxExchangeRecordMapper mapper) {
        super.setMapper(mapper);
    }

    @Autowired
    private WpUserService wpUserService;

    @Autowired
    private MtxProductService mxtProductService;

    @Autowired
    private MtxPointService mtxPointService;

    public PageList<MtxExchangeRecord> queryForListWithPagination(MtxExchangeRecord obj, PageBounds pageBounds) {
        return mapper.selectMtxExchangeRecordList(obj,pageBounds);
    }

    public void addExchangeRecord(String userid, String productid, MtxExchangeRecord mMtxExchangeRecord) {
        WpUser user=new WpUser();
        user.setUuid(userid);
        MtxProduct product=new MtxProduct();
        product.setUuid(productid);
        product=mxtProductService.queryForObjectByPk(product);
        mMtxExchangeRecord.setUserid(userid);
        mMtxExchangeRecord.setProductid(productid);
        mMtxExchangeRecord.setStatus("N_DEAL");
        this.insert(mMtxExchangeRecord);
        user=wpUserService.queryForObjectByPk(user);
        int point=user.getPoints()-mMtxExchangeRecord.getCount()*product.getPoints();
        user.setPoints(point);
        wpUserService.updatePartial(user);
        MtxPoint mtxPoint=new MtxPoint();
        mtxPoint.setUserid(userid);
        String name="";
        name=product.getName()+" * "+mMtxExchangeRecord.getCount();
        mtxPoint.setName(name);
        mtxPoint.setPoints(-mMtxExchangeRecord.getCount()*product.getPoints());
        mtxPointService.insert(mtxPoint);
    }

    public List<MtxExchangeRecord> queryExchangeRecordList(String userid) {
        return mapper.queryExchangeRecordList(userid);
    }
}
