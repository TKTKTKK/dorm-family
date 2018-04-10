package com.dorm.wechat.utils;

import com.dorm.wechat.entity.WechatError;
import com.dorm.wechat.entity.token.AccessToken;
import com.dorm.wechat.manager.WechatX509TrustManager;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSyntaxException;
import com.dorm.common.base.CommonConstants;
import com.dorm.common.utils.CacheUtils;
import com.dorm.wechat.WechatConstants;
import com.dorm.wechat.menu.Menu;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.ConnectException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Map;

/**
 * 微信工具类
 * created by wensheng on 14-11-16.
 */
public class WechatUtil {
    private static Logger log = LoggerFactory.getLogger(WechatUtil.class);

    // 获取access_token的接口地址（GET）
    private final static String ACCESS_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";
    // 菜单创建（POST）
    public final static String MENU_CREATE_URL = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN";
    public final static String CONDITIONAL_MENU_CREATE_URL = "https://api.weixin.qq.com/cgi-bin/menu/addconditional?access_token=ACCESS_TOKEN";
    public final static String MENU_DELETE_URL = "https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=ACCESS_TOKEN";

    private static AccessToken accessToken = null;

    public static boolean isWechatBrowser(HttpServletRequest request) {
        String userAgent = request.getHeader("user-agent");
        return userAgent != null && userAgent.toLowerCase().contains("micromessenger");
    }

    public static String getOAuthUrl(String appid,String originUrl){
        String redirectUri = null;
        try {
            redirectUri = URLEncoder.encode(originUrl, CommonConstants.ENCODING_UTF8);
        } catch (UnsupportedEncodingException e) {
            log.error(e.getMessage(),e);
        }
        String requestUrl = WechatConstants.WECHAT_OAUTH2_URL.replace(WechatConstants.PARAM_PLACEHOLDER_APPID, appid)
                .replace(WechatConstants.PARAM_PLACEHOLDER_REDIRECT_URI, redirectUri)
                .replace(WechatConstants.PARAM_PLACEHOLDER_STATE, "dorm")
                .replace(WechatConstants.PARAM_PLACEHOLDER_SCOPE, WechatConstants.OAUTH2_SCOPE_BASE);
        log.info("getOAuthUrl : " + requestUrl);
        return requestUrl;
    }

