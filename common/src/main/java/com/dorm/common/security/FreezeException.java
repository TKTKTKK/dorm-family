package com.dorm.common.security;

import org.apache.shiro.authc.AuthenticationException;

/**
 * 账号冻结异常处理类
 */
public class FreezeException extends AuthenticationException {
    private static final long serialVersionUID = 1L;

    public FreezeException() {
        super();
    }

    public FreezeException(String message, Throwable cause) {
        super(message, cause);
    }

    public FreezeException(String message) {
        super(message);
    }

    public FreezeException(Throwable cause) {
        super(cause);
    }
}
