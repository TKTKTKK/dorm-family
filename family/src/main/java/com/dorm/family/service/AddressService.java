package com.dorm.family.service;

import com.dorm.common.base.BaseService;
import com.dorm.common.utils.StringUtils;
import com.dorm.common.utils.UserUtils;
import com.dorm.family.entity.Address;
import com.dorm.family.entity.Dormitory;
import com.dorm.family.mapper.AddressMapper;
import com.dorm.family.mapper.DormitoryMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class AddressService extends BaseService<AddressMapper,Address> {

    @Autowired
    public void setMapper(AddressMapper mapper) {
        super.setMapper(mapper);
    }

    public Address getAddressForSave(Address address) {
        return mapper.selectAddressForSave(address);
    }

    public PageList<Address> getAddressListWithPagination(Address address, PageBounds pageBounds) {
        return mapper.selectAddressListWithPagination(address,pageBounds);
    }

    public List<Address> getAddressBylayerAndRoomno(Address address) {
        return mapper.selectAddressBylayerAndRoomno(address);
    }

    public void batchInsert(List<Address> addressList) {
        mapper.batchInsert(addressList);
    }
}
