package com.mtx.wechat.manager;

import com.mtx.wechat.menu.Menu;
import com.mtx.wechat.utils.WechatUtil;
import com.mtx.common.utils.ConfigHolder;
import com.mtx.wechat.entity.token.AccessToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by wensheng on 14-11-16.
 */
public class MenuManager {
    private static Logger log = LoggerFactory.getLogger(MenuManager.class);

    public static void createMenu(Menu menu) {

        //todo appid appsecret

        // 第三方用户唯一凭证
        String appId = ConfigHolder.getAppId();
        // 第三方用户唯一凭证密钥
        String appSecret = ConfigHolder.getAppSecret();

        // 调用接口获取access_token
        AccessToken at = WechatUtil.getTestAccessToken(appId, appSecret);

        if (null != at) {
            // 调用接口创建菜单
            int result = WechatUtil.createMenu(menu, at.getAccess_token());

            // 判断菜单创建结果
            if (0 == result)
                log.info("菜单创建成功！");
            else
                log.info("菜单创建失败，错误码：" + result);
        }
    }

    public static void deleteMenu(){

        // 第三方用户唯一凭证
        String appId = ConfigHolder.getAppId();
        // 第三方用户唯一凭证密钥
        String appSecret = ConfigHolder.getAppSecret();

        // 调用接口获取access_token
        AccessToken at = WechatUtil.getTestAccessToken(appId, appSecret);

        if (null != at) {
            // 调用接口创建菜单
            int result = WechatUtil.deleteMenu(at.getAccess_token());

            // 判断菜单创建结果
            if (0 == result)
                log.info("菜单删除成功！");
            else
                log.info("菜单删除失败，错误码：" + result);
        }

    }


}
