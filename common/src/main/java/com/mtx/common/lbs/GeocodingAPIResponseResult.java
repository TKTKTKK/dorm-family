package com.mtx.common.lbs;


import java.io.Serializable;

public class GeocodingAPIResponseResult implements Serializable {

    private static final long serialVersionUID = 1L;

    private String precise;
    private String confidence;
    private String formatted_address;
    private GeocodingAPIResponseLocation location;
    private GeocodingAPIResponsePoi[] pois;


    public String getPrecise() {
        return precise;
    }

    public void setPrecise(String precise) {
        this.precise = precise;
    }

    public String getConfidence() {
        return confidence;
    }

    public void setConfidence(String confidence) {
        this.confidence = confidence;
    }

    public String getFormatted_address() {
        return formatted_address;
    }

    public void setFormatted_address(String formatted_address) {
        this.formatted_address = formatted_address;
    }

    public GeocodingAPIResponseLocation getLocation() {
        return location;
    }

    public void setLocation(GeocodingAPIResponseLocation location) {
        this.location = location;
    }

    public GeocodingAPIResponsePoi[] getPois() {
        return pois;
    }

    public void setPois(GeocodingAPIResponsePoi[] pois) {
        this.pois = pois;
    }
}
