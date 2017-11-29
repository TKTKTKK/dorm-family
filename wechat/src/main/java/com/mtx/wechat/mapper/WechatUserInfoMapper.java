package com.mtx.wechat.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.wechat.entity.WechatUserInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WechatUserInfoMapper extends BaseMapper<WechatUserInfo> {

    public void batchInsert(List<WechatUserInfo> wechatUserList);

    public PageList<WechatUserInfo> selectWechatUserInfoForStaff(@Param("wechatUserInfo")WechatUserInfo wechatUserInfo,PageBounds pageBounds);
    public PageList<WechatUserInfo> selectWechatUserInfoForStaff(@Param("wechatUserInfo")WechatUserInfo wechatUserInfo);

    public PageList<WechatUserInfo> selectWechatUserInfoForPageList(@Param("wechatUserInfo")WechatUserInfo wechatUserInfo,@Param("ifsubscribe") String ifsubscribe,@Param("ifCreateAccount") String ifCreateAccount, PageBounds pageBounds);

    public List<WechatUserInfo> selectUserInfoAndStatus(@Param("wechatUserInfo") WechatUserInfo wechatUserInfo);
}
