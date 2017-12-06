package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.utils.StringUtils;
import com.mtx.common.utils.UserUtils;
import com.mtx.family.entity.Merchant;
import com.mtx.family.mapper.MerchantMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;


@Service
@Transactional
public class MerchantService extends BaseService<MerchantMapper,Merchant> {

    @Autowired
    public void setMapper(MerchantMapper mapper) {
        super.setMapper(mapper);
    }

    public PageList<Merchant> queryForListWithPagination(Merchant obj,PageBounds pageBounds) {
        return mapper.selectMerchantList(obj,pageBounds);
    }

    public PageList<Merchant> selectMerchantForUserWithPagination(String userid, String topAccount, Merchant merchant, PageBounds pageBounds) {
        return mapper.selectMerchantForUserWithPagination(userid,topAccount,merchant,pageBounds);
    }


    public List<Merchant> selectAllMerchants(){
        return this.mapper.select(new Merchant());
    }

    public Merchant selectMerchantForSave(Merchant merchant){
        return mapper.selectMerchantForSave(merchant);
    }

    /**
     * 获取用户对应Merchant信息
     * 没有则根据bindid获取所有小区信息
     * @return
     */
    public List<Merchant> selectMerchantForUser(){
        String userid = UserUtils.getUserId();
        List<Merchant> list = mapper.selectMerchantForUser(userid);
        if(list == null || list.isEmpty()){
            String bindid = UserUtils.getUserBindId();
            if(StringUtils.isNotBlank(bindid)){
                Merchant merchant = new Merchant();
                merchant.setBindid(bindid);
                merchant.setOrderby("createon");
                list = this.selectAllMerchants();
            }
        }
        return list;
    }

    public List<Merchant> selectAssignedMerchantForUser(){
        String userid = UserUtils.getUserId();
        return mapper.selectMerchantForUser(userid);
    }

    public List<Merchant> queryMerchantListNotInUserMerhantTable(String bindid, String userId){
        return mapper.selectMerchantListNotInUserMerhantTable(bindid,userId);
    }
}
