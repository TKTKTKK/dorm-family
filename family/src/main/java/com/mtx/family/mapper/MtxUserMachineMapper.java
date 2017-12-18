package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.MtxPoint;
import com.mtx.family.entity.MtxUserMachine;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MtxUserMachineMapper extends BaseMapper<MtxUserMachine> {
    List<MtxUserMachine> queryMachineList(@Param("userid")String userid,@Param("type")String type);

    PageList<MtxUserMachine> selectMtxUserMachineList(@Param("mtxUserMachine")MtxUserMachine mtxUserMachine, PageBounds pageBounds);
}
