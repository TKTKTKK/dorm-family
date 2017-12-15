package com.mtx.common.lbs;


import java.io.Serializable;

public class GeocodingAPIResponse implements Serializable {

    private static final long serialVersionUID = 1L;

    private String status;
    private GeocodingAPIResponseResult result;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public GeocodingAPIResponseResult getResult() {
        return result;
    }

    public void setResult(GeocodingAPIResponseResult result) {
        this.result = result;
    }
}
