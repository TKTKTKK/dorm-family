package com.dorm.family.mapper;

import com.dorm.common.base.BaseMapper;
import com.dorm.family.entity.Address;
import com.dorm.family.entity.Dormitory;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AddressMapper extends BaseMapper<Address> {


    Address selectAddressForSave(@Param("address") Address address);

    PageList<Address> selectAddressListWithPagination(@Param("address") Address address, PageBounds pageBounds);

    List<Address> selectAddressBylayerAndRoomno(@Param("address") Address address);

    void batchInsert(@Param("list") List<Address> addressList);

    List<Address> selectLayerListForDropDown(@Param("address") Address address);

    List<Address> selectRoomnoListForDropDown(@Param("address") Address address);
}
