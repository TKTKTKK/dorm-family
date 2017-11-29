package com.mtx.wechat.entity.admin;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wensheng on 12/10/2014.
 */
@Table(name="tb_wechat_binding")
public class WechatBinding extends BaseEntity {

    @Column
    private String wechatname;
    @Column
    private String wechatorigid;
    @Column
    private String wechatid;
    @Column
    private String appid;
    @Column
    private String appsecret;

    @Column
    private String logo_url;
    @Column
    private String brand_name;
    @Column
    private String token;
    @Column
    private String trusteeship;
    @Column
    private String merchantid;
    @Column
    private String wechatpayid;
    @Column
    private String wechatpaykey;
    @Column
    private String phpayapiid;
    @Column
    private String phpayapikey;
    @Column
    private String authorizerrefreshtoken;
    @Column
    private String authorized;

    public String getWechatname() {
        return wechatname;
    }

    public void setWechatname(String wechatname) {
        this.wechatname = wechatname;
    }

    public String getWechatorigid() {
        return wechatorigid;
    }

    public void setWechatorigid(String wechatorigid) {
        this.wechatorigid = wechatorigid;
    }

    public String getWechatid() {
        return wechatid;
    }

    public void setWechatid(String wechatid) {
        this.wechatid = wechatid;
    }

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }

    public String getAppsecret() {
        return appsecret;
    }

    public void setAppsecret(String appsecret) {
        this.appsecret = appsecret;
    }

    public String getLogo_url() {
        return logo_url;
    }

    public void setLogo_url(String logo_url) {
        this.logo_url = logo_url;
    }

    public String getBrand_name() {
        return brand_name;
    }

    public void setBrand_name(String brand_name) {
        this.brand_name = brand_name;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getTrusteeship() {
        return trusteeship;
    }

    public void setTrusteeship(String trusteeship) {
        this.trusteeship = trusteeship;
    }

    public String getMerchantid() {
        return merchantid;
    }

    public void setMerchantid(String merchantid) {
        this.merchantid = merchantid;
    }

    public String getWechatpayid() { return wechatpayid;}

    public void setWechatpayid(String wechatpayid) { this.wechatpayid = wechatpayid;}

    public String getWechatpaykey() {
        return wechatpaykey;
    }

    public void setWechatpaykey(String wechatpaykey) {
        this.wechatpaykey = wechatpaykey;
    }

    public String getPhpayapiid() {
        return phpayapiid;
    }

    public void setPhpayapiid(String phpayapiid) {
        this.phpayapiid = phpayapiid;
    }

    public String getPhpayapikey() {
        return phpayapikey;
    }

    public void setPhpayapikey(String phpayapikey) {
        this.phpayapikey = phpayapikey;
    }

    public String getAuthorizerrefreshtoken() {
        return authorizerrefreshtoken;
    }

    public void setAuthorizerrefreshtoken(String authorizerrefreshtoken) {
        this.authorizerrefreshtoken = authorizerrefreshtoken;
    }

    public String getAuthorized() {
        return authorized;
    }

    public void setAuthorized(String authorized) {
        this.authorized = authorized;
    }
}
