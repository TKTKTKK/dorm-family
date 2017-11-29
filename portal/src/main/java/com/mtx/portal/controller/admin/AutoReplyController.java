package com.mtx.portal.controller.admin;

import com.mtx.wechat.entity.admin.*;
import com.mtx.wechat.service.*;
import com.mtx.common.exception.ServiceException;
import com.mtx.common.utils.StringUtils;
import com.mtx.common.utils.UploadUtils;
import com.mtx.portal.PortalContants;
import com.mtx.wechat.WechatConstants;
import com.mtx.wechat.utils.MessageUtil;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by q on 2014/12/16 0016.
 */
@Controller
@RequestMapping(value = "/admin/autoRep")
public class AutoReplyController {
    @Autowired
    private WechatBindingService wechatBindingService;
    @Autowired
    private RespSettingService respSettingService;
    @Autowired
    private RespArticleService respArticleService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private RespNewsService respNewsService;



    /**
     * 关注时自动回复页面
     * @return
     */
    @RequestMapping(value = "/subscribeRepTxt", method = RequestMethod.GET)
    public String toSubscribeAutoRep(Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        RespSetting respSetting = new RespSetting();
        if(null !=wechatBinding){
            respSetting.setBindid(wechatBinding.getUuid());
            respSetting.setReqtype(MessageUtil.EVENT_TYPE_SUBSCRIBE);
            //respSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
            respSetting = respSettingService.queryForObjectByUniqueKey(respSetting);
        }
        model.addAttribute("respSetting",respSetting);
        return "admin/subscribeRepTxt";
    }

    /**
     * 关注时自动回复文本
     * @param respSetting
     * @param model
     * @return
     */
    @RequestMapping(value = "/subscribeRepTxt", method = RequestMethod.POST)
    public String subscribeAutoRepTxt(RespSetting respSetting, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        respSetting.setBindid(wechatBinding.getUuid());
        //关注时
        respSetting.setReqtype(MessageUtil.EVENT_TYPE_SUBSCRIBE);
        //回复文本
        //respSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
        String returnPath = "admin/subscribeRepTxt";
        if(MessageUtil.RESP_MESSAGE_TYPE_IMAGE.equals(respSetting.getResptype())){
            returnPath = "admin/subscribeRepImg";
        }

        RespSetting chkRespSetting = new RespSetting();
        chkRespSetting.setBindid(wechatBinding.getUuid());
        chkRespSetting.setReqtype(MessageUtil.EVENT_TYPE_SUBSCRIBE);
        chkRespSetting = respSettingService.queryForObjectByUniqueKey(chkRespSetting);
        if(null != chkRespSetting){
            //chkRespSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
            chkRespSetting.setNewsid("");
            if(MessageUtil.RESP_MESSAGE_TYPE_TEXT.equals(respSetting.getResptype())){
                chkRespSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
                chkRespSetting.setContent(respSetting.getContent());
                chkRespSetting.setMediaid("");
            }else if(MessageUtil.RESP_MESSAGE_TYPE_IMAGE.equals(respSetting.getResptype())){
                chkRespSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_IMAGE);
                chkRespSetting.setContent("");
                chkRespSetting.setMediaid(respSetting.getMediaid());
            }
            chkRespSetting.setVersionno(respSetting.getVersionno());
            try {
                respSettingService.updatePartial(chkRespSetting);
                model.addAttribute("successMessage", "保存成功！");
            } catch (ServiceException e) {
                model.addAttribute("errorMessage", "系统忙，稍候再试！");
            }
        }else{
            respSettingService.insert(respSetting);
            model.addAttribute("successMessage", "保存成功！");
        }
        model.addAttribute("wechatBinding", wechatBinding);

        chkRespSetting = new RespSetting();
        chkRespSetting.setBindid(wechatBinding.getUuid());
        chkRespSetting.setReqtype(MessageUtil.EVENT_TYPE_SUBSCRIBE);
        respSetting = respSettingService.queryRespSettingInfo(chkRespSetting);
        model.addAttribute("respSetting", respSetting);

