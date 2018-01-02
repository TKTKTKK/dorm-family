package com.mtx.portal.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class BaseAdminController {

    @ModelAttribute
    public void preHandleRequest(HttpServletRequest req, HttpServletResponse resp, Model model) throws ServletException, IOException{

    }


    @RequestMapping(value = "/error/{code}",method = RequestMethod.GET)
    public String machineInfo(@PathVariable("code") String code){
        return "/error/" + code;
    }
}