    /**
     * 发起https请求并获取结果
     *
     * @param requestUrl 请求地址
     * @param requestMethod 请求方式（GET、POST）
     * @param outputStr 提交的数据
     */
    public static <T> T httpsRequest(String requestUrl, String requestMethod, String outputStr,Class<T> clazz){

        StringBuffer buffer = new StringBuffer();
        try {
            // 创建SSLContext对象，并使用我们指定的信任管理器初始化
            TrustManager[] tm = { new WechatX509TrustManager() };
            //SSL曝出Poodle漏洞,使用TLSV1代替
            System.setProperty("https.protocols", "TLSv1");
            SSLContext sslContext = SSLContext.getInstance("TLSv1");

            sslContext.init(null, tm, new java.security.SecureRandom());
            // 从上述SSLContext对象中得到SSLSocketFactory对象
            SSLSocketFactory ssf = sslContext.getSocketFactory();

            URL url = new URL(requestUrl);
            HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
            httpUrlConn.setSSLSocketFactory(ssf);

            httpUrlConn.setDoOutput(true);
            httpUrlConn.setDoInput(true);
            httpUrlConn.setUseCaches(false);
            // 设置请求方式（GET/POST）
            httpUrlConn.setRequestMethod(requestMethod);

            if (CommonConstants.REQUEST_METHOD_GET.equalsIgnoreCase(requestMethod))
                httpUrlConn.connect();

            // 当有数据需要提交时
            if (null != outputStr) {
                OutputStream outputStream = httpUrlConn.getOutputStream();
                // 注意编码格式，防止中文乱码
                outputStream.write(outputStr.getBytes(CommonConstants.ENCODING_UTF8));
                outputStream.close();
            }

            // 将返回的输入流转换成字符串
            InputStream inputStream = httpUrlConn.getInputStream();
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream, CommonConstants.ENCODING_UTF8);
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

            String str = null;
            while ((str = bufferedReader.readLine()) != null) {
                buffer.append(str);
            }
            bufferedReader.close();
            inputStreamReader.close();
            // 释放资源
            inputStream.close();
            inputStream = null;
            httpUrlConn.disconnect();

            if (clazz != null) {
                return fromJson(buffer.toString(), clazz);
            }

        } catch (ConnectException ce) {
            log.error("Wechat server connection timed out.");
        }catch (JsonSyntaxException je){
            //解析Json出错，考虑为微信返回错误码
            WechatError wechatError = fromJson(buffer.toString(),WechatError.class);
            log.error(requestUrl + "请求失败 errcode:{} errmsg:{}", wechatError.getErrcode(), wechatError.getErrmsg());
        }
        catch (Exception e) {
            log.error("https request error:{}", e);
        }
        return null;
    }


    /**
     *
     * @param jsonStr
     * @param clazz
     * @param <T>
     * @return
     */
    public static <T> T fromJson(String jsonStr , Class<T> clazz){
        Gson gson = new Gson();
        return gson.fromJson(jsonStr,clazz);

    }

    /**
     *
     * @param obj
     * @return
     */
    public static String toJson(Object obj){
        Gson gson = new Gson();
        return gson.toJson(obj);

    }

    /**
     * 禁止html转义
     * @param obj
     * @return
     */
    public static String toJsonNoHtmlEscaping(Object obj){
        GsonBuilder gb =new GsonBuilder();
        gb.disableHtmlEscaping();
        Gson gson = gb.create();
        return gson.toJson(obj);
    }

    /**
     * 获取access_token
     *
     * @param appid 凭证
     * @param appsecret 密钥
     * @return AccessToken
     */
    public static String getAccessToken(String appid, String appsecret) {
        AccessToken accessToken = (AccessToken) CacheUtils.get(WechatConstants.ACCESS_TOKEN_CACHE, appid);
        if(accessToken != null && !accessToken.tokenExpired()){
            return accessToken.getAccess_token();
        }else{
            synchronized (WechatUtil.class){
                accessToken = (AccessToken)CacheUtils.get(WechatConstants.ACCESS_TOKEN_CACHE,appid);
                if (accessToken == null || accessToken.tokenExpired()) {
                    String requestUrl = ACCESS_TOKEN_URL.replace(WechatConstants.PARAM_PLACEHOLDER_APPID, appid).replace(WechatConstants.PARAM_PLACEHOLDER_APPSECRET, appsecret);
                    accessToken = httpsRequest(requestUrl, CommonConstants.REQUEST_METHOD_GET, null, AccessToken.class);
                    // 如果请求成功
                    if (null != accessToken) {
                        if(accessToken.getErrcode() == 0){
                            accessToken.setCreatedTime(System.currentTimeMillis());
                            CacheUtils.put(WechatConstants.ACCESS_TOKEN_CACHE,appid,accessToken);
                            return accessToken.getAccess_token();
                        }else{
                            log.error("获取token失败 errcode:{} errmsg:{}", accessToken.getErrcode(), accessToken.getErrmsg());
                        }
                    }else{
                        log.error("获取token失败");
                    }
                }
            }
            return null;
        }
    }


    /**
     * 获取access_token,仅供本地测试使用
     * @param appid 凭证
     * @param appsecret 密钥
     * @return AccessToken
     */
    public static AccessToken getTestAccessToken(String appid, String appsecret) {
            String requestUrl = ACCESS_TOKEN_URL.replace(WechatConstants.PARAM_PLACEHOLDER_APPID, appid).replace(WechatConstants.PARAM_PLACEHOLDER_APPSECRET, appsecret);
            AccessToken accessToken = httpsRequest(requestUrl, CommonConstants.REQUEST_METHOD_GET, null, AccessToken.class);
            // 如果请求成功
            if (null != accessToken) {
                if(accessToken.getErrcode() == 0){
                    accessToken.setCreatedTime(System.currentTimeMillis());
                }else{
                    log.error("获取token失败 errcode:{} errmsg:{}", accessToken.getErrcode(), accessToken.getErrmsg());
                }
            }else{
                log.error("获取token失败");
            }
            return accessToken;
        }



    /**
     * 创建菜单
     *
     * @param menu 菜单实例
     * @param accessToken 有效的access_token
     * @return 0表示成功，其他值表示失败
     */
    public static int createMenu(Menu menu, String accessToken) {
        int result = 0;

        // 拼装创建菜单的url
        String url = MENU_CREATE_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        // 将菜单对象转换成json字符串
        String jsonMenu = toJsonNoHtmlEscaping(menu);

        // 调用接口创建菜单
        Map map = httpsRequest(url, CommonConstants.REQUEST_METHOD_POST, jsonMenu,Map.class);

        if (null != map) {
            int errcode = ((Double)map.get("errcode")).intValue();
            if (0 != errcode) {
                result = errcode;
                log.error("创建菜单失败 errcode:{} errmsg:{}", errcode, map.get("errmsg"));
            }
        }

        return result;
    }

    /**
     * 创建个性化菜单
     * @param menu
     * @param accessToken
     * @return
     */
    public static void createConditionalMenu(Menu menu, String accessToken) {
        // 拼装创建菜单的url
        String url = CONDITIONAL_MENU_CREATE_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        // 将菜单对象转换成json字符串
        String jsonMenu = toJsonNoHtmlEscaping(menu);

        // 调用接口创建菜单
        httpsRequest(url, CommonConstants.REQUEST_METHOD_POST, jsonMenu,Map.class);
    }




    /**
     *
     * @param accessToken
     * @return
     */
    public static int deleteMenu(String accessToken) {
        int result = 0;
        String url = MENU_DELETE_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);

        // 调用接口创建菜单
        Map map = httpsRequest(url, CommonConstants.REQUEST_METHOD_GET, null,Map.class);

        if (null != map) {
            int errcode = ((Double)map.get("errcode")).intValue();
            if (0 != errcode) {
                result = errcode;
                log.error("删除菜单失败 errcode:{} errmsg:{}", errcode, map.get("errmsg"));
            }
        }

        return result;
    }

    /**
     * 向指定URL发送GET方法的请求
     *
     * @param url
     *            发送请求的URL
     * @param param
     * @return URL 所代表远程资源的响应结果
     */
    public static <T> T httpGet(String url, String param, Class<T> clazz) {
        String result = "";
        BufferedReader in = null;
        try {
            URL reqUrl = new URL(url);
            // 打开和URL之间的连接
            URLConnection connection = reqUrl.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 建立实际的连接
            connection.connect();

            // 定义 BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(
                    connection.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            log.error("发送GET请求出现异常！" + e);
        }
        // 使用finally块来关闭输入流
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        if (clazz != null) {
            return fromJson(result, clazz);
        }
        return null;
    }

    /**
     * 向指定 URL 发送POST方法的请求
     *
     * @param url
     *            发送请求的 URL
     * @param param
     * @return 所代表远程资源的响应结果
     */
    public static <T> T httpPost(String url, String param,Class<T> clazz) {
        PrintWriter out = null;
        BufferedReader in = null;
        String result = "";
        try {
            URL realUrl = new URL(url);
            // 打开和URL之间的连接
            URLConnection conn = realUrl.openConnection();
            // 设置通用的请求属性
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 发送POST请求必须设置如下两行
            conn.setDoOutput(true);
            conn.setDoInput(true);
            // 获取URLConnection对象对应的输出流
            out = new PrintWriter(conn.getOutputStream());
            // 发送请求参数
            out.print(param);
            // flush输出流的缓冲
            out.flush();
            // 定义BufferedReader输入流来读取URL的响应
            in = new BufferedReader(
                    new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            log.error("发送 POST 请求出现异常！"+e);
        }
        //使用finally块来关闭输出流、输入流
        finally{
            try{
                if(out!=null){
                    out.close();
                }
                if(in!=null){
                    in.close();
                }
            }
            catch(IOException ex){
                ex.printStackTrace();
            }
        }
        if (clazz != null) {
            return fromJson(result, clazz);
        }
        return null;
    }
}
