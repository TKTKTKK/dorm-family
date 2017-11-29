package com.mtx.portal.controller.guest;

import com.mtx.wechat.service.WpUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class BaseGuestController {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private WpUserService wpUserService;


    /**
     * 判断是否是微信访问
     * @param request
     * @return
     */
    public static boolean isWeChat(HttpServletRequest request) {
        String userAgent = request.getHeader("user-agent").toLowerCase();
        return userAgent == null || userAgent.indexOf("micromessenger") == -1 ? false : true;
    }



    /**
     * 获取微信网页授权code
     * 换取openid
     */
    @ModelAttribute
    protected void preHandleRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
