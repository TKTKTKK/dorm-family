package com.mtx.portal.servlet;

import com.mtx.common.base.CommonConstants;
import com.mtx.common.utils.ApplicationContextUtil;
import com.mtx.common.utils.ConfigHolder;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import com.mtx.wechat.factory.RequestMessageFactory;
import com.mtx.wechat.factory.RequestMessageProcessorFactory;
import com.mtx.wechat.processor.RequestMessageProcessor;
import com.mtx.wechat.service.WechatBindingService;
import com.mtx.wechat.utils.MessageUtil;
import com.mtx.wechat.utils.SignUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class WeChatServlet extends HttpServlet {
    private static final long serialVersionUID = 3900009348730209117L;
    private static Logger logger = LoggerFactory.getLogger(WeChatServlet.class);



    /**
     * 确认请求来自微信服务器
     *
     * @param req
     * @param resp
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 微信加密签名
        String signature = req.getParameter("signature");
        // 时间戳
        String timestamp = req.getParameter("timestamp");
        // 随机数
        String nonce = req.getParameter("nonce");
        // 随机字符串
        String echostr = req.getParameter("echostr");

        //绑定的微信内部id，从公众平台设置的URL中传过来
        String bindid = req.getParameter("bindid");

        String token = "";

        if (StringUtils.isNotBlank(bindid)) {
            WechatBindingService wechatBindingService = ApplicationContextUtil.getBean(WechatBindingService.class);
            token = wechatBindingService.getTokenByBindid(bindid);
        }

        PrintWriter out = resp.getWriter();

        // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
        if (SignUtil.checkSignature(signature, timestamp, nonce,token)) {
            out.write(echostr);
        }
        out.close();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding(CommonConstants.ENCODING_UTF8);
        resp.setCharacterEncoding(CommonConstants.ENCODING_UTF8);

        String signature = req.getParameter("signature");
        String timestamp = req.getParameter("timestamp");
        String nonce = req.getParameter("nonce");
        String bindid = req.getParameter("bindid");
        String token = "";
        WechatBinding wechatBinding = new WechatBinding();
        if (StringUtils.isNotBlank(bindid)) {
            try {
                WechatBindingService wechatBindingService = ApplicationContextUtil.getBean(WechatBindingService.class);
                wechatBinding = wechatBindingService.getWechatBindingByBindId(bindid);
                token = wechatBinding.getToken();
            } catch (Exception e) {
                logger.error("error", e);
            }
        }

        if (SignUtil.checkSignature(signature,timestamp,nonce,token)) {
            Map<String, String> requestMap = new HashMap<String, String>();
            try {
                requestMap = MessageUtil.parseXml(req);
                Set<String> keyset = requestMap.keySet();
                logger.info("************Request Message : **************\n");
                StringBuilder sb = new StringBuilder();
                for (String key : keyset) {
                    sb.append(key + " : " + requestMap.get(key) + "\n");
                }
                logger.info(sb.toString());
            } catch (Exception e) {
                logger.error("error", e);
            }

            String toUserName = requestMap.get("ToUserName");
            //该请求使用的bindid已在系统注册，且确实是绑定的公众号在使用
            if (wechatBinding != null && toUserName.equals(wechatBinding.getWechatorigid())) {
                String msgType = requestMap.get("MsgType");
                String providerName = ConfigHolder.getConfigValue("message.provider." + msgType);
                String processorName = ConfigHolder.getConfigValue("message.processor." + msgType);

                logger.info("MsgType : " + msgType);
                String respMessage = null;
                try {
                    RequestMessageFactory requestMessageFactory = new RequestMessageFactory(providerName);
                    BaseRequestMessage reqMessage = requestMessageFactory.getRequestMessage(requestMap);

                    RequestMessageProcessorFactory processorFactory = new RequestMessageProcessorFactory(processorName);
                    RequestMessageProcessor messageProcessor = processorFactory.getProcessor();
                    logger.info("Message Processor : " + messageProcessor.getClass().getSimpleName());
                    respMessage = messageProcessor.process(reqMessage,wechatBinding);
                } catch (Exception e) {
                    logger.error("error",e);
                }

                if (respMessage != null) {
                    logger.info("************Response Message : **************\n" + respMessage);
                }

                PrintWriter out = resp.getWriter();
                out.write(respMessage);
                out.close();
            }
        }
    }
}
