package com.mtx.common.utils;

import org.springframework.stereotype.Component;

/**
 * Cache工具类
 */

@Component
public class CacheUtils {

	public static Object get(String key) {
		return EhCacheUtils.get(key);
	}

	public static void put(String key, Object value) {
			EhCacheUtils.put(key, value);
	}

	public static void remove(String key) {
			EhCacheUtils.remove(key);
	}
	
	public static Object get(String cacheName, String key) {
			return EhCacheUtils.get(cacheName,key);
	}

	public static void put(String cacheName, String key, Object value) {
			EhCacheUtils.put(cacheName,key, value);
	}

	public static void put(String cacheName, String key, Object value,int seconds ) {
			EhCacheUtils.put(cacheName,key, value);
	}

	public static void remove(String cacheName, String key) {
			EhCacheUtils.remove(cacheName, key);
	}

}
