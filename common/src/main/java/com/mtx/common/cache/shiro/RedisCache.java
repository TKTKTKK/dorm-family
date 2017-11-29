package com.mtx.common.cache.shiro;

import com.mtx.common.cache.service.IRedisService;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.apache.shiro.util.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;

/**
 * Created by wensheng on 2016/1/22.
 */
public class RedisCache<K, V> implements Cache<K, V> {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    private IRedisService redisService;

    /**
     * The Redis key prefix for the sessions
     */
    private String keyPrefix = "shiro_redis_cache:";

    /**
     *
     * @param redisService
     */
    public RedisCache(IRedisService redisService){
        if (redisService == null) {
            throw new IllegalArgumentException("CacheService argument cannot be null.");
        }
        this.redisService = redisService;
    }

    /**
     *
     * @param redisService
     * @param prefix
     */
    public RedisCache(IRedisService redisService,String prefix){
        this( redisService );
        // set the prefix
        this.keyPrefix = prefix;
    }

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


    private String buildRedisCacheKey(K key) {
        return keyPrefix + key;
    }

    @Override
    public V get(K key) throws CacheException {
        logger.debug("根据key从Redis中获取对象 key [" + key + "]");
        try {
            if (key == null) {
                return null;
            }else{
                String cacheKey = buildRedisCacheKey(key);
                V value = redisService.get(cacheKey);
                return value;
            }
        } catch (Throwable t) {
            throw new CacheException(t);
        }

    }

    @Override
    public V put(K key, V value) throws CacheException {
        logger.debug("根据key存储value: key [" + key + "]");
        try {
            String cacheKey = buildRedisCacheKey(key);
            redisService.set(cacheKey,value);
            return value;
        } catch (Throwable t) {
            throw new CacheException(t);
        }
    }

    @Override
    public V remove(K key) throws CacheException {
        logger.debug("从redis中删除 key [" + key + "]");
        try {
            V previous = get(key);
            String cacheKey = buildRedisCacheKey(key);
            redisService.del(cacheKey);
            return previous;
        } catch (Throwable t) {
            throw new CacheException(t);
        }
    }

    @Override
    public void clear() throws CacheException {
        logger.debug("从redis中删除所有元素");
        try {
            redisService.clear();
        } catch (Throwable t) {
            throw new CacheException(t);
        }
    }

    public void expire(K key,int seconds) throws CacheException {
        logger.debug("设置过期时间");
        try {
            if (key != null) {
                String cacheKey = buildRedisCacheKey(key);
                redisService.expire(cacheKey,seconds);
            }
        } catch (Throwable t) {
            throw new CacheException(t);
        }
    }

    @Override
    public int size() {
        try {
            Long longSize = redisService.getDbSize();
            return longSize.intValue();
        } catch (Throwable t) {
            throw new CacheException(t);
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public Set<K> keys() {
        try {
            Set<String> keys = redisService.keys(this.keyPrefix + "*");
            if (CollectionUtils.isEmpty(keys)) {
                return Collections.emptySet();
            }else{
                Set<K> newKeys = new HashSet<K>();
                for(String key:keys){
                    newKeys.add((K)key);
                }
                return newKeys;
            }
        } catch (Throwable t) {
            throw new CacheException(t);
        }
    }

    @Override
    public Collection<V> values() {
        try {
            Set<String> keys = redisService.keys(this.keyPrefix + "*");
            if (!CollectionUtils.isEmpty(keys)) {
                List<V> values = new ArrayList<V>(keys.size());
                for (String key : keys) {
                    @SuppressWarnings("unchecked")
                    V value = get((K)key);
                    if (value != null) {
                        values.add(value);
                    }
                }
                return Collections.unmodifiableList(values);
            } else {
                return Collections.emptyList();
            }
        } catch (Throwable t) {
            throw new CacheException(t);
        }
    }
}
