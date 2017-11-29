package com.mtx.portal.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class BaseAdminController {

    @ModelAttribute
    public void preHandleRequest(HttpServletRequest req, HttpServletResponse resp, Model model) throws ServletException, IOException{

    }
}
