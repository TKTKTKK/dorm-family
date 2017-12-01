package com.mtx.common.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSyntaxException;
import com.mtx.common.base.CommonConstants;
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
import java.util.HashMap;
import java.util.Map;

/**
 * Created by wensheng on 12/26/2014.
 */
public class RequestUtil {
    private static Logger log = LoggerFactory.getLogger(RequestUtil.class);
    private static String domainUrl;
    private static String apiId;
    private static String apiKey;

    public void setDomainUrl(String domainUrl) {
        RequestUtil.domainUrl = domainUrl;
    }

    public static String getDomainUrl() {
        return domainUrl;
    }

    public static String getApiId() {
        return apiId;
    }

    public void setApiId(String apiId) {
        RequestUtil.apiId = apiId;
    }

    public static String getApiKey() {
        return apiKey;
    }

    public void setApiKey(String apiKey) {
        RequestUtil.apiKey = apiKey;
    }

    /**
     * 登录错误三次以上 需输入验证码
     * @param useruame
     * @param isFail
     * @param clean
     * @return
     */
    public static boolean isValidateCodeLogin(String useruame, boolean isFail, boolean clean){
        Map<String, Integer> loginFailMap = (Map<String, Integer>)CacheUtils.get("loginFailMap");
        if (loginFailMap==null){
            loginFailMap = new HashMap<String, Integer>();
            CacheUtils.put("loginFailMap", loginFailMap);
        }
        Integer loginFailNum = loginFailMap.get(useruame);
        if (loginFailNum==null){
            loginFailNum = 0;
        }
        if (isFail){
            loginFailNum++;
            loginFailMap.put(useruame, loginFailNum);
        }
        if (clean){
            loginFailMap.remove(useruame);
        }
        return loginFailNum >= 3;
    }

    /**
     * 获取域名
     * @param httpServletRequest
     * @return
     */
    public static String getDomainName(HttpServletRequest httpServletRequest){
        StringBuffer url = httpServletRequest.getRequestURL();
        return url.delete(url.length() - httpServletRequest.getRequestURI().length(), url.length()).toString();
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
            TrustManager[] tm = { new CommonX509TrustManager() };
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

        } catch (ConnectException e) {
            log.error("ConnectException :{}",e);
        }catch (JsonSyntaxException e){
            log.error("JsonSyntaxException:{}", e);
        }
        catch (Exception e) {
            log.error("https request error:{}", e);
        }
        return null;
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
                    connection.getInputStream(),CommonConstants.ENCODING_UTF8));
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
                    new InputStreamReader(conn.getInputStream(),CommonConstants.ENCODING_UTF8));
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

    /**
     *
     * @param urlString
     * @return
     */
    public static String getResponse(String urlString) {

        StringBuilder sb = new StringBuilder();
        URLConnection urlConn = null;
        InputStreamReader in = null;
        BufferedReader bufferedReader = null;
        try {
            URL url = new URL(urlString);
            urlConn = url.openConnection();
            if (urlConn != null)
                urlConn.setReadTimeout(60 * 1000);
            if (urlConn != null && urlConn.getInputStream() != null) {
                in = new InputStreamReader(urlConn.getInputStream(),CommonConstants.ENCODING_UTF8);
                bufferedReader = new BufferedReader(in);
                if (bufferedReader != null) {
                    int cp;
                    while ((cp = bufferedReader.read()) != -1) {
                        sb.append((char) cp);
                    }
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Exception while calling URL:" + urlString, e);
        } finally {
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException ignore) {
                }
            }
            if (in != null) {
                try {
                    in.close();
                } catch (IOException ignore) {
                }
            }
        }

        return sb.toString();
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
}
