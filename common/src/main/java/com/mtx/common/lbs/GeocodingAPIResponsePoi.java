package com.mtx.common.lbs;


import java.io.Serializable;

public class GeocodingAPIResponsePoi implements Serializable {

    private static final long serialVersionUID = 1L;
    private String addr;
    private String name;

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
