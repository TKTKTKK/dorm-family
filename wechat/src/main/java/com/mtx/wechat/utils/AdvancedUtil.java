package com.mtx.wechat.utils;

import com.mtx.common.service.CommonUploader;
import com.mtx.wechat.entity.*;
import com.mtx.wechat.entity.param.material.BatchSendNewsParam;
import com.mtx.wechat.entity.param.tm.TemplateMessage;
import com.mtx.wechat.entity.qrcode.ActionInfo;
import com.mtx.wechat.entity.qrcode.QrcodeParam;
import com.mtx.wechat.entity.qrcode.Scene;
import com.mtx.wechat.entity.result.qrcode.QrcodeResult;
import com.mtx.wechat.entity.token.WechatOAuth2Token;
import com.mtx.common.base.CommonConstants;
import com.mtx.common.service.Uploader;
import com.mtx.common.utils.*;
import com.mtx.wechat.WechatConstants;
import com.mtx.wechat.entity.param.custom.CustomTextMsg;
import com.mtx.wechat.entity.param.material.BatchGetParam;
import com.mtx.wechat.entity.param.material.Media;
import com.mtx.wechat.entity.result.material.MaterialNewsResult;
import com.mtx.wechat.manager.WechatX509TrustManager;
import com.google.gson.Gson;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wensheng on 14-12-1.
 */
public class AdvancedUtil {
    private static Logger logger = LoggerFactory.getLogger(AdvancedUtil.class);
    private static String WECHAT_BATCH_GET_MATERIAL_URL = "https://api.weixin.qq.com/cgi-bin/material/batchget_material?access_token=ACCESS_TOKEN";
    private static String WECHAT_BATCH_SEND_MATERIAL_URL = "https://api.weixin.qq.com/cgi-bin/message/mass/send?access_token=ACCESS_TOKEN";
    private static String WECHAT_SEND_CUSTOM_SEND_URL = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=ACCESS_TOKEN";
    private static String WECHAT_ADD_TEMPLATE = "https://api.weixin.qq.com/cgi-bin/template/api_add_template?access_token=ACCESS_TOKEN";
    private static String WECHAT_DELETE_TEMPLATE = "https://api.weixin.qq.com/cgi-bin/template/del_private_template?access_token=ACCESS_TOKEN";
    private static String WECHAT_GENERATE_QRCODE = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=ACCESS_TOKEN";


    /**
     * 获取微信OAuth2.0的Access Token
     * @param appid
     * @param secret
     * @param code
     * @return
     */
    public static WechatOAuth2Token getOAuth2AccessToken(String appid, String secret, String code){

        String requestUrl = WechatConstants.WECHAT_OAUTH2_ACCESSTOKEN_URL.replace(WechatConstants.PARAM_PLACEHOLDER_APPID,appid).replace(WechatConstants.PARAM_PLACEHOLDER_APPSECRET, secret).replace(WechatConstants.PARAM_PLACEHOLDER_CODE, code);

        Map map = WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_GET,null,Map.class);
        WechatOAuth2Token wechatOAuth2Token = new WechatOAuth2Token();

