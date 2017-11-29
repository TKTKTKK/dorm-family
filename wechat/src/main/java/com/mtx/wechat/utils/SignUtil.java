package com.mtx.wechat.utils;


import com.mtx.common.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;

public class SignUtil {
    private static Logger log = LoggerFactory.getLogger(SignUtil.class);

    /**
     * 验证签名
     * @param signature
     * @param timestamp
     * @param nonce
     * @return
     */
    public static boolean checkSignature(String signature, String timestamp, String nonce,String token){
        String[] arr = new String[] { token, timestamp, nonce };
        // 将token、timestamp、nonce三个参数进行字典序排序
        Arrays.sort(arr);

        // 将三个参数字符串拼接成一个字符串
        StringBuilder content = new StringBuilder();
        for(String str : arr){
            content.append(str);
        }

        //将拼接的字符串进行sha1加密
        String tmpStr = null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            byte[] digest = md.digest(content.toString().getBytes());
            tmpStr = byteToStr(digest);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return tmpStr != null && tmpStr.equals(signature.toUpperCase());
    }


    /**
     * 将字节数组转换为字符串
     * @param bytes
     * @return
     */
    private static String byteToStr(byte[] bytes) {
        String strDigest = "";
        for (byte aByte : bytes) {
            strDigest += byteToHexStr(aByte);
        }
        return strDigest;
    }


    /**
     * 将字节转换为十六进制字符串
     * @param mByte
     * @return
     */
    private static String byteToHexStr(byte mByte){
        char[] Digit = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
        char[] tempArr = new char[2];
        tempArr[0] = Digit[(mByte >>> 4) & 0X0F];
        tempArr[1] = Digit[mByte & 0X0F];
        return  new String(tempArr);
    }

    /**
     * JS-SDK权限验证签名
     * @param jsapi_ticket
     * @param url
     * @return
     */
    public static Map<String, String> getJssdkSignature(String jsapi_ticket, String url){
        Map<String, String> ret = new HashMap<String, String>();
        String nonce_str = createNonceStr();
        String timestamp = createTimestamp();
        String string1;
        String signature = "";

        //注意这里参数名必须全部小写，且必须有序
        string1 = "jsapi_ticket=" + jsapi_ticket +
                "&noncestr=" + nonce_str +
                "&timestamp=" + timestamp +
                "&url=" + url;
        log.info(string1);

        //将拼接的字符串进行sha1加密
        String tmpStr = null;
        try {
            MessageDigest crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
            crypt.update(string1.getBytes("UTF-8"));
            signature = byteToHexStr(crypt.digest());
        } catch (NoSuchAlgorithmException e) {
            log.error("error", e);
        }catch (UnsupportedEncodingException e){
            log.error("error",e);
        }

        ret.put("url", url);
        ret.put("jsapi_ticket", jsapi_ticket);
        ret.put("nonceStr", nonce_str);
        ret.put("timestamp", timestamp);
        ret.put("signature", signature);
        return ret;
    }

