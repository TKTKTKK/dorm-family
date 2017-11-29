package com.mtx.wechat.entity.admin;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wensheng on 1/16/2015.
 */
@Table(name = "tb_wechat_card_code")
public class WechatCardCode extends BaseEntity {


    @Column
    private String cardid;
    @Column
    private String card_id;
    @Column
    private String code;
    @Column
    private Integer isgivebyfriend;
    @Column
    private String  friendopenid;
    @Column
    private Integer outerid;
    @Column
    private String  openid;
    @Column
    private String  status;

    public String getCardid() {
        return cardid;
    }

    public void setCardid(String cardid) {
        this.cardid = cardid;
    }

    public String getCard_id() {
        return card_id;
    }

    public void setCard_id(String card_id) {
        this.card_id = card_id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getIsgivebyfriend() {
        return isgivebyfriend;
    }

    public void setIsgivebyfriend(Integer isgivebyfriend) {
        this.isgivebyfriend = isgivebyfriend;
    }

    public String getFriendopenid() {
        return friendopenid;
    }

    public void setFriendopenid(String friendopenid) {
        this.friendopenid = friendopenid;
    }

    public Integer getOuterid() {
        return outerid;
    }

    public void setOuterid(Integer outerid) {
        this.outerid = outerid;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
