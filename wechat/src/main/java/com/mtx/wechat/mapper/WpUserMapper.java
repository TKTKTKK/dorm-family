package com.mtx.wechat.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.wechat.entity.WpUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

/**
 * Created by wensheng on 12/26/2014.
 */
@Repository
public interface WpUserMapper extends BaseMapper<WpUser>{
    public Set<String> selectWpUserByBindid(@Param("bindid")String bindid);

    public void batchInsertWpUser(List<WpUser> baseWpUserList);

    public List<String> selectUnautherizedWpUser(@Param("bindid")String bindid, @Param("mediaid")String mediaid);

    public PageList<WpUser> selectAllWpUsersByBindid(@Param("bindid")String bindid, PageBounds pageBounds);

    public PageList<WpUser> selectWpUserList(@Param("wpUser") WpUser wpUser, PageBounds pageBounds);
}
