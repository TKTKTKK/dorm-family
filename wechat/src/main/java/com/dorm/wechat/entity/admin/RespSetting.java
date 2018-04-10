package com.dorm.wechat.entity.admin;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wensheng on 12/10/2014.
 */
@Table(name="tb_resp_setting")
public class RespSetting extends BaseEntity {

    @Column
    private String bindid;
    @Column
    private String newsid;
    @Column
    private String reqtype;
    @Column
    private String keywords;
    @Column
    private String resptype;
    @Column
    private String content;
    @Column
    private String title;
    @Column
    private String decription;
    @Column
    private String musicurl;
    @Column
    private String hqmusicurl;
    @Column
    private String thumbmediaid;
    @Column
    private String mediaid;

    //图片路径
    private String imgname;

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getNewsid() {
        return newsid;
    }

    public void setNewsid(String newsid) {
        this.newsid = newsid;
    }

    public String getReqtype() {
        return reqtype;
    }

    public void setReqtype(String reqtype) {
        this.reqtype = reqtype;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public String getResptype() {
        return resptype;
    }

    public void setResptype(String resptype) {
        this.resptype = resptype;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDecription() {
        return decription;
    }

    public void setDecription(String decription) {
        this.decription = decription;
    }

    public String getMusicurl() {
        return musicurl;
    }

    public void setMusicurl(String musicurl) {
        this.musicurl = musicurl;
    }

    public String getHqmusicurl() {
        return hqmusicurl;
    }

    public void setHqmusicurl(String hqmusicurl) {
        this.hqmusicurl = hqmusicurl;
    }

    public String getThumbmediaid() {
        return thumbmediaid;
    }

    public void setThumbmediaid(String thumbmediaid) {
        this.thumbmediaid = thumbmediaid;
    }

    public String getMediaid() {
        return mediaid;
    }

    public void setMediaid(String mediaid) {
        this.mediaid = mediaid;
    }

    public String getImgname() {
        return imgname;
    }

    public void setImgname(String imgname) {
        this.imgname = imgname;
    }
}
