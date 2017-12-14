package com.mtx.portal.controller;

import com.mtx.wechat.service.WechatBindingService;
import com.mtx.wechat.utils.WechatBindingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
@RequestMapping(value = "/api")
public class APIController {
    @Autowired
    private WechatBindingService wechatBindingService;

    @RequestMapping(value = "/requestJssdkSign", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> requestJssdkSign(String url) {
        return WechatBindingUtil.getJssdkSignature(url,wechatBindingService.getBindid());
    }

}
