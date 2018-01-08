package com.mtx.portal.filter;
import com.mtx.common.utils.ApplicationContextUtil;
import com.mtx.common.utils.StringUtils;
import com.mtx.portal.PortalContants;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.token.WechatOAuth2Token;
import com.mtx.wechat.service.WechatBindingService;
import com.mtx.wechat.service.WpUserService;
import com.mtx.wechat.utils.AdvancedUtil;
import com.mtx.wechat.utils.WechatBindingUtil;
import com.mtx.wechat.utils.WechatUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;


public class WechatOAuthFilter implements Filter {
    private Logger logger = LoggerFactory.getLogger(getClass());
    private WpUserService wpUserService = ApplicationContextUtil.getBean(WpUserService.class);
    private WechatBindingService wechatBindingService = ApplicationContextUtil.getBean(WechatBindingService.class);

    boolean isAjax(HttpServletRequest request) {
        return "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        String requestURI = req.getRequestURI();
        String code = req.getParameter("code");
        String bindid = wechatBindingService.getBindid();
        String openid = (String) req.getSession().getAttribute(PortalContants.PARAM_OPENID);
        WechatBinding wechatBinding = WechatBindingUtil.getWechatBindingByBindId(bindid);

        if (!isAjax(req) && "GET".equalsIgnoreCase(req.getMethod()) && !req.getRequestURI().contains("/static") && WechatUtil.isWechatBrowser(req)) {
            if (StringUtils.isBlank(openid)) {
                if (StringUtils.isNotBlank(code)) {
                    logger.info("request oauth token by code: " + code);
                    WechatOAuth2Token wechatOAuth2Token = null;
                    wechatOAuth2Token = AdvancedUtil.getOAuth2AccessToken(wechatBinding.getAppid(), wechatBinding.getAppsecret(), code);
                    // 用户标识
                    String openId = null;
                    if (wechatOAuth2Token != null) {
                        openId = wechatOAuth2Token.getOpenId();
                    }
                    logger.info(requestURI + " - get openid via OAuth2Token :" + openId);
                    req.getSession().setAttribute(PortalContants.PARAM_OPENID, openId);
                    req.getSession().setAttribute(PortalContants.PARAM_BINDID, bindid);

                    //保存微信用户信息
                    if (StringUtils.isNotBlank(openId)) {
                        final String fBindid = bindid;
                        final String fOpenid = openId;
                        ExecutorService executor = Executors.newSingleThreadExecutor();
                        executor.submit(new Callable<Object>() {
                            @Override
                            public Object call() throws Exception {
                                wpUserService.saveWpUser(fBindid, fOpenid);
                                return null;
                            }
                        });
                    }
                } else {
                    StringBuffer originalUrl = req.getRequestURL();
                    String queryString = req.getQueryString();
                    logger.info("originalUrl : " + originalUrl.toString());
                    logger.info("queryString : " + queryString);
                    String fullUrl = originalUrl + "?" + queryString;
                    logger.info("fullUrl : " + fullUrl);
                    resp.sendRedirect(WechatUtil.getOAuthUrl(wechatBinding.getAppid(), fullUrl));
                    return;
                }
            }
        }
        filterChain.doFilter(req, resp);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }
}
