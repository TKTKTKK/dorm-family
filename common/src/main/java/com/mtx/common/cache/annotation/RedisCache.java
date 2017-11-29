package com.mtx.common.cache.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 04 26 2015 Steven
 */
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface RedisCache {
    String expression(); //example: #user@#user.name@3600|#user@#user.age@3600

    Mode mode() default Mode.CACHE;

    enum Mode {
        CACHE,
        CLEAR
    }
}
