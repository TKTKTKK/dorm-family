package com.mtx.portal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by wensheng on 14-12-13.
 */
@Controller
public class IndexController {
    @RequestMapping(value = "/")
    public String index(){
        return "index";
    }
}
