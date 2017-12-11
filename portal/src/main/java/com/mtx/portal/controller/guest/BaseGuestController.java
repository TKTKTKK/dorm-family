package com.mtx.portal.controller.guest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class BaseGuestController {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @ModelAttribute
    protected void preHandleRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
