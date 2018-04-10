package com.dorm.common.utils;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.Credentials;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.AuthCache;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.methods.*;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.codehaus.jackson.JsonFactory;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.map.ObjectMapper;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.net.URI;
import java.net.URISyntaxException;
import java.security.MessageDigest;
import java.util.*;

/**
 * @author steven
 * @since 9/25/15
 */
public class HttpUtils {
    private static final Log LOG = LogFactory.getLog(HttpUtils.class);
    private static final ObjectMapper mapper = new ObjectMapper();

    public static <T> T post(String url, Object params, String username, String password, Class<T> clazz) throws Exception {
        return entityEnclosingRequest("POST", url, params, username, password, clazz);
    }

    public static <T> T put(String url, Object params, String username, String password, Class<T> clazz) throws Exception {
        return entityEnclosingRequest("PUT", url, params, username, password, clazz);
    }

    public static <T> T patch(String url, Object params, String username, String password, Class<T> clazz) throws Exception {
        return entityEnclosingRequest("PATCH", url, params, username, password, clazz);
    }

    public static <T> T get(String url, Map<String, Object> params, String username, String password, Class<T> clazz) throws Exception {
        return baseRequest("GET", url, params, username, password, clazz);
    }

    public static <T> T delete(String url, Map<String, Object> params, String username, String password, Class<T> clazz) throws Exception {
        return baseRequest("DELETE", url, params, username, password, clazz);
    }

    public static <T> T baseRequest(String method, String url, Map<String, Object> params, String username, String password, Class<T> clazz) throws Exception {
        HttpRequestBase request;
        URI uri = buildUri(url, params);
        switch (method) {
            case "GET":
                request = new HttpGet(uri);
                break;
            case "DELETE":
                request = new HttpDelete(uri);
                break;
            default:
                request = new HttpGet(uri);
                break;
        }
        return request(request, uri, username, password, clazz);
    }

    public static <T> T entityEnclosingRequest(String method, String url, Object params, String username, String password, Class<T> clazz) throws Exception {
        HttpRequestBase request;
        URI uri = new URI(url);
        switch (method) {
            case "POST":
                request = new HttpPost(uri);
                break;
            case "PUT":
                request = new HttpPut(uri);
                break;
            case "PATCH":
                request = new HttpPatch(uri);
                break;
            default:
                request = new HttpPost(uri);
                break;
        }
        setEntity(request, params);
        return request(request, uri, username, password, clazz);
    }

    private static <T> T request(HttpRequestBase request, URI uri, String username, String password, Class<T> clazz) throws Exception {

        CloseableHttpResponse response = null;
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            LOG.debug("executing request " + request.getURI());

            if (StringUtils.isNotEmpty(username) && StringUtils.isNotEmpty(password)) {
                response = client.execute(request, createBasicAuthContext(uri, username, password));
            } else {
                response = client.execute(request);
            }

            HttpEntity entity = response.getEntity();
            if (entity != null) {
                String resp = EntityUtils.toString(entity, "UTF-8");
                LOG.debug("response: " + resp);
//                mapper.enableDefaultTyping();
                return mapper.readValue(resp, clazz);
            }
        } finally {
            if (response != null) {
                response.close();
            }
        }
        return null;
    }

    public static String buildUriString(String url, Map<String, Object> params) throws URISyntaxException {
        StringBuilder urlBuilder = new StringBuilder(url);
        if (params != null && !params.isEmpty()) {
            urlBuilder.append(url.contains("?") ? "&" : "?");
            Set<String> keys = params.keySet();
            for (String key : keys) {
                urlBuilder.append(key).append("=").append(params.get(key)).append("&");
            }
            urlBuilder.deleteCharAt(urlBuilder.length() - 1);
        }
        return urlBuilder.toString();
    }

    private static URI buildUri(String url, Map<String, Object> params) throws URISyntaxException {
        return new URI(buildUriString(url,params));
    }

    private static void setEntity(HttpRequestBase request, Object params) throws IOException {
        if (request instanceof HttpEntityEnclosingRequestBase && params != null) {
            StringWriter sw = new StringWriter();
            JsonGenerator gen = new JsonFactory().createJsonGenerator(sw);
            mapper.writeValue(gen, params);
            gen.close();

            StringEntity stringEntity = null;
            stringEntity = new StringEntity(sw.toString(), "UTF-8");
            ((HttpEntityEnclosingRequestBase) request).setEntity(stringEntity);
            request.setHeader("Content-Type", "application/json; charset=utf-8");
        }
    }

    private static HttpClientContext createBasicAuthContext(URI uri, String username, String password) {
        CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
        Credentials defaultCredentials = new UsernamePasswordCredentials(username, password);
        credentialsProvider.setCredentials(new AuthScope(uri.getHost(), uri.getPort()), defaultCredentials);

        HttpClientContext context = HttpClientContext.create();
        context.setCredentialsProvider(credentialsProvider);

        AuthCache authCache = new BasicAuthCache();
        BasicScheme basicAuth = new BasicScheme();
        HttpHost httpHost = new HttpHost(uri.getHost(), uri.getPort(), uri.getScheme());
        authCache.put(httpHost, basicAuth);
        context.setAuthCache(authCache);
        return context;
    }

    public static void main(String[] args) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("api_id", "12345");
        params.put("order_no", "1212121111111");
        params.put("body", "test");
        params.put("amount", "0.01");
        params.put("notify_url", "http://www.xxx.com/pay/notify");
        params.put("return_url", "http://www.xxx.com/pay/return");
        params.put("type", "wechat");
        params.put("openid", "ojWHev9h1Meiv2ZjO7IEUas2PMiM1");
        params.put("created_at", "20151203161523");
        params.put("expire_at", "20151203161623");
        String signature = getSign(params, "678910");
        System.out.println(signature);
        params.put("signature", signature);
        String url =  "http://pay.foodph.cn/prepare/wechat";
