package com.mtx.common.cache.shiro;

import com.mtx.common.cache.service.IRedisService;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.eis.AbstractSessionDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by wensheng on 2016/1/22.
 */


public class RedisSessionDAO extends AbstractSessionDAO {
    private static Logger logger = LoggerFactory.getLogger(RedisSessionDAO.class);

    IRedisService redisService;

    public IRedisService getRedisService() {
        return redisService;
    }

    public void setRedisService(IRedisService redisService) {
        this.redisService = redisService;
    }

    /**
     * The Redis key prefix for the sessions
     */
    private String keyPrefix = "shiro_redis_session:";

    @Override
    public void update(Session session) throws UnknownSessionException {
        this.saveSession(session);
    }

    /**
     * save session
     * @param session
     * @throws UnknownSessionException
     */
    private void saveSession(Session session) throws UnknownSessionException{
        if(session == null || session.getId() == null){
            logger.error("session or session id is null");
            return;
        }
        String key = buildRedisSessionKey(session.getId());
        redisService.set(key, session);
    }

    /**
     *
     * @param sessionId
     * @return
     */
    private String buildRedisSessionKey(Serializable sessionId) {
        return keyPrefix + sessionId;
    }

    @Override
    public void delete(Session session) {
        if(session == null || session.getId() == null){
            logger.error("session or session id is null");
            return;
        }
        redisService.del(buildRedisSessionKey(session.getId()));

    }

    //用来统计当前活动的session
    @Override
    public Collection<Session> getActiveSessions() {
        Set<Session> sessions = new HashSet<Session>();

        Set<String> keys = redisService.keys(this.keyPrefix + "*");
        if(keys != null && keys.size()>0){
            for(String key:keys){
                Session s = redisService.get(key);
                sessions.add(s);
            }
        }
        return sessions;
    }

    @Override
    protected Serializable doCreate(Session session) {
        Serializable sessionId = this.generateSessionId(session);
        this.assignSessionId(session, sessionId);
        this.saveSession(session);
        return sessionId;
    }

    @Override
    protected Session doReadSession(Serializable sessionId) {
        if(sessionId == null){
            logger.error("session id is null");
            return null;
        }

        Session s = redisService.get(buildRedisSessionKey(sessionId));
        return s;
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
}
