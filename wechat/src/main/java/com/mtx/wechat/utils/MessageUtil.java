package com.mtx.wechat.utils;


import com.mtx.wechat.entity.message.response.*;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.mtx.common.utils.StringUtils;
import com.mtx.wechat.entity.message.Article;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.core.util.QuickWriter;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.xml.PrettyPrintWriter;
import com.thoughtworks.xstream.io.xml.XppDriver;
import com.mtx.wechat.entity.message.response.cs.ResponseTransferCsMessage;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.io.StringReader;
import java.io.Writer;
import java.util.*;

public class MessageUtil {

    /**
     * 请求消息类型：文本
     */
    public static final String REQ_MESSAGE_TYPE_TEXT = "text";

    /**
     * 请求消息类型：图片
     */
    public static final String REQ_MESSAGE_TYPE_IMAGE = "image";

    /**
     * 请求消息类型：链接
     */
    public static final String REQ_MESSAGE_TYPE_LINK = "link";

    /**
     * 请求消息类型：地理位置
     */
    public static final String REQ_MESSAGE_TYPE_LOCATION = "location";

    /**
     * 请求消息类型：语音
     */
    public static final String REQ_MESSAGE_TYPE_VOICE = "voice";

    /**
     * 请求消息类型：视频
     */
    public static final String REQ_MESSAGE_TYPE_VIDEO = "video";

    /**
     * 请求消息类型：推送
     */
    public static final String REQ_MESSAGE_TYPE_EVENT = "event";

    /**
     * 事件类型：subscribe(订阅)
     */
    public static final String EVENT_TYPE_SUBSCRIBE = "subscribe";

    /**
     * 事件类型：unsubscribe(取消订阅)
     */
    public static final String EVENT_TYPE_UNSUBSCRIBE = "unsubscribe";

    /**
     * 事件类型：CLICK(自定义菜单点击事件)
     */
    public static final String EVENT_TYPE_CLICK = "CLICK";
    /**
     * 事件类型：扫描二维码，用户已关注公众号
     */
    public static final String EVENT_TYPE_SCAN = "SCAN";

    /**
     * 事件类型：上报地理位置
     */
    public static final String EVENT_TYPE_LOCATION = "LOCATION";

    /**
     * 返回消息类型：文本
     */
    public static final String RESP_MESSAGE_TYPE_TEXT = "text";

    /**
     * 返回消息类型：图片
     */
    public static final String RESP_MESSAGE_TYPE_IMAGE = "image";

    /**
     * 返回消息类型：语音
     */
    public static final String RESP_MESSAGE_TYPE_VOICE = "voice";

    /**
     * 返回消息类型：音乐
     */
    public static final String RESP_MESSAGE_TYPE_MUSIC = "music";

    /**
     * 返回消息类型：音乐
     */
    public static final String RESP_MESSAGE_TYPE_VIDEO = "video";

    /**
     * 返回消息类型：图文
     */
    public static final String RESP_MESSAGE_TYPE_NEWS = "news";

    /**
     * 返回消息类型：转发多客服
     */
    public static final String RESP_MESSAGE_TYPE_TRANSFER_CS = "transfer_customer_service";

    /**
     * 卡券审核结果推送
     */
    public static final String EVENT_TYPE_CARD_PASS = "card_pass_check";
    public static final String EVENT_TYPE_CARD_REJECT = "card_not_pass_check";
    public static final String EVENT_TYPE_CARD_GET = "user_get_card";
    public static final String EVENT_TYPE_CARD_DEL = "user_del_card";

    /**
     * 自动回复URL中bindid和openid的占位符字符串
     */
    public static final String BINDID_OPENID_URL_PLACEHOLDER = "bindid=BINDID&openidd=OPENID";
    public static final String BINDID_URL_PLACEHOLDER = "BINDID";
    public static final String OPENID_URL_PLACEHOLDER = "OPENID";



    /**
     * 解析发来的请求（XML）
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public static Map<String, String> parseXml(HttpServletRequest request) throws Exception{
        Map<String,String> map = new HashMap<String, String>();

        // 从request中取得输入流
        InputStream is = request.getInputStream();
        // 读取输入流
        SAXReader reader = new SAXReader();
        Document document = reader.read(is);
        //得到root节点
        Element root = document.getRootElement();
        //得到root下所有子节点
        getChildNodes(root,map);

        is.close();
        return map;
    }

    /**
     *
     * @param xmlStr
     * @return
     * @throws Exception
     */
    public static Map<String, String> parseXml(String xmlStr) throws Exception{
        Map<String,String> map = new HashMap<String, String>();

        StringReader sr = new StringReader(xmlStr);
        // 读取输入流
        SAXReader reader = new SAXReader();
        Document document = reader.read(sr);
        //得到root节点
        Element root = document.getRootElement();
        //得到root下所有子节点
        getChildNodes(root,map);
        return map;
    }

