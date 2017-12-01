package com.mtx.common.security;

import com.mtx.common.service.PlatformPermitService;
import com.mtx.common.utils.ApplicationContextUtil;
import org.apache.shiro.web.filter.authz.PermissionsAuthorizationFilter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Set;

/**
 * Created by wensheng on 15-3-18.
 */
public class URLPermissionsFilter extends PermissionsAuthorizationFilter {

    @Override
    public boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws IOException {
        String[] perms = buildPermissions(request);
        if( "*".equals(perms[0])){
            return true;
        }else{
            return super.isAccessAllowed(request, response, perms);
        }

    }

    /**
     * 根据请求URL产生权限字符串，这里只产生，而比对的事交给Realm
     * @param request
     * @return
     */
    protected String[] buildPermissions(ServletRequest request) {
        String[] perms = new String[1];
        HttpServletRequest req = (HttpServletRequest) request;
        String path = req.getServletPath();

        PlatformPermitService permitService = ApplicationContextUtil.getBean(PlatformPermitService.class);
        Set<String> permits =  permitService.queryAllPermitList();
        if(permits != null && !permits.isEmpty() && permits.contains(path.toLowerCase())){
            perms[0] = path;//path直接作为权限字符串
        }else{
            perms[0] = "*";
        }
        return perms;
    }
}
