package com.mtx.common.lbs;

import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;

import java.util.ArrayList;
import java.util.List;


public class LBSMappingJackson2HttpMessageConverter extends MappingJackson2HttpMessageConverter {
    public LBSMappingJackson2HttpMessageConverter() {
        List<MediaType> mediaTypes = new ArrayList<>();
        mediaTypes.add(new MediaType("text","javascript",DEFAULT_CHARSET));
        setSupportedMediaTypes(mediaTypes);
    }
}