    /**
     * 将字节数组转换为十六进制字符串
     * @param hash
     * @return
     */
    private static String byteToHexStr(final byte[] hash) {
        Formatter formatter = new Formatter();
        for (byte b : hash)
        {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }

    /**
     *
     * @return
     */
    private static String createNonceStr() {
        return UUID.randomUUID().toString();
    }

    /**
     *
     * @return
     */
    private static String createTimestamp() {
        return Long.toString(System.currentTimeMillis() / 1000);
    }

    /**
     *
     * @param api_ticket
     * @param app_id
     * @param location_id
     * @param card_id
     * @param card_type
     * @return
     */
    public static Map<String, String> getChooseCardSignature(String api_ticket, String app_id, String location_id,String card_id,String card_type){
        Map<String, String> ret = new HashMap<String, String>();
        String signature = "";
        String nonce_str = createNonceStr();
        String time_stamp = createTimestamp();
        List<String> tempList = new ArrayList<String>();
        tempList.add(api_ticket);
        tempList.add(app_id);
        tempList.add(time_stamp);
        tempList.add(nonce_str);
        if(StringUtils.isNoneBlank(location_id)){
            ret.put("location_id",location_id);
            tempList.add(location_id);
        }
        if(StringUtils.isNoneBlank(card_id)){
            ret.put("card_id",card_id);
            tempList.add(card_id);
        }
        if(StringUtils.isNoneBlank(card_type)){
            ret.put("card_type",card_type);
            tempList.add(card_type);
        }
        String[] arr = (String[])tempList.toArray();
        // 将参数进行字典序排序
        Arrays.sort(arr);

        // 将参数字符串拼接成一个字符串
        StringBuilder content = new StringBuilder();
        for(String str : arr){
            content.append(str);
        }

        //将拼接的字符串进行sha1加密
        String tmpStr = content.toString();
        try {
            MessageDigest crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
            crypt.update(tmpStr.getBytes("UTF-8"));
            signature = byteToHexStr(crypt.digest());
        } catch (NoSuchAlgorithmException e) {
            log.error("error",e);
        }catch (UnsupportedEncodingException e){
            log.error("error",e);
        }

        ret.put("app_id",app_id);
        ret.put("time_stamp",time_stamp);
        ret.put("nonce_str",nonce_str);
        ret.put("card_sign",signature);
        ret.put("sign_type","SHA1");
        return ret;
    }


    /**
     *
     * @param api_ticket
     * @param card_id
     * @param code
     * @param openid
     * @param balance
     * @return
     */
    public static Map<String, String> getAddCardConfig(String api_ticket,String card_id,String code,String openid,String balance){
        Map<String, String> ret = new HashMap<String, String>();
        String signature = "";
        String time_stamp = createTimestamp();
        List<String> tempList = new ArrayList<String>();
        tempList.add(api_ticket);
        tempList.add(time_stamp);
        tempList.add(card_id);
        if(StringUtils.isNotBlank(code)){
            ret.put("code",code);
            tempList.add(code);
        }
        if(StringUtils.isNotBlank(openid)){
            ret.put("openid",openid);
            tempList.add(openid);
        }
        if(StringUtils.isNotBlank(balance)){
            ret.put("balance",balance);
            tempList.add(balance);
        }

        signature = wechatSHA1(tempList);

        ret.put("timestamp",time_stamp);
        ret.put("signature",signature);
        String cardExt = WechatUtil.toJson(ret);
        Map<String, String> addCardMap = new HashMap<String, String>();
        addCardMap.put("cardExt",cardExt);
        addCardMap.put("cardId",card_id);
        return addCardMap;
    }


    /**
     *
     * @param api_ticket
     * @param card_id
     * @param card_type
     * @return
     */
    public static Map<String, String> getChooseCard(String api_ticket,String card_id,String card_type){
        Map<String, String> ret = new HashMap<String, String>();
        String signature = "";
        String nonce_str = createNonceStr();
        String time_stamp = createTimestamp();
        List<String> tempList = new ArrayList<String>();
        tempList.add(api_ticket);
        tempList.add(time_stamp);
        tempList.add(nonce_str);
        if(StringUtils.isNoneBlank(card_id)){
            ret.put("card_id",card_id);
            tempList.add(card_id);
        }
        if(StringUtils.isNoneBlank(card_type)){
            ret.put("card_type",card_type);
            tempList.add(card_type);
        }

        signature = wechatSHA1(tempList);

        ret.put("time_stamp",time_stamp);
        ret.put("nonce_str",nonce_str);
        ret.put("card_sign",signature);
        ret.put("sign_type","SHA1");
        return ret;
    }

    /**
     *
     * @param tempList
     * @return
     */
    private static String wechatSHA1(List<String> tempList){
        String signature = "";
        String[] arr = tempList.toArray(new String[tempList.size()]);
        // 将参数进行字典序排序
        Arrays.sort(arr);

        // 将参数字符串拼接成一个字符串
        StringBuilder content = new StringBuilder();
        for(String str : arr){
            content.append(str);
        }

        //将拼接的字符串进行sha1加密
        String tmpStr = content.toString();
        try {
            MessageDigest crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
            crypt.update(tmpStr.getBytes("UTF-8"));
            signature = byteToHexStr(crypt.digest());
        } catch (NoSuchAlgorithmException e) {
            log.error("error",e);
        }catch (UnsupportedEncodingException e){
            log.error("error",e);
        }
        return signature;
    }

}


