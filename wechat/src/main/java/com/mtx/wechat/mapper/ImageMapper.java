package com.mtx.wechat.mapper;

import com.mtx.common.base.BaseMapper;
import com.mtx.wechat.entity.admin.Image;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by shanny on 12/22/2014.
 */
@Repository
public interface ImageMapper extends BaseMapper<Image> {
    List<Image> selectImageListHaveMediaId(@Param("image")Image image);
}
