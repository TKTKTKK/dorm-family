package com.mtx.common.cache.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import redis.clients.jedis.Jedis;

import java.util.Set;

/**
 * 04 26 2015 Steven
 */
public class RedisServiceImpl implements IRedisService {
    private static Logger logger = LoggerFactory.getLogger(RedisServiceImpl.class);

    private RedisTemplate redisTemplate;

    public RedisTemplate getRedisTemplate() {
        return redisTemplate;
    }

    public void setRedisTemplate(RedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    @Override
    public void set(final String key, final Object o) {
        redisTemplate.execute(new RedisCallback() {
            @Override
            public Object doInRedis(RedisConnection redisConnection) throws DataAccessException {
                redisConnection.set(key.getBytes(), redisTemplate.getValueSerializer().serialize(o));
                return null;
            }
        });
    }

    @Override
    public <T> T get(final String key) {
        byte[] bytes = (byte[]) redisTemplate.execute(new RedisCallback() {
            @Override
            public Object doInRedis(RedisConnection redisConnection) throws DataAccessException {
                return redisConnection.get(key.getBytes());
            }
        });

        return (T) redisTemplate.getValueSerializer().deserialize(bytes);
    }

    public void hset(final String key, final String field, final Object o) {
        redisTemplate.execute(new RedisCallback() {
            @Override
            public Object doInRedis(RedisConnection redisConnection) throws DataAccessException {
                ((Jedis) redisConnection.getNativeConnection()).hset(key.getBytes(), field.getBytes(), redisTemplate.getHashValueSerializer().serialize(o));

                return null;
            }
        });
    }

    public void expire(final String key, final int seconds) {
        redisTemplate.execute(new RedisCallback() {
            @Override
            public Object doInRedis(RedisConnection redisConnection) throws DataAccessException {
                return ((Jedis) redisConnection.getNativeConnection()).expire(key, seconds);
            }
        });
    }

    public <T> T hget(final String key, final String field) {
        byte[] bytes = (byte[]) redisTemplate.execute(new RedisCallback() {
            @Override
            public Object doInRedis(RedisConnection redisConnection) throws DataAccessException {
                return redisConnection.hGet(key.getBytes(), field.getBytes());
            }
        });
        return (T) redisTemplate.getValueSerializer().deserialize(bytes);
    }

    public void hdel(final String key, final String field) {
        redisTemplate.execute(new RedisCallback() {
            @Override
            public Object doInRedis(RedisConnection redisConnection) throws DataAccessException {
                Set<byte[]> fields = redisConnection.hKeys(key.getBytes());
                for (byte[] fieldByte : fields) {
                    String fieldStr = new String(fieldByte);
                    if (fieldStr.matches(field)) {
                        redisConnection.hDel(key.getBytes(), fieldStr.getBytes());
                    }
                }
                redisConnection.hDel(key.getBytes(), field.getBytes());
                return null;
            }
        });
    }

    public void del(String key) {
        redisTemplate.delete(key);
    }

    public Set<String> keys(String pattern) {
        return  redisTemplate.keys(pattern);
    }

    public void clear(String pattern) {
        Set<String> keys = redisTemplate.keys(pattern);
        if (!keys.isEmpty()) {
            redisTemplate.delete(keys);
        }
    }

    public void clear() {
        redisTemplate.execute(new RedisCallback() {
            @Override
            public Object doInRedis(RedisConnection redisConnection) throws DataAccessException {
                redisConnection.flushDb();
                return null;
            }
        });
    }

    @Override
    public Long getDbSize() {
        Long dbSize = (Long)redisTemplate.execute(new RedisCallback() {
            @Override
            public Object doInRedis(RedisConnection redisConnection) throws DataAccessException {
                return redisConnection.dbSize();
            }
        });
        return dbSize;
    }
}