    //递归获取所有节点
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


    /**
     * 文本消息对象转换成xml
     * @param textMessage
     * @return
     */
    public static String messageToXml(ResponseTextMessage textMessage){
        xstream.alias("xml",ResponseTextMessage.class);
        return xstream.toXML(textMessage);

    }

    /**
     * 音乐消息对象转换成xml
     * @param musicMessage
     * @return
     */
    public static String messageToXml(ResponseMusicMessage musicMessage){
        xstream.alias("xml",ResponseMusicMessage.class);
        return xstream.toXML(musicMessage);

    }

    /**
     * 图文混合消息对象转换成xml
     * @param newsMessage
     * @return
     */
    public static String messageToXml(ResponseNewsMessage newsMessage){
        xstream.alias("xml",ResponseNewsMessage.class);
        xstream.alias("item", Article.class);
        return xstream.toXML(newsMessage);

    }

    /**
     *  图片消息对象转换成xml
     * @param imageMessage
     * @return
     */
    public static String messageToXml(ResponseImageMessage imageMessage){
        xstream.alias("xml",ResponseImageMessage.class);
        return xstream.toXML(imageMessage);

    }

    /**
     * 转发多客服消息转换成xml
     * @param responseTransferCsMessage
     * @return
     */
    public static String messageToXml(ResponseTransferCsMessage responseTransferCsMessage){
        xstream.alias("xml",ResponseTransferCsMessage.class);
        return xstream.toXML(responseTransferCsMessage);

    }

    /**
     * 语音消息对象转换成xml
     * @param voiceMessage
     * @return
     */
    public static String messageToXml(ResponseVoiceMessage voiceMessage){
        xstream.alias("xml",ResponseVoiceMessage.class);
        return xstream.toXML(voiceMessage);

    }

    /**
     * 视频消息对象转换成xml
     * @param videoMessage
     * @return
     */
    public static String messageToXml(ResponseVideoMessage videoMessage){
        xstream.alias("xml",ResponseVideoMessage.class);
        return xstream.toXML(videoMessage);

    }

    /**
     *
     * @param xmlStr
     * @param cls
     * @param <T>
     * @return
     */
    public static <T> T xmltoBean(String xmlStr,Class<T> cls){
        XStream xstream=new XStream(new DomDriver());
        xstream.processAnnotations(cls);
        xstream.ignoreUnknownElements();
        T obj=(T)xstream.fromXML(xmlStr);
        return obj;
    }


    /**
     * 扩展xstream使其支持CDATA
     */
    private static XStream xstream = new XStream(new XppDriver() {
        public HierarchicalStreamWriter createWriter(Writer out) {
            return new PrettyPrintWriter(out) {
                // 对所有xml节点的转换都增加CDATA标记
                boolean cdata = true;

                @SuppressWarnings("unchecked")
                public void startNode(String name, Class clazz) {
                    super.startNode(name, clazz);
                }

                protected void writeText(QuickWriter writer, String text) {
                    if (cdata) {
                        writer.write("<![CDATA[");
                        writer.write(text);
                        writer.write("]]>");
                    } else {
                        writer.write(text);
                    }
                }
            };
        }
    });

    /**
     * 根据请求消息生成回复消息
     * @param reqMessage
     * @return
     */

    public static <T extends BaseResponseMessage> T getRespMessage(BaseRequestMessage reqMessage,T obj){
        obj.setToUserName(reqMessage.getFromUserName());
        obj.setFromUserName(reqMessage.getToUserName());
        obj.setCreateTime(new Date().getTime()/1000);
        obj.setFuncFlag(0);
        return obj;
    }

    /**
     * 将bindId,openId加到url中
     * @param content
     * @param bindid
     * @param openid
     * @return
     */
    public static String getUrlWithBindidAndOpenid(String content,String bindid,String openid){
        if(StringUtils.isNotBlank(content) && content.contains(BINDID_OPENID_URL_PLACEHOLDER)){
            return content.replace(BINDID_URL_PLACEHOLDER,bindid).replace(OPENID_URL_PLACEHOLDER,openid);
        }else {
            return content;
        }
    }

    /**
     * 是否是卡券推送事件
     * @param eventType
     * @return
     */
    public static boolean isCardEvent(String eventType){

        return EVENT_TYPE_CARD_PASS.equals(eventType) || EVENT_TYPE_CARD_REJECT.equals(eventType)
                || EVENT_TYPE_CARD_GET.equals(eventType) || EVENT_TYPE_CARD_DEL.equals(eventType);

    }

}
