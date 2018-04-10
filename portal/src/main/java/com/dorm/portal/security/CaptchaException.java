/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.dorm.portal.security;

import org.apache.shiro.authc.AuthenticationException;

/**
 * 验证码异常处理类
 */
public class CaptchaException extends AuthenticationException {

    private static final long serialVersionUID = 4023754039196328048L;

	public CaptchaException() {
		super();
	}

	public CaptchaException(String message, Throwable cause) {
		super(message, cause);
	}

	public CaptchaException(String message) {
		super(message);
	}

	public CaptchaException(Throwable cause) {
		super(cause);
	}

}