        Image image = new Image();
        image.setBindid(wechatBinding.getUuid());
        //查询有mediaid的图片集合
        List<Image> imageList = imageService.queryImageListHaveMediaId(image);
        model.addAttribute("respImageList", imageList);

        return returnPath;
    }

    /**
     * 关注时切换至图文模式
     * @return
     */
    @RequestMapping(value = "/subscribeRepArticle", method = RequestMethod.GET)
    public String toSubscribeAutoRepArticle(@RequestParam(required = false,defaultValue = "1") int page,Model model){
        List<RespNews> respNewsList = findNewsList(page);
        model.addAttribute("respNewsList",respNewsList);
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        RespSetting respSettingForChk = new RespSetting();
        respSettingForChk.setBindid(wechatBinding.getUuid());
        respSettingForChk.setReqtype(MessageUtil.EVENT_TYPE_SUBSCRIBE);
        //respSettingForChk.setResptype(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
        respSettingForChk = respSettingService.queryForObjectByUniqueKey(respSettingForChk);
        if(null != respSettingForChk){
            model.addAttribute("currentNewsId", respSettingForChk.getNewsid());
            model.addAttribute("versionno", respSettingForChk.getVersionno());
        }
        return "admin/subscribeRepArticle";
    }

    /**
     * 关注时自动回复图文
     * @param newsUuid
     * @param model
     * @return
     */
    @RequestMapping(value = "/subscribeRepArticle", method = RequestMethod.POST)
    public String subscribeAutoRepArticle(@RequestParam(required = false,defaultValue = "1") int page,@RequestParam(value = "newsUuid", required = false)String newsUuid,@RequestParam(value = "versionno", required = false)Integer versionno, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        RespSetting respSetting = new RespSetting();
        respSetting.setBindid(wechatBinding.getUuid());
        respSetting.setReqtype(MessageUtil.EVENT_TYPE_SUBSCRIBE);
        respSetting.setNewsid(newsUuid);
        respSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
        RespSetting respSettingForChk = new RespSetting();
        respSettingForChk.setBindid(wechatBinding.getUuid());
        respSettingForChk.setReqtype(MessageUtil.EVENT_TYPE_SUBSCRIBE);
        respSettingForChk = respSettingService.queryForObjectByUniqueKey(respSettingForChk);
        if(null != respSettingForChk){
            respSettingForChk.setNewsid(newsUuid);
            respSettingForChk.setResptype(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
            respSettingForChk.setContent("");
            respSettingForChk.setMediaid("");
            respSettingForChk.setVersionno(versionno);
            try {
                respSettingService.updatePartial(respSettingForChk);
                model.addAttribute("successMessage", "保存成功！");
            } catch (ServiceException e) {
                model.addAttribute("errorMessage", "系统忙，稍候再试！");
            }
        }else{
            respSettingService.insert(respSetting);
            model.addAttribute("successMessage", "保存成功！");
        }

        List<RespNews> respNewsList = findNewsList(page);
        model.addAttribute("respNewsList",respNewsList);
        respSettingForChk = new RespSetting();
        respSettingForChk.setBindid(wechatBinding.getUuid());
        respSettingForChk.setReqtype(MessageUtil.EVENT_TYPE_SUBSCRIBE);
        respSettingForChk = respSettingService.queryForObjectByUniqueKey(respSettingForChk);
        model.addAttribute("currentNewsId",respSettingForChk.getNewsid());
        model.addAttribute("versionno", respSettingForChk.getVersionno());
        return "admin/subscribeRepArticle";
    }


    /**
     * 图文集界面
     * @return
     */
    @RequestMapping(value = "/showArticleSet")
    public String toArticleSet(@RequestParam(required = false,defaultValue = "1") int page,Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != wechatBinding){
            List<RespNews> respNewsList = findNewsList(page);
            model.addAttribute("respNewsList",respNewsList);
        }
        return "admin/articleSet";
    }

    /**
     * 添加图文界面（用于生成图文集）
     * @return
     */
    @RequestMapping(value = "/addArticle", method = RequestMethod.GET)
    public String toAddArticle(@RequestParam(required = false,defaultValue = "1") int page,Model model, HttpServletRequest request){
        String newsid = request.getParameter("newsid");
        PageList<RespArticle>  respArticleList = new PageList<RespArticle>();
        //查看图文集详情
        if(!StringUtils.isBlank(newsid)){
            RespArticle respArticle = new RespArticle();
            respArticle.setNewsid(newsid);
            //设置分页参数
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            respArticleList = respArticleService.queryForListWithPagination(respArticle,pageBounds);
        }
        model.addAttribute("respArticleList", respArticleList);
        model.addAttribute("respArticleCount", respArticleList.size());

        String articleId = request.getParameter("articleId");
        if(!StringUtils.isBlank(articleId)){
            RespArticle article = new RespArticle();
            article.setUuid(articleId);
            article = respArticleService.queryForObjectByPk(article);
            model.addAttribute("article", article);
        }
        model.addAttribute("newsid", newsid);

        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        Image image = new Image();
        image.setBindid(wechatBinding.getUuid());
        image.setOrderby("modifyon desc");
        List<Image> imageList = imageService.queryForList(image);
        model.addAttribute("respImageList", imageList);
        return "admin/createArticle";
    }


    /**
     * 添加图文（用于生成图文集）
     * @param respArticle
     * @param model
     * @return
     */
    @RequestMapping(value = "/addArticle", method = RequestMethod.POST)
    public String addArticle(@RequestParam(required = false,defaultValue = "1") int page,RespArticle respArticle, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        String newsid = "";
        //判断是否是修改article
        if(!StringUtils.isBlank(respArticle.getUuid())){
            RespArticle article = new RespArticle();
            article.setUuid(respArticle.getUuid());
            article = respArticleService.queryForObjectByPk(article);
            article.setTitle(respArticle.getTitle());
            article.setPicurl(respArticle.getPicurl());
            article.setUrl(respArticle.getUrl());
            article.setDecription(respArticle.getDecription());
            article.setDetailcontent(respArticle.getDetailcontent());
            article.setVersionno(respArticle.getVersionno());
            try {
                respArticleService.updatePartial(article);
                model.addAttribute("successMessage", "保存成功！");
            } catch (ServiceException e) {
                model.addAttribute("errorMessage", "系统忙，请稍候！");
            }
            article = respArticleService.queryForObjectByPk(article);
            model.addAttribute("article", article);
            newsid = article.getNewsid();
        }else if(StringUtils.isBlank(respArticle.getNewsid())){
            //判断是否是第一条article
            RespNews respNews = new RespNews();
            respNews.setBindid(wechatBinding.getUuid());
            //保存news和article，并获取newsid
            newsid = respNewsService.saveNews(respNews, respArticle);
            model.addAttribute("successMessage", "保存成功！");
        }else {
            //不是第一条article时
            newsid = respArticle.getNewsid();
            // 保存article
            respArticleService.insert(respArticle);
            model.addAttribute("successMessage", "保存成功！");
        }
        model.addAttribute("newsid", newsid);
        RespArticle respArticleForSch = new RespArticle();
        respArticleForSch.setNewsid(newsid);
        respArticleForSch.setOrderby("createon");
        //获取该newsid对应的article
        //设置分页参数
        PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
        PageList<RespArticle> respArticleList = respArticleService.queryForListWithPagination(respArticle,pageBounds);
        model.addAttribute("respArticleList", respArticleList);
        model.addAttribute("respArticleCount", respArticleList.size());
        Image image = new Image();
        image.setBindid(wechatBinding.getUuid());
        image.setOrderby("modifyon desc");
        List<Image> imageList = imageService.queryForList(image);
        model.addAttribute("respImageList", imageList);

        return "admin/createArticle";
    }

    /**
     * 关键词自动回复界面
     * @param model
     * @return
     */
    @RequestMapping(value = "/keywordAutoRep")
    public String showKeywordAutoRep(@RequestParam(required = false,defaultValue = "1") int page,Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != wechatBinding){
            RespSetting respSetting = new RespSetting();
            respSetting.setBindid(wechatBinding.getUuid());
            //设置分页参数
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<RespSetting> respSettingList = respSettingService.queryForListWithPagination(respSetting, pageBounds);
            model.addAttribute("respSettingList", respSettingList);

            String deleteResult = request.getParameter("deleteResult");
            if(StringUtils.isNotBlank(deleteResult)){
                if("1".equals(deleteResult)){
                    model.addAttribute("successMessage", "删除成功");
                }else{
                    model.addAttribute("errorMessage", "删除失败");
                }
            }
        }

        return "admin/keywordAutoRep";
    }

    /**
     * 关键词自动回复文本界面
     * @param model
     * @return
     */
    @RequestMapping(value = "/keywordRepTxt", method = RequestMethod.GET)
    public String toKeywordAutoRepTxt(Model model, HttpServletRequest request){
        String settingUuid = request.getParameter("settingUuid");
        if(StringUtils.isNoneBlank(settingUuid)){
            RespSetting respSetting = new RespSetting();
            respSetting.setUuid(settingUuid);
            respSetting = respSettingService.queryForObjectByPk(respSetting);
            model.addAttribute("respSetting",respSetting);
        }
        return "admin/keywordAutoRepTxt";
    }

    /**
     *关键词自动回复文本
     * @param respSetting
     * @param model
     * @return
     */
    @RequestMapping(value = "/keywordRepTxt", method = RequestMethod.POST)
    public String keywordAutoRepTxt(RespSetting respSetting,Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        //文本请求
        String reqClick = MessageUtil.REQ_MESSAGE_TYPE_TEXT;
        //自定义菜单回复
        if(StringUtils.isNotBlank(request.getParameter("reqClick"))){
            reqClick = MessageUtil.EVENT_TYPE_CLICK;
        }
        String returnPath = "admin/keywordAutoRepTxt";
        if(MessageUtil.RESP_MESSAGE_TYPE_IMAGE.equals(respSetting.getResptype())){
            returnPath = "admin/keywordAutoRepImg";
            Image image = new Image();
            image.setBindid(wechatBinding.getUuid());
            //查询有mediaid的图片集合
            List<Image> imageList = imageService.queryImageListHaveMediaId(image);
            model.addAttribute("respImageList", imageList);
        }
        if(null != respSetting.getUuid() && StringUtils.isNotBlank(respSetting.getUuid())){
            RespSetting rSetting = new RespSetting();
            rSetting.setBindid(wechatBinding.getUuid());
            rSetting.setReqtype(reqClick);
            rSetting.setKeywords(respSetting.getKeywords());
            rSetting = respSettingService.queryForObjectByUniqueKey(rSetting);
            if(null == rSetting || rSetting.getUuid().equals(respSetting.getUuid())){
                rSetting = respSettingService.queryForObjectByPk(respSetting);
                rSetting.setReqtype(reqClick);
                rSetting.setKeywords(respSetting.getKeywords());
                if(MessageUtil.RESP_MESSAGE_TYPE_TEXT.equals(respSetting.getResptype())){
                    rSetting.setContent(respSetting.getContent());
                    rSetting.setMediaid("");
                }else  if(MessageUtil.RESP_MESSAGE_TYPE_IMAGE.equals(respSetting.getResptype())){
                    rSetting.setMediaid(respSetting.getMediaid());
                    rSetting.setContent("");
                }
                rSetting.setVersionno(respSetting.getVersionno());
                try {
                    respSettingService.updatePartial(rSetting);
                    model.addAttribute("successMessage", "保存成功！");
                } catch (ServiceException e) {
                    model.addAttribute("errorMessage", "系统忙，稍候再试！");
                }finally {
                    rSetting = respSettingService.queryRespSettingInfo(respSetting);
                    model.addAttribute("respSetting", rSetting);
                }

            }else {
                //rSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
                if(MessageUtil.RESP_MESSAGE_TYPE_TEXT.equals(respSetting.getResptype())){
                    rSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
                    rSetting.setNewsid("");
                    rSetting.setMediaid("");
                    rSetting.setContent(respSetting.getContent());
                }else  if(MessageUtil.RESP_MESSAGE_TYPE_IMAGE.equals(respSetting.getResptype())){
                    rSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_IMAGE);
                    rSetting.setNewsid("");
                    rSetting.setMediaid(respSetting.getMediaid());
                    rSetting.setContent("");
                }

                respSettingService.updatePartial(rSetting);
                model.addAttribute("successMessage", "保存成功！");
                rSetting = respSettingService.queryRespSettingInfo(rSetting);
                model.addAttribute("respSetting", rSetting);
            }
        }else{
            respSetting.setBindid(wechatBinding.getUuid());
            respSetting.setReqtype(reqClick);
            //respSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
            RespSetting chkRespSetting = new RespSetting();
            chkRespSetting.setReqtype(reqClick);
            chkRespSetting.setKeywords(respSetting.getKeywords());
            chkRespSetting.setBindid(wechatBinding.getUuid());
            chkRespSetting = respSettingService.queryForObjectByUniqueKey(chkRespSetting);
            if(chkRespSetting != null){
                //chkRespSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
                if(MessageUtil.RESP_MESSAGE_TYPE_TEXT.equals(respSetting.getResptype())){
                    chkRespSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
                    chkRespSetting.setNewsid("");
                    chkRespSetting.setMediaid("");
                    chkRespSetting.setContent(respSetting.getContent());
                }else  if(MessageUtil.RESP_MESSAGE_TYPE_IMAGE.equals(respSetting.getResptype())){
                    chkRespSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_IMAGE);
                    chkRespSetting.setNewsid("");
                    chkRespSetting.setMediaid(respSetting.getMediaid());
                    chkRespSetting.setContent("");
                }
                respSettingService.updatePartial(chkRespSetting);
            }else{
                respSettingService.insert(respSetting);
            }
            model.addAttribute("successMessage", "保存成功！");
            respSetting = new RespSetting();
            model.addAttribute("respSetting", respSetting);
        }


        return returnPath;
    }

    /**
     * 关键词无匹配自动回复文本界面
     * @param model
     * @return
     */
    @RequestMapping(value = "/keywordNoMatchRepTxt", method = RequestMethod.GET)
    public String toKeywordNoMatchRepTxt(Model model, HttpServletRequest request){
        if(StringUtils.isNotBlank(request.getParameter("settingUuid"))){
            RespSetting respSetting = new RespSetting();
            respSetting.setUuid(request.getParameter("settingUuid"));
            respSetting = respSettingService.queryForObjectByPk(respSetting);
            model.addAttribute("respSetting", respSetting);
        }
        return "admin/keywordNoMatchRep";
    }

    /**
     * 关键词无匹配自动回复文本
     * @param respSetting
     * @param model
     * @return
     */
    @RequestMapping(value = "/keywordNoMatchRepTxt", method = RequestMethod.POST)
    public String keywordNoMatchRepTxt(RespSetting respSetting,Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        respSetting.setBindid(wechatBinding.getUuid());
        //文本请求
        String reqClick = MessageUtil.REQ_MESSAGE_TYPE_TEXT;
        //自定义菜单回复
        if(StringUtils.isNotBlank(request.getParameter("reqClick"))){
            reqClick = MessageUtil.EVENT_TYPE_CLICK;
        }
        respSetting.setReqtype(reqClick);
        respSetting.setKeywords(WechatConstants.RESP_DEFAULT_KEYWORD);
        respSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
        RespSetting chkRespSetting = new RespSetting();
        chkRespSetting.setReqtype(reqClick);
        chkRespSetting.setKeywords(WechatConstants.RESP_DEFAULT_KEYWORD);
        chkRespSetting.setBindid(wechatBinding.getUuid());
        chkRespSetting = respSettingService.queryForObjectByUniqueKey(chkRespSetting);
        if(null != respSetting.getUuid() && StringUtils.isNotBlank(respSetting.getUuid())){
            if(null == chkRespSetting || chkRespSetting.getUuid().equals(respSetting.getUuid())){
                chkRespSetting = respSettingService.queryForObjectByPk(respSetting);
                chkRespSetting.setReqtype(reqClick);
                chkRespSetting.setContent(respSetting.getContent());
                chkRespSetting.setVersionno(respSetting.getVersionno());
                try {
                    respSettingService.updatePartial(chkRespSetting);
                    model.addAttribute("successMessage", "保存成功！");
                } catch (Exception e) {
                    model.addAttribute("errorMessage", "系统忙，稍候再试！");
                }
                respSetting = respSettingService.queryForObjectByPk(respSetting);
            }else{
                chkRespSetting.setReqtype(reqClick);
                chkRespSetting.setContent(respSetting.getContent());
                respSettingService.updatePartial(chkRespSetting);
                model.addAttribute("successMessage", "保存成功！");
                respSetting = chkRespSetting;
            }
        }else{
            if(chkRespSetting != null){
                chkRespSetting.setContent(respSetting.getContent());
                respSettingService.updatePartial(chkRespSetting);
            }else {
                respSettingService.insert(respSetting);
            }
            model.addAttribute("successMessage", "保存成功！");
        }


        model.addAttribute("respSetting", respSetting);
        return "admin/keywordNoMatchRep";
    }

    /**
     * 关键词自动回复图文界面
     * @param model
     * @return
     */
    @RequestMapping(value = "/keywordRepArticle", method = RequestMethod.GET)
    public String toKeywordRepArticle(@RequestParam(required = false,defaultValue = "1") int page,Model model, HttpServletRequest request){
        List<RespNews> respNewsList = findNewsList(page);
        model.addAttribute("respNewsList",respNewsList);
        String settingUuid = request.getParameter("settingUuid");
        if(StringUtils.isNotBlank(settingUuid)){
            RespSetting respSetting = new RespSetting();
            respSetting.setUuid(settingUuid);
            respSetting = respSettingService.queryForObjectByPk(respSetting);
            model.addAttribute("respSetting", respSetting);
            model.addAttribute("currentNewsId", respSetting.getNewsid());
        }
        String keyword = request.getParameter("keyword");
        model.addAttribute("keyword", keyword);
        String changePage = request.getParameter("changePage");
        model.addAttribute("changePage", changePage);
        return "admin/keywordAutoRepArticle";
    }

    /**
     * 关键词自动回复图文
     * @param model
     * @return
     */
    @RequestMapping(value = "/keywordRepArticle", method = RequestMethod.POST)
    public String KeywordRepArticle(@RequestParam(required = false,defaultValue = "1") int page,RespSetting respSetting, Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        //文本请求
        String reqClick = MessageUtil.REQ_MESSAGE_TYPE_TEXT;
        //自定义菜单回复
        if(StringUtils.isNotBlank(request.getParameter("reqClick"))){
            reqClick = MessageUtil.EVENT_TYPE_CLICK;
        }
        if(null != respSetting.getUuid() && StringUtils.isNotBlank(respSetting.getUuid())){
            RespSetting rSetting = new RespSetting();
            rSetting.setBindid(wechatBinding.getUuid());
            rSetting.setReqtype(reqClick);
            rSetting.setKeywords(respSetting.getKeywords());
            rSetting = respSettingService.queryForObjectByUniqueKey(rSetting);
            if(null == rSetting || rSetting.getUuid().equals(respSetting.getUuid())){
                rSetting = respSettingService.queryForObjectByPk(respSetting);
                rSetting.setReqtype(reqClick);
                rSetting.setKeywords(respSetting.getKeywords());
                rSetting.setNewsid(respSetting.getNewsid());
                rSetting.setVersionno(respSetting.getVersionno());
                try {
                    respSettingService.updatePartial(rSetting);
                    model.addAttribute("successMessage", "保存成功！");
                } catch (ServiceException e) {
                    model.addAttribute("errorMessage", "系统忙，稍候再试！");
                }
                respSetting = respSettingService.queryForObjectByPk(respSetting);
                model.addAttribute("respSetting",respSetting);
            }else {
                rSetting.setNewsid(respSetting.getNewsid());
                rSetting.setContent("");
                rSetting.setMediaid("");
                rSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
                respSettingService.updatePartial(rSetting);
                model.addAttribute("successMessage", "保存成功！");
                respSetting = rSetting;
            }
        }else{
            respSetting.setBindid(wechatBinding.getUuid());
            respSetting.setReqtype(reqClick);
            respSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
            RespSetting respSettingForChk = new RespSetting();
            respSettingForChk.setBindid(wechatBinding.getUuid());
            respSettingForChk.setReqtype(reqClick);
            respSettingForChk.setKeywords(respSetting.getKeywords());
            respSettingForChk = respSettingService.queryForObjectByUniqueKey(respSettingForChk);
            if(null != respSettingForChk){
                respSettingForChk.setReqtype(reqClick);
                respSettingForChk.setResptype(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
                respSettingForChk.setNewsid(respSetting.getNewsid());
                respSettingForChk.setKeywords(respSetting.getKeywords());
                respSettingForChk.setContent("");
                respSettingForChk.setMediaid("");
                respSettingService.updatePartial(respSettingForChk);
            }else{
                respSettingService.insert(respSetting);
            }
            model.addAttribute("successMessage", "保存成功！");
            respSetting = new RespSetting();
        }

        List<RespNews> respNewsList = findNewsList(page);
        model.addAttribute("respNewsList",respNewsList);
        model.addAttribute("currentNewsId",respSetting.getNewsid());
        model.addAttribute("respSetting",respSetting);
        return "admin/keywordAutoRepArticle";
    }

    /**
     * 图片库界面
     * @param model
     * @return
     */
    @RequestMapping(value = "/showPictureLib")
    public String showPictureLib(Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != wechatBinding){
            Image image = new Image();
            image.setBindid(wechatBinding.getUuid());
            image.setOrderby("modifyon desc");
            List<Image> imageList = imageService.queryForList(image);
            model.addAttribute("respImageList", imageList);
        }

        return "admin/showPictureLib";
    }


    /**
     * 上传图片（图片库）
     * @param multipartFile
     * @param request
     * @return
     */
    @RequestMapping(value = "/uploadPicture", method = RequestMethod.POST)
    public String uploadPicture(@RequestParam(value = "picture", required = false)MultipartFile multipartFile, Image image, HttpServletRequest request, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(!multipartFile.isEmpty()){
            //调用上传文件工具类 管理员模块
            String imgname = UploadUtils.uploadFile(multipartFile, "admin");
            image.setImgname(imgname);
            model.addAttribute("image", image);
            Image img = new Image();
            img.setBindid(wechatBinding.getUuid());
            img.setOrderby("modifyon desc");
            List<Image> imageList = imageService.queryForList(img);
            model.addAttribute("respImageList", imageList);
            return "admin/showPictureLib";
        }else {
            image.setBindid(wechatBinding.getUuid());
            //上传图片
            imageService.uploadImage(image,request.getParameter("uploadToServer"));
            image = new Image();
            model.addAttribute("image", image);

            Image img = new Image();
            img.setBindid(wechatBinding.getUuid());
            img.setOrderby("modifyon desc");
            List<Image> imageList = imageService.queryForList(img);
            model.addAttribute("respImageList", imageList);
            return "redirect:/admin/autoRep/showPictureLib";
        }
    }

    /**
     * 查看图文详情
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/showArticleDetail")
    public String showArticleDetail(HttpServletRequest request, Model model){
        RespArticle respArticle = new RespArticle();
        String articleId = request.getParameter("articleId");
        respArticle.setUuid(articleId);
        respArticle = respArticleService.queryForObjectByPk(respArticle);
        model.addAttribute("respArticle", respArticle);
        return "admin/articleDetail";
    }

    /**
     * 查询当前用户的图文集
     * @return
     */
    private List findNewsList(int page){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        RespNews respNews = new RespNews();
        respNews.setBindid(wechatBinding.getUuid());
        //设置分页参数
        PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
        PageList<RespNews> respNewsList = respNewsService.queryForListWithPagination(respNews, pageBounds);
        for(RespNews news : respNewsList){
            RespArticle respArticle = new RespArticle();
            respArticle.setNewsid(news.getUuid());
            respArticle.setOrderby("createon");
            List<RespArticle> respArticleList = respArticleService.queryForList(respArticle);
            news.setFirstRespArticle(respArticleList.get(0));
        }
        return respNewsList;
    }

    /**
     * 删除关键词自动回复
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteKeywordAutoReply")
    public String deleteKeywordAutoReply(HttpServletRequest request){
        String respSettingId = request.getParameter("respSettingId");
        RespSetting respSetting = new RespSetting();
        respSetting.setUuid(respSettingId);
        int deleteResult = respSettingService.delete(respSetting);
        return "redirect:/admin/autoRep/keywordAutoRep?deleteResult="+deleteResult;
    }

    /**
     * 关键词自动回复图片
     * @param model
     * @return
     */
    @RequestMapping(value = "/keywordAutoRepImg")
    public String keywordAutoRepImg(Model model,HttpServletRequest request){
        String settingUuid = request.getParameter("settingUuid");
        if(StringUtils.isNoneBlank(settingUuid)){
            RespSetting respSetting = new RespSetting();
            respSetting.setUuid(settingUuid);
            respSetting = respSettingService.queryRespSettingInfo(respSetting);
            model.addAttribute("respSetting",respSetting);
        }
        Image image = new Image();
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        image.setBindid(wechatBinding.getUuid());
        //查询有mediaid的图片集合
        List<Image> imageList = imageService.queryImageListHaveMediaId(image);
        model.addAttribute("respImageList", imageList);
        return "admin/keywordAutoRepImg";
    }

    /**
     * 关注时自动回复图片页面
     * @return
     */
    @RequestMapping(value = "/subscribeRepImg", method = RequestMethod.GET)
    public String subscribeRepImg(Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding",wechatBinding);
        RespSetting respSetting = new RespSetting();
        if(null !=wechatBinding){
            respSetting.setBindid(wechatBinding.getUuid());
            respSetting.setReqtype(MessageUtil.EVENT_TYPE_SUBSCRIBE);
            //respSetting.setResptype(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
            respSetting = respSettingService.queryRespSettingInfo(respSetting);
        }
        model.addAttribute("respSetting",respSetting);
        Image image = new Image();
        image.setBindid(wechatBinding.getUuid());
        //查询有mediaid的图片集合
        List<Image> imageList = imageService.queryImageListHaveMediaId(image);
        model.addAttribute("respImageList", imageList);
        return "admin/subscribeRepImg";
    }
}
