package com.mtx.wechat.entity.admin;

import com.mtx.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by wensheng on 1/16/2015.
 */
@Table(name = "tb_wechat_card")
public class WechatBaseCard extends BaseEntity {

    @Column
    private String card_id;
    @Column
    private String bindid;
    @Column
    private String card_type;
    @Column
    private String logo_url;
    @Column
    private String code_type;
    @Column
    private String brand_name;
    @Column
    private String title;
    @Column
    private String sub_title;
    @Column
    private String color;
    @Column
    private String notice;
    @Column
    private String service_phone;
    @Column
    private String source;
    @Column
    private String description;
    @Column
    private Long use_limit;
    @Column
    private Long get_limit;
    @Column
    private String use_custom_code;
    @Column
    private String bind_openid;
    @Column
    private String can_share;
    @Column
    private String can_give_friend;
    @Column
    private String location_id_list;
    @Column
    private Integer type;
    @Column
    private Long begin_timestamp;
    @Column
    private Long end_timestamp;
    @Column
    private Integer fixed_term;
    @Column
    private Integer fixed_begin_term;
    @Column
    private Long quantity;
    @Column
    private String url_name_type;
    @Column
    private String custom_url;
    @Column
    private String promotion_url_name_type;
    @Column
    private String promotion_url;

    @Column
    private String detail;
    @Column
    private Long least_cost;
    @Column
    private Long reduce_cost;
    @Column
    private Integer discount;
    @Column
    private String supply_bonus;
    @Column
    private String supply_balance;
    @Column
    private String bonus_cleared;
    @Column
    private String bonus_rules;
    @Column
    private String balance_rules;
    @Column
    private String prerogative;
    @Column
    private String bind_old_card_url;
    @Column
    private String activate_url;
    @Column
    private String ticket_class;
    @Column
    private String guide_url;
    @Column
    private String map_url;
    @Column
    private String status;
    @Column
    private String ticket;

    //固定日期区间
    private String begin_timestampstr;
    private String end_timestampstr;

    public String getCard_id() {
        return card_id;
    }

    public void setCard_id(String card_id) {
        this.card_id = card_id;
    }

    public String getBindid() {
        return bindid;
    }

    public void setBindid(String bindid) {
        this.bindid = bindid;
    }

    public String getCard_type() {
        return card_type;
    }

    public void setCard_type(String card_type) {
        this.card_type = card_type;
    }

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

    public String getUse_custom_code() {
        return use_custom_code;
    }

    public void setUse_custom_code(String use_custom_code) {
        this.use_custom_code = use_custom_code;
    }

    public String getBind_openid() {
        return bind_openid;
    }

    public void setBind_openid(String bind_openid) {
        this.bind_openid = bind_openid;
    }

    public String getCan_share() {
        return can_share;
    }

    public void setCan_share(String can_share) {
        this.can_share = can_share;
    }

    public String getCan_give_friend() {
        return can_give_friend;
    }

    public void setCan_give_friend(String can_give_friend) {
        this.can_give_friend = can_give_friend;
    }

    public String getLocation_id_list() {
        return location_id_list;
    }

    public void setLocation_id_list(String location_id_list) {
        this.location_id_list = location_id_list;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Long getBegin_timestamp() {
        return begin_timestamp;
    }

    public void setBegin_timestamp(Long begin_timestamp) {
        this.begin_timestamp = begin_timestamp;
    }

    public Long getEnd_timestamp() {
        return end_timestamp;
    }

    public void setEnd_timestamp(Long end_timestamp) {
        this.end_timestamp = end_timestamp;
    }

    public Integer getFixed_term() {
        return fixed_term;
    }

    public void setFixed_term(Integer fixed_term) {
        this.fixed_term = fixed_term;
    }

    public Integer getFixed_begin_term() {
        return fixed_begin_term;
    }

    public void setFixed_begin_term(Integer fixed_begin_term) {
        this.fixed_begin_term = fixed_begin_term;
    }

    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
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

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public Long getLeast_cost() {
        return least_cost;
    }

    public void setLeast_cost(Long least_cost) {
        this.least_cost = least_cost;
    }

    public Long getReduce_cost() {
        return reduce_cost;
    }

    public void setReduce_cost(Long reduce_cost) {
        this.reduce_cost = reduce_cost;
    }

    public Integer getDiscount() {
        return discount;
    }

    public void setDiscount(Integer discount) {
        this.discount = discount;
    }

    public String getSupply_bonus() {
        return supply_bonus;
    }

    public void setSupply_bonus(String supply_bonus) {
        this.supply_bonus = supply_bonus;
    }

    public String getSupply_balance() {
        return supply_balance;
    }

    public void setSupply_balance(String supply_balance) {
        this.supply_balance = supply_balance;
    }

    public String getBonus_cleared() {
        return bonus_cleared;
    }

    public void setBonus_cleared(String bonus_cleared) {
        this.bonus_cleared = bonus_cleared;
    }

    public String getBonus_rules() {
        return bonus_rules;
    }

    public void setBonus_rules(String bonus_rules) {
        this.bonus_rules = bonus_rules;
    }

    public String getBalance_rules() {
        return balance_rules;
    }

    public void setBalance_rules(String balance_rules) {
        this.balance_rules = balance_rules;
    }

    public String getPrerogative() {
        return prerogative;
    }

    public void setPrerogative(String prerogative) {
        this.prerogative = prerogative;
    }

    public String getBind_old_card_url() {
        return bind_old_card_url;
    }

    public void setBind_old_card_url(String bind_old_card_url) {
        this.bind_old_card_url = bind_old_card_url;
    }

    public String getActivate_url() {
        return activate_url;
    }

    public void setActivate_url(String activate_url) {
        this.activate_url = activate_url;
    }

    public String getTicket_class() {
        return ticket_class;
    }

    public void setTicket_class(String ticket_class) {
        this.ticket_class = ticket_class;
    }

    public String getGuide_url() {
        return guide_url;
    }

    public void setGuide_url(String guide_url) {
        this.guide_url = guide_url;
    }

    public String getMap_url() {
        return map_url;
    }

    public void setMap_url(String map_url) {
        this.map_url = map_url;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTicket() {
        return ticket;
    }

    public void setTicket(String ticket) {
        this.ticket = ticket;
    }

    public String getBegin_timestampstr() {
        return begin_timestampstr;
    }

    public void setBegin_timestampstr(String begin_timestampstr) {
        this.begin_timestampstr = begin_timestampstr;
    }

    public String getEnd_timestampstr() {
        return end_timestampstr;
    }

    public void setEnd_timestampstr(String end_timestampstr) {
        this.end_timestampstr = end_timestampstr;
    }
}
