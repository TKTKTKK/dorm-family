package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.family.entity.Machine;
import com.mtx.family.entity.Merchant;
import com.mtx.common.base.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MerchantMapper extends BaseMapper<Merchant> {

    public PageList<Merchant> selectMerchantList(@Param("merchant") Merchant merchant, PageBounds pageBounds);

    public Merchant selectMerchantForSave(@Param("merchant") Merchant merchant);

    public List<Merchant> selectMerchantForUser(@Param("userid") String userid);

    PageList<Merchant> selectMerchantForUserWithPagination(@Param("userid") String userid,@Param("topAccount") String topAccount,@Param("merchant") Merchant merchant, PageBounds pageBounds);

    List<Merchant> selectMerchantListNotInUserMerhantTable(@Param("bindid") String bindid, @Param("userid") String userid);


    List<Merchant> selectMerchantByMachineInfo(@Param("machine") Machine machine);
}
