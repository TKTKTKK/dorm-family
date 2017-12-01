package com.mtx.wechat.service;

import com.mtx.common.utils.RequestUtil;
import com.mtx.common.utils.StringUtils;
import com.mtx.wechat.WechatConstants;
import com.mtx.wechat.entity.admin.RespArticle;
import com.mtx.wechat.entity.admin.RespSetting;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.admin.WechatTm;
import com.mtx.wechat.entity.message.Article;
import com.mtx.wechat.entity.message.Image;
import com.mtx.wechat.entity.message.Music;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import com.mtx.wechat.entity.message.response.ResponseImageMessage;
import com.mtx.wechat.entity.message.response.ResponseMusicMessage;
import com.mtx.wechat.entity.message.response.ResponseNewsMessage;
import com.mtx.wechat.entity.message.response.ResponseTextMessage;
import com.mtx.wechat.entity.message.response.cs.ResponseTransferCsMessage;
import com.mtx.wechat.entity.message.response.cs.TransInfo;
import com.mtx.wechat.entity.param.tm.BaseTmData;
import com.mtx.wechat.entity.param.tm.TemplateMessage;
import com.mtx.wechat.entity.param.tm.TmDataItem;
import com.mtx.wechat.mapper.WechatTmMapper;
import com.mtx.wechat.utils.KfUtil;
import com.mtx.wechat.utils.MessageUtil;
import com.mtx.wechat.utils.WechatBindingUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wensheng on 12/11/2014.
 */
@Service
public class AutoReplyService {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private RespSettingService respSettingService;
    @Autowired
    private RespArticleService respArticleService;
    @Autowired
    private WechatTmMapper wechatTmMapper;
    @Autowired
    private TemplateMessageService templateMessageService;

    public List<RespSetting> getRespSettingList(String bindid, String reqType){
        RespSetting respSetting = new RespSetting();
        respSetting.setBindid(bindid);
        respSetting.setReqtype(reqType);
        return  respSettingService.queryForList(respSetting);
    }

    /**
     *
     * @param reqMessage
     * @param content
     * @return
     */
    public String getRespTextMessage(BaseRequestMessage reqMessage, String content){
        ResponseTextMessage respTextMsg = new ResponseTextMessage();
        respTextMsg.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
        respTextMsg.setContent(content);
        respTextMsg = MessageUtil.getRespMessage(reqMessage,respTextMsg);
        return MessageUtil.messageToXml(respTextMsg);
    }