//        String url =  "http://localhost:9000/genPayCode";
        Map result = HttpUtils.post(url, params, null, null, Map.class);
        System.out.println(result);
    }

    public static String getSign(Map<String, Object> map, String key) {
        ArrayList list = new ArrayList();
        Iterator size = map.entrySet().iterator();

        while(size.hasNext()) {
            Map.Entry arrayToSort = (Map.Entry)size.next();
            if(arrayToSort.getValue() != "") {
                list.add((String)arrayToSort.getKey() + "=" + arrayToSort.getValue() + "&");
            }
        }

        int var7 = list.size();
        String[] var8 = (String[])list.toArray(new String[var7]);
        Arrays.sort(var8, String.CASE_INSENSITIVE_ORDER);
        StringBuilder sb = new StringBuilder();

        for(int result = 0; result < var7; ++result) {
            sb.append(var8[result]);
        }

        String var9 = sb.toString();
        var9 = var9 + "key=" + key;

        var9 = MD5Encode(var9).toUpperCase();
        return var9;
    }
    private static final String[] hexDigits = new String[]{"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"};

    public static String byteArrayToHexString(byte[] b) {
        StringBuilder resultSb = new StringBuilder();
        byte[] arr$ = b;
        int len$ = b.length;

        for(int i$ = 0; i$ < len$; ++i$) {
            byte aB = arr$[i$];
            resultSb.append(byteToHexString(aB));
        }

        return resultSb.toString();
    }

    private static String byteToHexString(byte b) {
        int n = b;
        if(b < 0) {
            n = 256 + b;
        }

        int d1 = n / 16;
        int d2 = n % 16;
        return hexDigits[d1] + hexDigits[d2];
    }

    public static String MD5Encode(String origin) {
        String resultString = null;

        try {
            MessageDigest e = MessageDigest.getInstance("MD5");
            resultString = byteArrayToHexString(e.digest(origin.getBytes("UTF-8")));
        } catch (Exception var3) {
            var3.printStackTrace();
        }

        return resultString;
    }

    /**
     *
     * @param request
     * @return
     * @throws Exception
     */
    public static <T> T parseJson(HttpServletRequest request,Class<T> clazz) throws Exception{
        InputStream is = request.getInputStream();
        String jsonStr = IOUtils.toString(is);
        LOG.info("***************Json get :" + jsonStr + "****************");
        is.close();
        return mapper.readValue(jsonStr,clazz);
    }

    /**
     *
     * @param request
     * @return
     * @throws Exception
     */
    public static Map<String, String> parseXml(HttpServletRequest request) throws Exception{
        Map<String,String> map = new HashMap<String, String>();

        InputStream is = request.getInputStream();
        SAXReader reader = new SAXReader();
        Document document = reader.read(is);
        Element root = document.getRootElement();
        getChildNodes(root,map);

        is.close();
        return map;
    }

    private static void getChildNodes(Element ele,Map<String, String> map){
        List<Element> children = ele.elements();
        if(children.size() == 0){
            map.put(ele.getName(), ele.getText());
        }else{
            for(Iterator<Element> it = ele.elementIterator();it.hasNext();){
                Element child = it.next();
                getChildNodes(child,map);
            }
        }
    }

}