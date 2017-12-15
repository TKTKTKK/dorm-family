package com.mtx.common.utils;


import com.mtx.common.exception.LBSException;
import com.mtx.common.lbs.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;


@Component
public class LBSUtil {

    private static Logger log = LoggerFactory.getLogger(LBSUtil.class);
    private static String serverAk = ConfigHolder.getConfigValue("server.ak.primary");

    public static String getAddressNoEx(String location) {
        try {
            return getFormattedAddress(location);
        } catch (Exception e) {
            log.error(e.getMessage(),e);
            return null;
        }
    }

    public static String getAddress(String location) {

        String url = "http://api.map.baidu.com/geocoder/v2/?location="
                + location + "&output=json&pois=1&ak="+ serverAk;
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(new LBSMappingJackson2HttpMessageConverter());
        GeocodingAPIResponse geocodingAPIResponse = restTemplate.getForObject(url, GeocodingAPIResponse.class);

        if (geocodingAPIResponse != null) {
            String status = geocodingAPIResponse.getStatus();
            if (RouteMatrixAPIStatusCode.SUCCESS.equals(status)) {
                GeocodingAPIResponseResult result = geocodingAPIResponse.getResult();
                GeocodingAPIResponsePoi[] pois = result.getPois();
                if(pois != null && pois.length > 0){
                    return pois[0].getName();
                }
                return result.getFormatted_address();
            } else {
                throw new LBSException(RouteMatrixAPIStatusCode.getStatusDesc(status));

            }
        }
        throw new LBSException("Geocoding API 没有返回Response");
    }


    public static String getFormattedAddress(String location) {

        String url = "http://api.map.baidu.com/geocoder/v2/?location="
                + location + "&output=json&pois=1&ak="+ serverAk;
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(new LBSMappingJackson2HttpMessageConverter());
        GeocodingAPIResponse geocodingAPIResponse = restTemplate.getForObject(url, GeocodingAPIResponse.class);

        if (geocodingAPIResponse != null) {
            String status = geocodingAPIResponse.getStatus();
            if (RouteMatrixAPIStatusCode.SUCCESS.equals(status)) {
                GeocodingAPIResponseResult result = geocodingAPIResponse.getResult();
                return result.getFormatted_address();
            } else {
                throw new LBSException(RouteMatrixAPIStatusCode.getStatusDesc(status));
            }
        }
        throw new LBSException("Geocoding API 没有返回Response");
    }
}