    /**
     *
     * @param reqMessage
     * @return
     */
    public String getRespTransferCsMessage(BaseRequestMessage reqMessage,String kfAccount){
        ResponseTransferCsMessage transferCsMessage = new ResponseTransferCsMessage();
        transferCsMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TRANSFER_CS);
        transferCsMessage = MessageUtil.getRespMessage(reqMessage,transferCsMessage);
        //指定客服号
        if(StringUtils.isNotBlank(kfAccount)){
            TransInfo transInfo = new TransInfo();
            transInfo.setKfAccount(kfAccount);
            transferCsMessage.setTransInfo(transInfo);
        }
        sendWaitingTm(reqMessage);
        return MessageUtil.messageToXml(transferCsMessage);
    }

    /**
     * 发送排队等待消息
     * @param reqMessage
     */
    public void sendWaitingTm(BaseRequestMessage reqMessage ){
        try {
            WechatBinding wechatBinding = WechatBindingUtil.getWechatBindingByWechatOrigId(reqMessage.getToUserName());
            WechatTm wechatTm = new WechatTm();
            wechatTm.setBindid(wechatBinding.getUuid());
            wechatTm.setTmtype("WAITING");
            wechatTm = wechatTmMapper.retrieveByUniqueKey(wechatTm);
            String tmid = wechatTm.getTmid();

            TemplateMessage tm = new TemplateMessage();
            tm.setTemplate_id(tmid);

            tm.setTouser(reqMessage.getFromUserName());

            BaseTmData bt = new BaseTmData();
            TmDataItem firstData = new TmDataItem();
            firstData.setValue("抱歉，由于客户咨询较多，请您耐心等待。");


            TmDataItem nameData = new TmDataItem();
            nameData.setValue(wechatBinding.getWechatname());

            String accessToken = WechatBindingUtil.getAccessTokenByBindId(wechatBinding.getUuid());
            String num = KfUtil.getWaitCase(accessToken);
            TmDataItem numData = new TmDataItem();
            numData.setValue(num);

            TmDataItem waitingData = new TmDataItem();
            waitingData.setValue(num + "人");

            TmDataItem remarkData = new TmDataItem();
            remarkData.setValue("感谢您的耐心等待，为您带来不便深表歉意。");

            bt.setFirst(firstData);
            bt.setKeyword1(nameData);
            bt.setKeyword2(numData);
            bt.setKeyword3(waitingData);
            bt.setRemark(remarkData);
            tm.setData(bt);
            templateMessageService.sendTemplateMessage(tm,wechatBinding.getUuid());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     *
     * @param reqMessage
     * @param newsId
     * @return
     */
    public String getRespNewsMessage(BaseRequestMessage reqMessage, String newsId){
        RespArticle respArticle = new RespArticle();
        respArticle.setNewsid(newsId);
        respArticle.setOrderby("createon");
        List<RespArticle> respArticleList = respArticleService.queryForList(respArticle);
        List<Article> articleList = new ArrayList<Article>();
        for(RespArticle tempRespArticle : respArticleList){
            Article article = new Article();
            article.setTitle(tempRespArticle.getTitle());
            article.setDescription(tempRespArticle.getDecription());
            String domainName = RequestUtil.getDomainUrl();
            if(StringUtils.isNotBlank(tempRespArticle.getPicurl())){
                article.setPicUrl(tempRespArticle.getPicurl());
            }
            //图文外链网址 已填写
            if(StringUtils.isNotBlank(tempRespArticle.getUrl())){
                article.setUrl(tempRespArticle.getUrl());
            }else if(StringUtils.isNotBlank(tempRespArticle.getDetailcontent())) {
                //图文外链网址 未填写， 填写了 图文详细页内容
                String detailUrl = domainName + "/property/articleDetail?articleId=" + tempRespArticle.getUuid();
                article.setUrl(detailUrl);
            }
            //article.setUrl(MessageUtil.getUrlWithOpenidAndBindid(tempRespArticle.getUrl(),reqMessage.getFromUserName(),bindId));
            articleList.add(article);
        }
        ResponseNewsMessage responseNewsMessage = new ResponseNewsMessage();
        responseNewsMessage.setArticles(articleList);
        responseNewsMessage.setArticleCount(articleList.size());
        responseNewsMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
        responseNewsMessage = MessageUtil.getRespMessage(reqMessage,responseNewsMessage);
        return MessageUtil.messageToXml(responseNewsMessage);
    }

    /**
     *
     * @param reqMessage
     * @param rs
     * @return
     */
    public String getRespMusicMessage(BaseRequestMessage reqMessage, RespSetting rs){
        ResponseMusicMessage responseMusicMessage = new ResponseMusicMessage();
        Music music = new Music();
        music.setTitle(rs.getTitle());
        music.setDescription(rs.getDecription());
        music.setMusicUrl(rs.getMusicurl());
        music.setHQMusicUrl(rs.getHqmusicurl());
        responseMusicMessage.setMusic(music);
        responseMusicMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_MUSIC);
        responseMusicMessage = MessageUtil.getRespMessage(reqMessage,responseMusicMessage);
        return MessageUtil.messageToXml(responseMusicMessage);
    }

    /**
     *
     * @param reqMessage
     * @param bindid
     * @param reqType
     * @return
     */
    public String getDefaultRespTextMessage(BaseRequestMessage reqMessage, String bindid, String reqType){
        ResponseTextMessage respTextMsg = new ResponseTextMessage();
        respTextMsg.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
        respTextMsg = MessageUtil.getRespMessage(reqMessage,respTextMsg);

        RespSetting respSetting = new RespSetting();
        respSetting.setBindid(bindid);
//      全局默认回复，暂不支持分类默认回复
//      respSetting.setReqtype(reqType);
        respSetting.setKeywords(WechatConstants.RESP_DEFAULT_KEYWORD);
        respSetting = respSettingService.queryForObjectByUniqueKey(respSetting);
        if(respSetting != null && StringUtils.isNotBlank(respSetting.getContent())){
            respTextMsg.setContent(respSetting.getContent());
            return MessageUtil.messageToXml(respTextMsg);
        }else{
            logger.warn("************No Reply********************");
            return WechatConstants.DEFAULT_REPLY_MSG;
        }
    }


    /**
     *
     * @param reqMessage
     * @param rs
     * @return
     */
    public String getRespMessage(BaseRequestMessage reqMessage, RespSetting rs){
        String bindid = WechatBindingUtil.getBindIdByWechatOrigId(reqMessage.getToUserName());
        String openid = reqMessage.getFromUserName();
        if (MessageUtil.RESP_MESSAGE_TYPE_TEXT.equals(rs.getResptype())) {
            //处理回复文本中包含的URL
            String content = MessageUtil.getUrlWithBindidAndOpenid(rs.getContent(),bindid,openid);
            return getRespTextMessage(reqMessage,content);
        } else if (MessageUtil.RESP_MESSAGE_TYPE_NEWS.equals(rs.getResptype())) {
            return getRespNewsMessage(reqMessage, rs.getNewsid());
        } else if (MessageUtil.RESP_MESSAGE_TYPE_MUSIC.equals(rs.getResptype())) {
            return getRespMusicMessage(reqMessage, rs);
        }else if (MessageUtil.RESP_MESSAGE_TYPE_TRANSFER_CS.equals(rs.getResptype())) {
            return getRespTransferCsMessage(reqMessage, null);
        }else if (MessageUtil.RESP_MESSAGE_TYPE_IMAGE.equals(rs.getResptype())) {
            return getRespImageMessage(reqMessage, rs.getMediaid());
        }else {
            return WechatConstants.DEFAULT_REPLY_MSG;
        }
    }

    /**
     *
     * 获取Event响应设置
     * @param bindid
     * @param event
     * @param eventKey
     * @return
     */
    public RespSetting getEventRespSetting(String bindid,String event, String eventKey){
        RespSetting respSetting = new RespSetting();
        respSetting.setBindid(bindid);
        respSetting.setReqtype(event);
        respSetting.setKeywords(eventKey);
        return  respSettingService.queryForObjectByUniqueKey(respSetting);
    }

    /**
     *自动回复图片
     * @param reqMessage
     * @param mediaId
     * @return
     */
    public String getRespImageMessage(BaseRequestMessage reqMessage, String mediaId){
        ResponseImageMessage responseImageMessage = new ResponseImageMessage();
        Image image = new Image();
        image.setMediaId(mediaId);
        responseImageMessage.setImage(image);
        responseImageMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_IMAGE);
        responseImageMessage = MessageUtil.getRespMessage(reqMessage,responseImageMessage);
        return MessageUtil.messageToXml(responseImageMessage);
    }

}
