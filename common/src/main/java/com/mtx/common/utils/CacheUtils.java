package com.mtx.common.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * Cache工具类
 */

@Component
public class CacheUtils {

	private static String cacheManagerName;

	@Value("${cache.manager}")
	public void setCacheManagerName(String cacheManagerName) {
		CacheUtils.cacheManagerName = cacheManagerName;
	}

	public static Object get(String key) {
		if("redisCacheManager".equals(cacheManagerName)){
			return RedisCacheUtils.get(key);
		}else{
			return EhCacheUtils.get(key);
		}
	}

	public static void put(String key, Object value) {
		if("redisCacheManager".equals(cacheManagerName)){
			RedisCacheUtils.put(key, value);
		}else{
			EhCacheUtils.put(key, value);
		}
	}

	public static void remove(String key) {
		if("redisCacheManager".equals(cacheManagerName)){
			RedisCacheUtils.remove(key);
		}else{
			EhCacheUtils.remove(key);
		}
	}
	
	public static Object get(String cacheName, String key) {
		if("redisCacheManager".equals(cacheManagerName)){
			return RedisCacheUtils.get(cacheName, key);
		}else{
			return EhCacheUtils.get(cacheName,key);
		}
	}

	public static void put(String cacheName, String key, Object value) {
		if("redisCacheManager".equals(cacheManagerName)){
			RedisCacheUtils.put(cacheName,key, value);
		}else{
			EhCacheUtils.put(cacheName,key, value);
		}
	}

	public static void put(String cacheName, String key, Object value,int seconds ) {
		if("redisCacheManager".equals(cacheManagerName)){
			RedisCacheUtils.put(cacheName,key, value);
			RedisCacheUtils.expire(cacheName,key, seconds);
		}else{
			EhCacheUtils.put(cacheName,key, value);
		}
	}

	public static void remove(String cacheName, String key) {
		if("redisCacheManager".equals(cacheManagerName)){
			RedisCacheUtils.remove(cacheName, key);
		}else{
			EhCacheUtils.remove(cacheName, key);
		}
	}

}
