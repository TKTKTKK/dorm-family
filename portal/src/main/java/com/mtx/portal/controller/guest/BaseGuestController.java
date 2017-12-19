package com.mtx.portal.controller.guest;

import com.mtx.common.base.CommonConstants;
import com.mtx.portal.PortalContants;
import com.mtx.wechat.entity.WpUser;
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
    private WpUserService wechatUserService;

    protected String getOpenid(HttpServletRequest req){
        return (String)req.getSession().getAttribute(PortalContants.PARAM_OPENID);
    }

    protected String getBindid(HttpServletRequest req){
        return (String)req.getSession().getAttribute(PortalContants.PARAM_BINDID);
    }

    protected WpUser getWechatMemberInfo(HttpServletRequest req){
        WpUser user = new WpUser();
        user.setOpenid(getOpenid(req));
        return wechatUserService.queryForObjectByUniqueKey(user);
    }

    @ModelAttribute
    protected void preHandleRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StringBuffer requestUrl = req.getRequestURL();
        if(requestUrl != null){
            logger.info("requestUrl : " + requestUrl.toString());
        }
        logger.info("bind : " + getBindid(req));
        logger.info("openid : " + getOpenid(req));
        String requestUri = req.getRequestURI();

        if(requestUri.contains("/guest/member")){

            WpUser member = getWechatMemberInfo(req);
            if(member == null || !CommonConstants.IND_YES.equals(member.getIfauth())){
                resp.sendRedirect("/guest/register");
            }
        }
    }
}
