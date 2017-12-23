package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.Logistics;
import com.mtx.family.entity.Merchant;
import com.mtx.family.entity.Train;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TrainMapper extends BaseMapper<Train> {


    PageList<Train> selectTrainList(@Param("train") Train train,@Param("startTime") String startDateTimeStr,@Param("endTime") String endDateTimeStr, PageBounds pageBounds);

    List<Train> selectTrainListForPhone(@Param("train") Train train,@Param("merchantList") List<Merchant> merchantList);
}
