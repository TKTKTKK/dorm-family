package com.dorm.portal.controller;

import com.dorm.common.utils.LBSUtil;
import com.dorm.wechat.service.WechatBindingService;
import com.dorm.wechat.utils.WechatBindingUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "/api")
public class APIController {
    private Logger logger = LoggerFactory.getLogger(APIController.class);
    @Autowired
    private WechatBindingService wechatBindingService;

    @RequestMapping(value = "/requestJssdkSign", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> requestJssdkSign(String url) {
        return WechatBindingUtil.getJssdkSignature(url,wechatBindingService.getBindid());
    }

    @RequestMapping(value = "/requestFormattedAddress", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> getFormattedAddress(String latitude,String longitude) {
        Map<String,String> retMap = new HashMap<>();
        String location = latitude + "," + longitude;
        logger.info(location);
        String address =  LBSUtil.getAddressNoEx(location);
        logger.info(address);
        retMap.put("address",address);
        return retMap;
    }

}
