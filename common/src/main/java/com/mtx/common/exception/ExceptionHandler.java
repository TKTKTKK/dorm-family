package com.mtx.common.exception;

import org.apache.shiro.authz.UnauthorizedException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class ExceptionHandler implements HandlerExceptionResolver {
    Logger logger = LoggerFactory.getLogger(ExceptionHandler.class);

    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {
        if(e instanceof UnauthorizedException){
            logger.error("error",e);
            return new ModelAndView("error/403");
        }else if(e instanceof ServiceException){
            logger.error("error",e);
            return new ModelAndView("error/default");
        }else{
            logger.error("error",e);
            return new ModelAndView("error/500");
        }
    }
}
