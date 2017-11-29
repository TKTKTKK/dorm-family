package com.mtx.common.cache;


import com.mtx.common.cache.service.IRedisService;
import com.mtx.common.cache.util.ChineseUtil;
import com.mtx.common.cache.annotation.RedisCache;
import com.mtx.common.utils.ConfigHolder;
import com.mtx.common.utils.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.LocalVariableTableParameterNameDiscoverer;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;

import javax.annotation.Resource;
import java.lang.reflect.Method;

@Aspect
public class CacheAspect {
    private static Logger logger = LoggerFactory.getLogger(CacheAspect.class);

    private IRedisService redisService;

    public IRedisService getRedisService() {
        return redisService;
    }

    public void setRedisService(IRedisService redisService) {
        this.redisService = redisService;
    }

    /**
     * 定义缓存逻辑
     */
    @Around("@annotation(redisCache)")
    public Object process(ProceedingJoinPoint pjp, RedisCache redisCache) throws Throwable {
        Object result;
        if (!ConfigHolder.isCacheEnable()) {
            result = pjp.proceed();
        } else {
            CacheKey[] cacheKeys = parseExpression(redisCache.expression());
            if (redisCache.mode() == RedisCache.Mode.CACHE) {
                result = cache(pjp, cacheKeys);
            } else {
                result = pjp.proceed();
                clear(pjp, cacheKeys);
            }
        }
        return result;
    }

    public Object cache(ProceedingJoinPoint pjp, CacheKey[] cacheKeys) throws Throwable {
        Object result = null;
        Method method = getMethod(pjp);
        String key = cacheKeys[0].key;
        String field = cacheKeys[0].field;
        int expire = cacheKeys[0].expire;
        key = parseKey(key, method, pjp.getArgs());
        field = parseKey(field, method, pjp.getArgs());

        try {
            if (StringUtils.isNotEmpty(field)) {
                result = redisService.hget(key, field);
            } else {
                result = redisService.get(key);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }

        if (result == null) {
            result = pjp.proceed();
            if (result != null) {
                try {
                    if (StringUtils.isNotEmpty(field)) {
                        redisService.hset(key, field, result);
                    } else {
                        redisService.set(key, result);
                    }
                    if (expire > 0) {
                        redisService.expire(key, expire);
                    }

                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                }
            }
        } else {
            logger.debug("cache hit: " + key + (StringUtils.isNotEmpty(field) ? ("." + field) : ")"));
        }

        return result;
    }

    public void clear(ProceedingJoinPoint pjp, CacheKey[] cacheKeys) {
        try {
            Method method = getMethod(pjp);
            for (CacheKey cacheKey : cacheKeys) {
                cacheKey.key = parseKey(cacheKey.key, method, pjp.getArgs());
                if (StringUtils.isEmpty(cacheKey.field)) {
                    redisService.clear(cacheKey.key);
                } else {
                    cacheKey.field = parseKey(cacheKey.field, method, pjp.getArgs());
                    redisService.hdel(cacheKey.key, cacheKey.field);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }

    public Method getMethod(ProceedingJoinPoint pjp) {
        Method method = null;
        try {
            MethodSignature methodSignature = (MethodSignature) pjp.getSignature();
            method = methodSignature.getMethod();
            Class[] parameterTypes = method.getParameterTypes();
            method = pjp.getTarget().getClass().getMethod(method.getName(), parameterTypes);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return method;
    }

    /**
     * SPEL表达式 获取缓存的key
     *
     * @param key
     * @param method
     * @param args
     * @return
     */
    private String parseKey(String key, Method method, Object[] args) {
        LocalVariableTableParameterNameDiscoverer u = new LocalVariableTableParameterNameDiscoverer();
        String[] paraNameArr = u.getParameterNames(method);

        ExpressionParser parser = new SpelExpressionParser();
        StandardEvaluationContext context = new StandardEvaluationContext();

        for (int i = 0; i < paraNameArr.length; i++) {
            context.setVariable(paraNameArr[i], args[i]);
        }

        StringBuilder result = new StringBuilder();
        String[] combo = key.split(":");
        for (int i = 0; i < combo.length; i++) {
            if (StringUtils.isNotEmpty(combo[i])) {
                if (i > 0) {
                    result.append(":");
                }
                if (combo[i].startsWith("#")) {
                    result.append(parser.parseExpression(combo[i]).getValue(context, String.class));
                } else {
                    result.append(combo[i]);
                }
            }
        }
        return ChineseUtil.toUnicode(result.toString().replaceAll("null", ""));
    }

    /**
     * | 表达式分隔符
     *
     * @param value
     * @return
     * @throws Exception
     * @ key,field分隔符
     */
    public CacheKey[] parseExpression(String value) throws Exception {
        String[] blocks = value.split("\\|");
        CacheKey[] cacheKeys = new CacheKey[blocks.length];
        for (int i = 0; i < blocks.length; i++) {
            String[] combos = blocks[i].split("@");

            CacheKey cacheKey = new CacheKey();
            cacheKey.key = combos[0];
            if (combos.length >= 2) {
                cacheKey.field = combos[1];
            }
            if (combos.length == 3) {
                cacheKey.expire = Integer.parseInt(combos[2]);
            }
            cacheKeys[i] = cacheKey;
        }
        return cacheKeys;
    }

    private class CacheKey {
        private String key;
        private String field;
        private int expire = 3600;
    }
}
