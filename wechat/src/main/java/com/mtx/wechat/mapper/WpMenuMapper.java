package com.mtx.wechat.mapper;

import com.mtx.common.base.BaseMapper;
import com.mtx.wechat.entity.wpMenu.WpMenu;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by admin on 16-1-14.
 */
@Repository
public interface WpMenuMapper extends BaseMapper<WpMenu> {

    public List<WpMenu> selectWpMenuName(@Param("wpMenu")WpMenu wpMenu);

    public List<WpMenu> selectWpMenu(@Param("wpMenu")WpMenu wpMenu);

    public WpMenu selectWpMenuMaster(@Param("wpMenu")WpMenu wpMenu);

    public List<WpMenu>  selectWpMenuByName(@Param("wpMenu")WpMenu wpMenu);
}
