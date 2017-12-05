package com.mtx.portal.controller.admin;

import com.mtx.wechat.service.WechatBindingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping(value = "/guest")
public class MtxGuestController extends BaseAdminController {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private WechatBindingService wechatBindingService;


    @RequestMapping(value = "/product_center")
    public String product_center() {
        return "guest/product_center";
    }
}