package com.dorm.wechat.entity;

import java.util.List;
import java.util.Map;

/**
 * 关注用户列表
 */
public class WechatUserList {
    //总关注用户数
    private int total;
    //获取的OpenID个数
    private int count;
    //OpenID 列表
    private Map<String,List> data;
    //拉取列表的后一个用户OpenID
    private String next_openid;

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public Map<String, List> getData() {
        return data;
    }

    public void setData(Map<String, List> data) {
        this.data = data;
    }

    public String getNext_openid() {
        return next_openid;
    }

    public void setNext_openid(String next_openid) {
        this.next_openid = next_openid;
    }
}
