package com.mtx.common.cache.service;

import java.util.Set;

/**
 * 04 26 2015 Steven
 */
public interface IRedisService {

    void set(String key, Object o);

    <T> T get(String key);

    void hset(String key, String field, Object o);

    void expire(String key, int seconds);

    <T> T hget(String key, String field);

    void hdel(String key, String field);

    void del(String key);

    Set<String> keys(String pattern);

    void clear(String pattern);

    void clear();

    Long getDbSize();
}
