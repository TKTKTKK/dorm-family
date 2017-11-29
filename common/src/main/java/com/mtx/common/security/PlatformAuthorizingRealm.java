package com.mtx.common.security;

import com.mtx.common.entity.PlatformPermit;
import com.mtx.common.entity.PlatformRole;
import com.mtx.common.service.PlatformUserService;
import com.mtx.common.utils.CacheUtils;
import com.mtx.common.utils.Encodes;
import com.mtx.common.utils.RequestUtil;
import com.mtx.common.utils.UserUtils;
import com.mtx.common.entity.PlatformUser;
import com.mtx.common.service.PlatformPermitService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.Serializable;
import java.util.*;

/**
 * 系统安全认证实现类
 */
@Service
public class PlatformAuthorizingRealm extends AuthorizingRealm {

    @Autowired
	private PlatformUserService platformUserService;
    @Autowired
	private PlatformPermitService platformPermitService;


    @Autowired
    public void setCacheManager(CacheManager cacheManager) {
        super.setCacheManager(cacheManager);
    }


    @Override
    public String getAuthorizationCacheName() {
        return "shiro.realm.authorizationCache";
    }

    /**
     * 认证回调函数, 登录时调用
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
        UsernamePasswordToken token = new UsernamePasswordToken();
        if (authcToken instanceof UsernamePasswordToken) {
            token = (UsernamePasswordToken) authcToken;
        }else if(authcToken instanceof org.apache.shiro.authc.UsernamePasswordToken) {
            token.setUsername(((org.apache.shiro.authc.UsernamePasswordToken) authcToken).getUsername());
            token.setPassword(((org.apache.shiro.authc.UsernamePasswordToken) authcToken).getPassword());
            token.setHost(((org.apache.shiro.authc.UsernamePasswordToken) authcToken).getHost());
        }


        if (RequestUtil.isValidateCodeLogin(token.getUsername(), false, false)){
            // 判断验证码
//            Session session = SecurityUtils.getSubject().getSession();
//            String code = (String)session.getAttribute(FormAuthenticationFilter.DEFAULT_CAPTCHA_PARAM);

            String code = (String) CacheUtils.get(FormAuthenticationFilter.DEFAULT_CAPTCHA_PARAM,token.getUsername());

            if (token.getCaptcha() == null || !token.getCaptcha().toUpperCase().equals(code)){
                throw new CaptchaException("验证码错误.");
            }
        }

        PlatformUser platformUser = platformUserService.getPlatformUserByUserName(token.getUsername());

        if (platformUser != null) {
            byte[] salt = Encodes.decodeHex(platformUser.getPassword().substring(0, 16));
            return new SimpleAuthenticationInfo(new Principal(platformUser),
                    platformUser.getPassword().substring(16), ByteSource.Util.bytes(salt), getName());
        } else {
            return null;
        }
    }

    /**
     * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        Principal principal = (Principal) getAvailablePrincipal(principals);
        PlatformUser platformUser = platformUserService.getPlatformUserByUserName(principal.getLoginName());
        if (platformUser != null) {
            UserUtils.putCache(UserUtils.CACHE_USER, platformUser);
            SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
            List<PlatformRole> roles = platformUserService.getUserRoleList(platformUser.getUuid());
            Set<String> roleSet = new HashSet<String>();
            for(PlatformRole role : roles){
                roleSet.add(role.getRolekey());
            }
            info.setRoles(roleSet);

            //获取当前用户菜单
            UserUtils.getMenuList();
            //添加基于Permission的权限信息
            List<PlatformPermit> permissions = platformPermitService.queryPermitListByUserId(platformUser.getUuid());
            for(PlatformPermit permission : permissions){
                String tempPermission = "/"+permission.getPermitresource().toLowerCase();
                if(tempPermission.contains("?")){
                    tempPermission = tempPermission.substring(0,tempPermission.indexOf("?"));
                }
                info.addStringPermission(tempPermission);
            }
            return info;
        } else {
            return null;
        }
    }
	
	/**
	 * 设定密码校验的Hash算法与迭代次数
	 */
	@PostConstruct
	public void initCredentialsMatcher() {
		HashedCredentialsMatcher matcher = new HashedCredentialsMatcher(PlatformUserService.HASH_ALGORITHM);
		matcher.setHashIterations(PlatformUserService.HASH_INTERATIONS);
		setCredentialsMatcher(matcher);
	}

    /**
     * 清空用户关联权限认证，待下次使用时重新加载
     */
    public void clearCachedAuthorizationInfo(String principal) {
        SimplePrincipalCollection principals = new SimplePrincipalCollection(principal, getName());
        clearCachedAuthorizationInfo(principals);
    }

    /**
     * 清空所有关联认证
     */
    public void clearAllCachedAuthorizationInfo() {
        Cache<Object, AuthorizationInfo> cache = getAuthorizationCache();
        if (cache != null) {
            for (Object key : cache.keys()) {
                cache.remove(key);
            }
        }
    }

	
	/**
	 * 授权用户信息
	 */
	public static class Principal implements Serializable {

        private static final long serialVersionUID = 7529448817993980217L;
		
		private String id;
		private String loginName;
		private String name;
		private Map<String, Object> cacheMap;

		public Principal(PlatformUser user) {
			this.id = user.getUuid();
			this.loginName = user.getUsername();
			this.name = user.getName();
		}

		public String getId() {
			return id;
		}

		public String getLoginName() {
			return loginName;
		}

		public String getName() {
			return name;
		}

		public Map<String, Object> getCacheMap() {
			if (cacheMap==null){
				cacheMap = new HashMap<String, Object>();
			}
			return cacheMap;
		}

        /**
         * 本函数输出将作为默认的<shiro:principal/>输出.
         */
        @Override
        public String toString() {
            return loginName;
        }

	}
}
