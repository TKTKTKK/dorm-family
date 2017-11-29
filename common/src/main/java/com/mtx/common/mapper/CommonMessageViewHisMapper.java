package com.mtx.common.mapper;

import com.mtx.common.base.BaseMapper;
import com.mtx.common.entity.CommonMessageViewHis;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommonMessageViewHisMapper extends BaseMapper<CommonMessageViewHis> {

    Integer selectMsgViewCount(@Param("msgId") String msgId);
}
