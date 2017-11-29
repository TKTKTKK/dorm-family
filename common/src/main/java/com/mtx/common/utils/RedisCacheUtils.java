package com.mtx.common.utils;

import com.mtx.common.cache.shiro.RedisCache;
import com.mtx.common.cache.shiro.RedisCacheManager;

/**
 * Cache工具类
 */
public class RedisCacheUtils {

	private static RedisCacheManager cacheManager;

	public static RedisCacheManager getCacheManager() {
		return cacheManager;
	}

	public void setCacheManager(RedisCacheManager cacheManager) {
		RedisCacheUtils.cacheManager = cacheManager;
	}

	private static final String SYS_CACHE = "sysCache";

	public static Object get(String key) {
		return get(SYS_CACHE, key);
	}

	public static void put(String key, Object value) {
		put(SYS_CACHE, key, value);
	}

	public static void remove(String key) {
		remove(SYS_CACHE, key);
	}
	
	public static Object get(String cacheName, String key) {
		return getCache(cacheName).get(key);
	}

	public static void put(String cacheName, String key, Object value) {
		getCache(cacheName).put(key, value);
	}

	public static void expire(String cacheName, String key, int second) {
		getCache(cacheName).expire(key, second);
	}

	public static void remove(String cacheName, String key) {
		getCache(cacheName).remove(key);
	}
	
	/**
	 * 获得一个Cache，没有则创建一个。
	 * @param cacheName
	 * @return
	 */
	private static RedisCache getCache(String cacheName){
		return cacheManager.getCache(cacheName);
	}

}
