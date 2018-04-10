package com.dorm.common.exception;

public class EntityStructureException extends RuntimeException {

    public EntityStructureException() {
    }

    public EntityStructureException(String s) {
        super(s);
    }

    public EntityStructureException(String s, Throwable throwable) {
        super(s, throwable);
    }

    public EntityStructureException(Throwable throwable) {
        super(throwable);
    }
}
