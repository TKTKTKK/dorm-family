package com.mtx.wechat.entity.admin;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by shanny on 12/22/2014.
 */
@Table(name = "tb_image")
public class Image extends BaseEntity {
    @Column
    private String bindid;
    @Column
    private String imgname;
    @Column
    private String mediaid;

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getImgname() {
        return imgname;
    }

    public void setImgname(String imgname) {
        this.imgname = imgname;
    }

    public String getMediaid() {
        return mediaid;
    }

    public void setMediaid(String mediaid) {
        this.mediaid = mediaid;
    }
}