        if(map != null){
            String accessToken = (String)map.get("access_token");
            //Gson会将数值型转为Double
            Double expiresIn = (Double)map.get("expires_in");
            String refreshToken = (String)map.get("refresh_token");
            String openId = (String)map.get("openid");
            String scope = (String)map.get("scope");
            if(StringUtils.isNotBlank(accessToken)){
                wechatOAuth2Token.setAccessToken(accessToken);
                wechatOAuth2Token.setExpiresIn(expiresIn.intValue());
                wechatOAuth2Token.setOpenId(openId);
                wechatOAuth2Token.setRefreshToken(refreshToken);
                wechatOAuth2Token.setScope(scope);
            }else{
                logger.error("获取token失败 errcode:{} errmsg:{}", map.get("errcode"), map.get("errmsg"));
            }
        }else{
            logger.error("获取token失败");
        }
        return wechatOAuth2Token;
    }

    /**
     * 获取微信用户信息
     * @param accessToken
     * @param openId
     * @return
     */
    public static WechatUser getWechatUserInfo(String accessToken, String openId){
        String requestUrl = WechatConstants.WECHAT_GET_USER_INFO_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken).replace(WechatConstants.PARAM_PLACEHOLDER_OPENID,openId);
        return WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_GET,null,WechatUser.class);
    }

    /**
     * 网页授权获取用户信息
     * @param accessToken
     * @param openId
     * @return
     */
    public static WechatUser getWechatOAuthUserInfo(String accessToken, String openId){
        String requestUrl = WechatConstants.WECHAT_OAUTH2_GET_USER_INFO_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken).replace(WechatConstants.PARAM_PLACEHOLDER_OPENID,openId);
        return WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_GET,null,WechatUser.class);
    }


    /**
     * 获取关注者列表
     * @param accessToken
     * @param nextOpenId 第一个拉取的openId,若不填则从头拉取
     * @return
     */
    public static WechatUserList getWechatUserList(String accessToken, String nextOpenId){
        if(nextOpenId == null){
            nextOpenId = "";
        }
        String requestUrl = WechatConstants.WECHAT_GET_USER_LIST_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken).replace(WechatConstants.PARAM_PLACEHOLDER_NEXT_OPENID,nextOpenId);
        return  WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_GET,null,WechatUserList.class);
    }

    /**
     * 获取微信所有分组
     * @param accessToken
     * @return
     */
    public static WechatGroups getWechatGroups(String accessToken){
        String requestUrl = WechatConstants.WECHAT_GET_GROUPS_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        return WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_GET,null,WechatGroups.class);
    }

    /**
     * 获取微信用户所在分组
     * @param accessToken
     * @return
     */
    public static Map getWechatGroup(String accessToken,String openid){
        Map<String,String> map = new HashMap<String,String>();
        map.put("openid",openid);
        String jsonStr = WechatUtil.toJson(map);
        String requestUrl = WechatConstants.WECHAT_GET_USER_GROUP_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken);
        return WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_POST,jsonStr,Map.class);
    }

    /**
     * 创建分组
     * @param accessToken
     * @return
     */
    public static Map createWechatGroup(String accessToken,WechatGroup wechatGroup){
        Map map = new HashMap();
        map.put("group", wechatGroup);
        String jsonStr = WechatUtil.toJson(map);
        String requestUrl = WechatConstants.WECHAT_CREATE_GROUP_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken);
        return WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_POST,jsonStr,Map.class);
    }

    /**
     * 修改分组名
     * @param accessToken
     * @return success : {"errcode": 0, "errmsg": "ok"}
     */
    public static Map updateWechatGroup(String accessToken,WechatGroup wechatGroup){
        Map map = new HashMap();
        map.put("group", wechatGroup);
        String jsonStr = WechatUtil.toJson(map);
        String requestUrl = WechatConstants.WECHAT_UPDATE_GROUP_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken);
        return WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_POST,jsonStr,Map.class);
    }

    /**
     *
     * @param accessToken
     * @param wechatGroup
     * @return
     */
    public static Map deleteWechatGroup(String accessToken,WechatGroup wechatGroup){
        Map map = new HashMap();
        map.put("group", wechatGroup);
        String jsonStr = WechatUtil.toJson(map);
        String requestUrl = WechatConstants.WECHAT_DELETE_GROUP_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken);
        return WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_POST,jsonStr,Map.class);
    }

    /**
     * 移动用户分组
     * @param accessToken
     * @param  : {"openid":"oDF3iYx0ro3_7jD4HFRDfrjdCM58","to_groupid":108}
     * @return success : {"errcode": 0, "errmsg": "ok"}
     */
    public static Map updateWechatUserGroup(String accessToken,String openid,String to_groupid){
        Map<String,String> map = new HashMap<String,String>();
        map.put("openid",openid);
        map.put("to_groupid",to_groupid);
        String jsonStr = WechatUtil.toJson(map);
        String requestUrl = WechatConstants.WECHAT_UPDATE_USER_GROUP_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken);
        return WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_POST,jsonStr,Map.class);
    }

    /**
     * 上传媒体文件
     * 媒体文件类型，分别有图片（image）、语音（voice）、视频（video）和缩略图（thumb）
     * @param accessToken
     * @param type
     * @param filePath
     * @return
     */
    public static WechatMedia uploadMedia(String accessToken, String type, String filePath){
        String requestUrl = WechatConstants.WECHAT_UPLOAD_MEDIA_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken).replace(WechatConstants.PARAM_PLACEHOLDER_TYPE,type);
        String filename = getFileName(filePath);
        InputStream is = getFileInputStream(filePath);
        return HttpUpload(requestUrl,filename,is,WechatMedia.class);
    }



    public static <T> T  HttpUpload(String requestUrl, String filename, InputStream is, Class<T> clazz){
        try {
            URL uploadUrl = new URL(requestUrl);
            HttpURLConnection con = (HttpURLConnection) uploadUrl.openConnection();
            con.setRequestMethod("POST"); // 以Post方式提交表单，默认get方式
            con.setDoInput(true);
            con.setDoOutput(true);
            con.setUseCaches(false); // post方式不能使用缓存
            // 设置请求头信息
            con.setRequestProperty("Connection", "Keep-Alive");
            con.setRequestProperty("Charset", "UTF-8");
            // 设置边界
            String BOUNDARY = "----------" + System.currentTimeMillis();
            con.setRequestProperty("Content-Type", "multipart/form-data; boundary="+ BOUNDARY);
            // 请求正文信息
            // 第一部分：
            StringBuilder sb = new StringBuilder();
            sb.append("--"); // 必须多两道线
            sb.append(BOUNDARY);
            sb.append("\r\n");
            sb.append("Content-Disposition: form-data;name=\"file\";filename=\""+ filename + "\"\r\n");
            sb.append("Content-Type:application/octet-stream\r\n\r\n");
            byte[] head = sb.toString().getBytes("utf-8");
            // 获得输出流
            OutputStream out = new DataOutputStream(con.getOutputStream());
            // 输出表头
            out.write(head);
            // 文件正文部分
            // 把文件已流文件的方式 推入到url中
            DataInputStream in = new DataInputStream(is);
            int bytes = 0;
            byte[] bufferOut = new byte[1024];
            while ((bytes = in.read(bufferOut)) != -1) {
                out.write(bufferOut, 0, bytes);
            }
            in.close();
            // 结尾部分
            byte[] foot = ("\r\n--" + BOUNDARY + "--\r\n").getBytes("utf-8");// 定义最后数据分隔线
            out.write(foot);
            out.flush();
            out.close();
            StringBuffer buffer = new StringBuffer();
            BufferedReader reader = null;

            // 定义BufferedReader输入流来读取URL的响应
            reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String line = null;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            Gson gson = new Gson();
            return gson.fromJson(buffer.toString(),clazz);
        } catch (Exception e) {
            logger.error("上传失败！" + e);
        }

        return null;
    }

    /**
     * 下载媒体文件
     * @param accessToken
     * @param mediaId
     * @param savePath
     * @return
     */
    public static String downloadMedia(String accessToken,String mediaId,String savePath){
        String filePath = null;
        String requestUrl = WechatConstants.WECHAT_DOWNLOAD_MEDIA_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken).replace(WechatConstants.PARAM_PLACEHOLDER_MEDIA_ID, mediaId);

        try {
            URL url = new URL(requestUrl);
            HttpURLConnection connection = (HttpURLConnection)url.openConnection();
            connection.setDoInput(true);
            connection.setRequestMethod(CommonConstants.REQUEST_METHOD_GET);

            if(!savePath.endsWith("/")){
                savePath += "/";
            }
            String contentType = connection.getHeaderField("Content-Type");
            String fileExt = getFileExt(contentType);
            //将mediaId作为文件名
            filePath = savePath + mediaId + fileExt;

            BufferedInputStream bis = new BufferedInputStream(connection.getInputStream());
            FileOutputStream fos = new FileOutputStream(new File(filePath));
            byte[] buf = new byte[8192];
            int size = 0;
            while ((size = bis.read(buf)) != -1){
                //写入文件
                fos.write(buf,0,size);
            }
            fos.close();
            bis.close();
            connection.disconnect();
            logger.info("媒体文件成功下载至 : " + filePath);
        } catch (IOException e) {
            filePath = null;
            logger.error("媒体文件下载失败 :{} " , e);
        }
        return filePath;
    }

    /**
     *
     * @param contentType
     * @return
     */
    public static String getFileExt(String contentType){
        logger.info("*************contentType************" + contentType);
        String fileExt = "";
        if("image/jpeg".equals(contentType)){
            fileExt = ".jpeg";
        }else if("audio/mpeg".equals(contentType)){
            fileExt = ".mp3";
        }else if("audio/amr".equals(contentType)){
            fileExt = ".amr";
        }else if("video/mp4".equals(contentType)){
            fileExt = ".mp4";
        }else if("image/mpeg4".equals(contentType)){
            fileExt = ".mp4";
        }
        return fileExt;
    }

    /**
     * 上传素材
     * @param requestUrl
     * @param filePath
     * @param clazz
     * @param <T>
     * @return
     */
    public static <T> T httpsUploadRequest(String requestUrl, String filePath, Class<T> clazz) {
        String filename = getFileName(filePath);
        InputStream is = getFileInputStream(filePath);
        return httpsUpload(requestUrl, filename, is, clazz);
    }


    private static InputStream getFileInputStream(String filePath){
        InputStream is = null;
        if (filePath.startsWith("http")) {
            try {
                URL url = new URL(filePath);
                is = url.openStream();
            } catch (IOException e) {
                logger.error(e.getMessage(), e);
            }
        } else {
            File file = new File(filePath);
            if (!file.exists() || !file.isFile()) {
                logger.error("文件不存在");
                return null;
            } else {
                try {
                    is = new FileInputStream(file);
                } catch (FileNotFoundException e) {
                    logger.error(e.getMessage(), e);
                }
            }
        }
        return is;

    }


    /**
     *
     * @param requestUrl
     * @param filename
     * @param is
     * @param clazz
     * @param <T>
     * @return
     */
    public static <T> T httpsUpload(String requestUrl, String filename, InputStream is, Class<T> clazz){

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
            httpUrlConn.setRequestMethod(CommonConstants.REQUEST_METHOD_POST);
            httpUrlConn.setDoOutput(true);
            httpUrlConn.setDoInput(true);
            httpUrlConn.setUseCaches(false);

            // 设置请求头信息
            httpUrlConn.setRequestProperty("Connection", "Keep-Alive");
            httpUrlConn.setRequestProperty("Charset", "UTF-8");
            // 设置边界
            String BOUNDARY = "----------" + System.currentTimeMillis();
            httpUrlConn.setRequestProperty("Content-Type", "multipart/form-data; boundary="+ BOUNDARY);

            // 请求正文信息
            // 第一部分：
            StringBuilder sb = new StringBuilder();
            sb.append("--"); // 必须多两道线
            sb.append(BOUNDARY);
            sb.append("\r\n");
            sb.append("Content-Disposition: form-data;name=\"file\";filename=\""+ filename + "\"\r\n");
            sb.append("Content-Type:application/octet-stream\r\n\r\n");
            byte[] head = sb.toString().getBytes("utf-8");
            // 获得输出流
            OutputStream out = new DataOutputStream(httpUrlConn.getOutputStream());
            // 输出表头
            out.write(head);

            // 文件正文部分
            // 把文件以流文件的方式 推入到url中
            DataInputStream in = new DataInputStream(is);
            int bytes = 0;
            byte[] bufferOut = new byte[1024];
            while ((bytes = in.read(bufferOut)) != -1) {
                out.write(bufferOut, 0, bytes);
            }
            in.close();
            // 结尾部分
            byte[] foot = ("\r\n--" + BOUNDARY + "--\r\n").getBytes("utf-8");// 定义最后数据分隔线
            out.write(foot);
            out.flush();
            out.close();

            StringBuffer buffer = new StringBuffer();
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

            Gson gson = new Gson();
            return gson.fromJson(buffer.toString(),clazz);
        } catch (Exception e) {
            logger.error("上传失败",e);
        }
        return null;
    }


    private static String getFileName(String fileUrl){
        return fileUrl.substring(fileUrl.lastIndexOf("/"));
    }

    /**
     * 发送模板消息
     * @param accessToken
     * @param tm
     * @return
     */
    public static WechatError sendTemplateMessage(String accessToken, TemplateMessage tm){
        String jsonStr = WechatUtil.toJson(tm);
        String requestUrl = WechatConstants.WECHAT_TM_SEND_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        return WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_POST,jsonStr,WechatError.class);
    }

    public static WechatError sendTemplateMessage(String accessToken,String tm){
        String requestUrl = WechatConstants.WECHAT_TM_SEND_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN, accessToken);
        return WechatUtil.httpsRequest(requestUrl,CommonConstants.REQUEST_METHOD_POST,tm,WechatError.class);
    }
    /**
     * 下载媒体文件到本地服务器（拍照或选择图片上传微信后）
     * @param accessToken
     * @param mediaId
     * @return
     */
    public static String saveMediaLocal(String accessToken,String mediaId,String type){
        String viewPath = null;
        String requestUrl = WechatConstants.WECHAT_DOWNLOAD_MEDIA_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken).replace(WechatConstants.PARAM_PLACEHOLDER_MEDIA_ID, mediaId);

        try {
            URL url = new URL(requestUrl);
            HttpURLConnection connection = (HttpURLConnection)url.openConnection();
            connection.setDoInput(true);
            connection.setRequestMethod(CommonConstants.REQUEST_METHOD_GET);
            File uploadFile = UploadUtils.createFolder(type);
            String uploadFolderRoot = uploadFile.getAbsolutePath();
            if(!uploadFolderRoot.endsWith("/")){
                uploadFolderRoot += "/";
            }
            String contentType = connection.getHeaderField("Content-Type");
            String fileExt = getFileExt(contentType);
            //将mediaId作为文件名
            String filePath = uploadFolderRoot + mediaId + fileExt;

            BufferedInputStream bis = new BufferedInputStream(connection.getInputStream());
            FileOutputStream fos = new FileOutputStream(new File(filePath));
            byte[] buf = new byte[8192];
            int size = 0;
            while ((size = bis.read(buf)) != -1){
                //写入文件
                fos.write(buf,0,size);
            }
            fos.close();
            bis.close();
            connection.disconnect();
            logger.info("媒体文件成功下载至 : " + filePath);
            viewPath = UploadUtils.getFolder(type) + mediaId + fileExt;
        } catch (IOException e) {
            logger.error("媒体文件下载失败 :{} " , e);
        }
        return viewPath;
    }


    /**
     * 根据upload具体实现，将媒体文件下载到本地服务器或上传至文件服务器（拍照或选择图片上传微信后）
     * @param accessToken
     * @param mediaId
     * @return
     */
    public static String saveMedia(String accessToken,String mediaId,String type){
        Uploader uploader = ApplicationContextUtil.getBean(CommonUploader.class);
        String viewPath = null;
        String requestUrl = WechatConstants.WECHAT_DOWNLOAD_MEDIA_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken).replace(WechatConstants.PARAM_PLACEHOLDER_MEDIA_ID, mediaId);

        try {
            URL url = new URL(requestUrl);
            HttpURLConnection connection = (HttpURLConnection)url.openConnection();
            connection.setDoInput(true);
            connection.setRequestMethod(CommonConstants.REQUEST_METHOD_GET);
            String contentType = connection.getHeaderField("Content-Type");
            String fileExt = getFileExt(contentType);
            //将mediaId作为文件名
            byte[] contentBuffer = IOUtils.toByteArray(connection.getInputStream());
            viewPath = uploader.uploadFile(contentBuffer,type,fileExt);
        } catch (IOException e) {
            logger.error("媒体文件下载失败 :{} " , e);
        }
        return viewPath;
    }


    /**
     * 批量获取图文
     * @param accessToken
     * @param offset
     * @param count
     * @return
     */
    public static MaterialNewsResult BatchGetMaterialNews(String accessToken,int offset,int count){
        String requestUrl =  WECHAT_BATCH_GET_MATERIAL_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken);
        BatchGetParam param = new BatchGetParam();
        param.setType("news");
        param.setOffset(offset);
        param.setCount(count);
        String jsonStr = RequestUtil.toJson(param);
        return RequestUtil.httpsRequest(requestUrl, "POST", jsonStr, MaterialNewsResult.class);
    }

    /**
     * 根据OpenID列表群发图文
     * @param accessToken
     * @param mediaId
     * @param openids
     * @return
     */
    public static WechatError BatchSendMaterialNews(String accessToken,String mediaId,List<String> openids){
        String requestUrl = WECHAT_BATCH_SEND_MATERIAL_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken);

        BatchSendNewsParam bp = new BatchSendNewsParam();
        bp.setTouser(openids);
        Media media = new Media();
        media.setMedia_id(mediaId);
        bp.setMpnews(media);

        String jsonStr = RequestUtil.toJson(bp);

        return RequestUtil.httpsRequest(requestUrl, "POST", jsonStr, WechatError.class);
    }

    /**
     *
     * @param accessToken
     * @param openId
     * @param textMsg
     * @return
     */
    public static WechatError sendCustomMsg(String accessToken,String openId,String textMsg){
        String requestUrl = WECHAT_SEND_CUSTOM_SEND_URL.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken);

        CustomTextMsg customTextMsg = new CustomTextMsg(openId,textMsg);
        String jsonStr = RequestUtil.toJson(customTextMsg);

        return RequestUtil.httpsRequest(requestUrl, "POST", jsonStr, WechatError.class);
    }

    /**
     *
     * @param accessToken
     * @param shortTemplateId
     * @return
     */
    public static String addTemplate(String accessToken,String shortTemplateId){
        String requestUrl = WECHAT_ADD_TEMPLATE.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken);

        Map<String,String> paramMap = new HashMap<String,String>();
        paramMap.put("template_id_short",shortTemplateId);
        String jsonStr = RequestUtil.toJson(paramMap);

        Map retMap =  RequestUtil.httpsRequest(requestUrl, "POST", jsonStr, Map.class);
        return (String)retMap.get("template_id");
    }

    /**
     *
     * @param accessToken
     * @param templateId
     * @return
     */
    public static WechatError deleteTemplate(String accessToken,String templateId){
        String requestUrl = WECHAT_DELETE_TEMPLATE.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken);

        Map<String,String> paramMap = new HashMap<String,String>();
        paramMap.put("template_id",templateId);
        String jsonStr = RequestUtil.toJson(paramMap);

        return RequestUtil.httpsRequest(requestUrl, "POST", jsonStr, WechatError.class);
    }

    /**
     *
     * @param accessToken
     * @param sceneStr
     * @return
     */
    public static QrcodeResult generateQrcode(String accessToken, String sceneStr){
        String requestUrl = WECHAT_GENERATE_QRCODE.replace(WechatConstants.PARAM_PLACEHOLDER_ACCESS_TOKEN,accessToken);

        QrcodeParam qrcodeParam = new QrcodeParam();
        ActionInfo actionInfo = new ActionInfo();
        Scene scene = new Scene();
        scene.setScene_str(sceneStr);
        actionInfo.setScene(scene);

        qrcodeParam.setAction_name("QR_LIMIT_STR_SCENE");
        qrcodeParam.setAction_info(actionInfo);

        String jsonStr = RequestUtil.toJson(qrcodeParam);

        return RequestUtil.httpsRequest(requestUrl, "POST", jsonStr, QrcodeResult.class);
    }

}
