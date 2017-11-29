package com.mtx.wechat.entity.card.boarding;

import com.mtx.wechat.entity.card.base.Coupon;

/**
 * Created by wensheng on 12/17/2014.
 */
public class BoardingCoupon extends Coupon {

    private String from;
    private String to;
    private String flight;
    private String departure_time;
    private String landing_time;
    private String check_in_url;
    private String gate;
    private String boarding_time;
    private String air_model;

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getFlight() {
        return flight;
    }

    public void setFlight(String flight) {
        this.flight = flight;
    }

    public String getDeparture_time() {
        return departure_time;
    }

    public void setDeparture_time(String departure_time) {
        this.departure_time = departure_time;
    }

    public String getLanding_time() {
        return landing_time;
    }

    public void setLanding_time(String landing_time) {
        this.landing_time = landing_time;
    }

    public String getCheck_in_url() {
        return check_in_url;
    }

    public void setCheck_in_url(String check_in_url) {
        this.check_in_url = check_in_url;
    }

    public String getGate() {
        return gate;
    }

    public void setGate(String gate) {
        this.gate = gate;
    }

    public String getBoarding_time() {
        return boarding_time;
    }

    public void setBoarding_time(String boarding_time) {
        this.boarding_time = boarding_time;
    }

    public String getAir_model() {
        return air_model;
    }

    public void setAir_model(String air_model) {
        this.air_model = air_model;
    }
}
