package com.dorm.common.lbs;


import java.io.Serializable;

public class GeocodingAPIResponseLocation implements Serializable {

    private static final long serialVersionUID = 1L;

    private String lat;
    private String lng;

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public String getLng() {
        return lng;
    }

    public void setLng(String lng) {
        this.lng = lng;
    }

    public String getString(){
        return lat+","+lng;
    }
}
