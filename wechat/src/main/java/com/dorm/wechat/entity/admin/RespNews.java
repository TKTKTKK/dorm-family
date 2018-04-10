package com.dorm.wechat.entity.admin;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wensheng on 14-12-16.
 */
@Table(name="tb_resp_news")
public class RespNews extends BaseEntity {

    @Column
    private String bindid;
    //用于访问第一条article
    private RespArticle firstRespArticle;

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public RespArticle getFirstRespArticle() {
        return firstRespArticle;
    }

    public void setFirstRespArticle(RespArticle firstRespArticle) {
        this.firstRespArticle = firstRespArticle;
    }
}
