package com.mtx.wechat.entity.card.base;

/**
 * 基本的卡券数据
 */
public class BaseInfo {
    private String logo_url;
    private String code_type;
    private String brand_name;
    private String title;
    private String sub_title;
    private String color;
    private String notice;
    private String service_phone;
    private String source;
    private String description;
    private Long use_limit;
    private Long get_limit;
    private Boolean use_custom_code;
    private Boolean bind_openid;
    private Boolean can_share;
    private Boolean can_give_friend;
    private String location_id_list;
    private DateInfo date_info;
    private SKU sku;
    private String url_name_type;
    private String custom_url;
    private String promotion_url_name_type;
    private String promotion_url;

    public String getLogo_url() {
        return logo_url;
    }

    public void setLogo_url(String logo_url) {
        this.logo_url = logo_url;
    }

    public String getCode_type() {
        return code_type;
    }

    public void setCode_type(String code_type) {
        this.code_type = code_type;
    }

    public String getBrand_name() {
        return brand_name;
    }

    public void setBrand_name(String brand_name) {
        this.brand_name = brand_name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSub_title() {
        return sub_title;
    }

    public void setSub_title(String sub_title) {
        this.sub_title = sub_title;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getNotice() {
        return notice;
    }

    public void setNotice(String notice) {
        this.notice = notice;
    }

    public String getService_phone() {
        return service_phone;
    }

    public void setService_phone(String service_phone) {
        this.service_phone = service_phone;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getUse_limit() {
        return use_limit;
    }

    public void setUse_limit(Long use_limit) {
        this.use_limit = use_limit;
    }

    public Long getGet_limit() {
        return get_limit;
    }

    public void setGet_limit(Long get_limit) {
        this.get_limit = get_limit;
    }

    public Boolean getUse_custom_code() {
        return use_custom_code;
    }

    public void setUse_custom_code(Boolean use_custom_code) {
        this.use_custom_code = use_custom_code;
    }

    public Boolean getBind_openid() {
        return bind_openid;
    }

    public void setBind_openid(Boolean bind_openid) {
        this.bind_openid = bind_openid;
    }

    public Boolean getCan_share() {
        return can_share;
    }

    public void setCan_share(Boolean can_share) {
        this.can_share = can_share;
    }

    public Boolean getCan_give_friend() {
        return can_give_friend;
    }

    public void setCan_give_friend(Boolean can_give_friend) {
        this.can_give_friend = can_give_friend;
    }

    public String getLocation_id_list() {
        return location_id_list;
    }

    public void setLocation_id_list(String location_id_list) {
        this.location_id_list = location_id_list;
    }

    public DateInfo getDate_info() {
        return date_info;
    }

    public void setDate_info(DateInfo date_info) {
        this.date_info = date_info;
    }

    public SKU getSku() {
        return sku;
    }

    public void setSku(SKU sku) {
        this.sku = sku;
    }

    public String getUrl_name_type() {
        return url_name_type;
    }

    public void setUrl_name_type(String url_name_type) {
        this.url_name_type = url_name_type;
    }

    public String getCustom_url() {
        return custom_url;
    }

    public void setCustom_url(String custom_url) {
        this.custom_url = custom_url;
    }

    public String getPromotion_url_name_type() {
        return promotion_url_name_type;
    }

    public void setPromotion_url_name_type(String promotion_url_name_type) {
        this.promotion_url_name_type = promotion_url_name_type;
    }

    public String getPromotion_url() {
        return promotion_url;
    }

    public void setPromotion_url(String promotion_url) {
        this.promotion_url = promotion_url;
    }
}
