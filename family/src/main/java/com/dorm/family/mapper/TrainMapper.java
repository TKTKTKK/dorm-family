package com.dorm.family.mapper;

import com.dorm.family.entity.Train;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseMapper;
import com.dorm.family.entity.Merchant;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TrainMapper extends BaseMapper<Train> {


    PageList<Train> selectTrainList(@Param("train") Train train,@Param("startTime") String startDateTimeStr,@Param("endTime") String endDateTimeStr, PageBounds pageBounds);

    List<Train> selectTrainListForPhone(@Param("train") Train train,@Param("merchantList") List<Merchant> merchantList);

    List<Train> selectTrainListForExport(@Param("train") Train train,@Param("startTime") String startDateTimeStr,@Param("endTime") String endDateTimeStr);
}
