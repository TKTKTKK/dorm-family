package com.dorm.common.exception;


public class LBSException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    public LBSException() {
    }

    public LBSException(String message) {
        super(message);
    }

    public LBSException(String message, Throwable cause) {
        super(message, cause);
    }

    public LBSException(Throwable cause) {
        super(cause);
    }
}