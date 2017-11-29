package com.mtx.common.cache.shiro;

import com.mtx.common.cache.service.IRedisService;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.cache.CacheManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/**
 * Created by wensheng on 2016/1/22.
 */
public class RedisCacheManager implements CacheManager {

    private static final Logger logger = LoggerFactory.getLogger(RedisCacheManager.class);

    private final ConcurrentMap<String, RedisCache> caches = new ConcurrentHashMap<String, RedisCache>();

    private IRedisService redisService;

    /**
     * The Redis key prefix for caches
     */
    private String keyPrefix = "shiro_redis_cache:";

    /**
     * Returns the Redis session keys
     * prefix.
     * @return The prefix
     */
    public String getKeyPrefix() {
        return keyPrefix;
    }

    /**
     * Sets the Redis sessions key
     * prefix.
     * @param keyPrefix The prefix
     */
    public void setKeyPrefix(String keyPrefix) {
        this.keyPrefix = keyPrefix;
    }

    @Override
    public <K, V> RedisCache<K, V> getCache(String name) throws CacheException {
        logger.debug("获取名称为: " + name + " 的RedisCache实例");

        RedisCache c = caches.get(name);

        if (c == null) {

            // create a new cache instance
            c = new RedisCache<K, V>(redisService, name + "-" + keyPrefix);

            // add it to the cache collection
            caches.put(name, c);
        }
        return c;
    }

    public IRedisService getRedisService() {
        return redisService;
    }

    public void setRedisService(IRedisService redisService) {
        this.redisService = redisService;
    }
}
