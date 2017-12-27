package com.mtx.portal.controller.admin;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.CommonConstants;
import com.mtx.common.entity.PlatformUser;
import com.mtx.common.exception.ServiceException;
import com.mtx.common.service.PlatformUserService;
import com.mtx.common.utils.*;
import com.mtx.family.entity.Merchant;
import com.mtx.portal.PortalContants;
import com.mtx.wechat.WechatConstants;
import com.mtx.wechat.entity.WechatError;
import com.mtx.wechat.entity.WechatGroup;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.admin.WechatTm;
import com.mtx.wechat.entity.result.material.MaterialNewsResult;
import com.mtx.wechat.entity.wpMenu.WpMenu;
import com.mtx.wechat.service.*;
import com.mtx.wechat.utils.AdvancedUtil;
import com.mtx.wechat.utils.WechatBindingUtil;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;


@Controller
@RequestMapping(value = "/admin/account")
public class PublicAccountController {
    @Autowired
    private WechatBindingService wechatBindingService;
    @Autowired
    private WpUserService wpUserService;
    @Autowired
    private WpMenuService wpMenuService;
    @Autowired
    private WechatTmService wechatTmService;
    @Autowired
    private RespArticleHistoryService respArticleHistoryService;
    @Autowired
    private PlatformUserService platformUserService;

    /**
     * 查询公众号
     * @return
     */
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String searchPublicAccount(Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        if(null == wechatBinding){
            wechatBinding = new WechatBinding();
            wechatBinding.setAuthorized("N");
            wechatBinding.setToken(StringUtils.getShortToken());
            wechatBindingService.bindingPublicAccount(wechatBinding);
        }
        model.addAttribute("wechatBinding",wechatBinding);
        //域名
        String domainUrl = RequestUtil.getDomainUrl();
        model.addAttribute("domainUrl", domainUrl);
        return "admin/searchPublicAccount";
    }


    /**
     * 公众号详情界面
     * @return
     */
    @RequestMapping(value = "/addPublicAccount", method = RequestMethod.GET)
    public String toAddPublicAccount(HttpServletRequest request, Model model){
        String pubAccid = request.getParameter("pubAccid");
        if(StringUtils.isNotBlank(pubAccid)){
            WechatBinding wechatBinding = new WechatBinding();
            wechatBinding.setUuid(pubAccid);
            wechatBinding = wechatBindingService.queryForObjectByPk(wechatBinding);
            model.addAttribute("wechatBinding", wechatBinding);
        }

        return "admin/publicAccountDetail";
    }

    /**
     * 添加公众号
     * @return
     */
    @RequestMapping(value = "/addPublicAccount", method = RequestMethod.POST)
    public String addPublicAccount(WechatBinding wechatBinding, Model model){
        String redirectUrl = "redirect:/admin/account/search";
        //修改
        if(StringUtils.isNotBlank(wechatBinding.getUuid())){
            try {
                wechatBindingService.updatePartial(wechatBinding);
                model.addAttribute("successMessage", "保存成功");
            } catch (ServiceException e) {
                model.addAttribute("errorMessage", "系统忙，稍候再试");
            } finally {
                wechatBinding = wechatBindingService.queryForObjectByPk(wechatBinding);
                model.addAttribute("wechatBinding", wechatBinding);
                CacheUtils.put(WechatConstants.BIND_DETAILS_CACHE,wechatBinding.getUuid(),wechatBinding);
                redirectUrl = "admin/publicAccountDetail";
            }
        }else{
            //添加
            wechatBinding.setToken(StringUtils.getShortToken());
            wechatBindingService.bindingPublicAccount(wechatBinding);
        }

        return redirectUrl;
    }

    /**
     * 授权设置界面
     * @return
     */
    @RequestMapping(value = "/authorizationSetting", method = RequestMethod.GET)
    public String toAuthorizationSetting(Model model){
        WechatBinding wechatBinding = null;
        if(StringUtils.isNotBlank(UserUtils.getUserBindId())){
            wechatBinding = new WechatBinding();
            wechatBinding.setUuid(UserUtils.getUserBindId());
            wechatBinding = wechatBindingService.queryForObjectByPk(wechatBinding);
        }
        model.addAttribute("wechatBinding", wechatBinding);
        return "admin/authorizationSetting";
    }

    /**
     * 授权设置界面
     * @return
     */
    @RequestMapping(value = "/authorizationSetting", method = RequestMethod.POST)
    public String authorizationSetting(WechatBinding wBinding, Model model){
        WechatBinding binding = new WechatBinding();
        binding.setUuid(wBinding.getUuid());
        binding.setAppid(wBinding.getAppid());
        binding.setAppsecret(wBinding.getAppsecret());
        binding.setVersionno(wBinding.getVersionno());
        binding.setWechatpayid(wBinding.getWechatpayid());
        binding.setWechatpaykey(wBinding.getWechatpaykey());
        binding.setPhpayapiid(wBinding.getPhpayapiid());
        binding.setPhpayapikey(wBinding.getPhpayapikey());
        try {
            wechatBindingService.updatePartial(binding);
            model.addAttribute("successMessage","保存成功！");
        } catch (ServiceException e) {
            model.addAttribute("errorMessage", "系统忙，稍候再试！");
        }
        WechatBinding wechatBinding = wechatBindingService.queryForObjectByPk(binding);
        model.addAttribute("wechatBinding", wechatBinding);
        CacheUtils.put(WechatConstants.BIND_DETAILS_CACHE,wechatBinding.getUuid(),wechatBinding);
        return "admin/authorizationSetting";
    }


    /**
     * 模板管理界面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/templateMessageSetting", method = RequestMethod.GET)
    public String configManageInfo(HttpServletRequest request, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != wechatBinding) {
            String bindid = wechatBinding.getUuid();
            model.addAttribute("bindid",bindid);
        }
        String deleteFlag = request.getParameter("deleteFlag");
        //删除成功
        if("1".equals(deleteFlag)){
            model.addAttribute("successMessage", "删除成功");
        }

        String saveFlag = request.getParameter("saveFlag");
        //添加成功
        if("1".equals(saveFlag)){
            model.addAttribute("successMessage", "添加成功");
        }

        String updateFlag = request.getParameter("updateFlag");
        //更新成功
        if("1".equals(updateFlag)){
            model.addAttribute("successMessage", "更新成功");
        }

        String addFlag = request.getParameter("addFlag");
        if("1".equals(addFlag)){
            model.addAttribute("successMessage", "添加成功");
        }else if("1".equals(addFlag)){
            model.addAttribute("errorMessage", "添加失败");
        }

        return   "admin/templateMessageSetting";
    }


    /**
     * 模板详情界面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/templateMessageDetail", method = RequestMethod.GET)
    public String configDetail(HttpServletRequest request, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != wechatBinding) {
            String bindid = wechatBinding.getUuid();
            String tmtype = request.getParameter("tmtype");
            String tmname = request.getParameter("tmname");
            WechatTm wechatTm = new WechatTm();
            if(StringUtils.isNotBlank(tmtype)){
                wechatTm.setBindid(bindid);
                wechatTm.setTmtype(tmtype);
                WechatTm wechatTmResult = wechatTmService.queryForObjectByUniqueKey(wechatTm);
                if(wechatTmResult != null){
                    model.addAttribute("wechatTm",wechatTmResult);
                }else{
                    if(StringUtils.isNotBlank(tmname)){
                        wechatTm.setTmname(tmname);
                    }
                    model.addAttribute("wechatTm",wechatTm);
                }
            }
        }
        return   "admin/templateMessageDetail";
    }

    /**
     * 模板详情界面
     * @param wechatTm
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/templateMessageDetail",method = RequestMethod.POST)
    public String saveConfig(WechatTm wechatTm,HttpServletRequest request, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String bindid = wechatBinding.getUuid();
        WechatTm wechatTmForMod = new WechatTm();
        if(StringUtils.isNotBlank(wechatTm.getUuid())){
            wechatTmForMod.setUuid(wechatTm.getUuid());
            wechatTmForMod = wechatTmService.queryForObjectByPk(wechatTmForMod);
            if(StringUtils.isBlank(wechatTm.getTmid())){
                wechatTmService.delete(wechatTmForMod);
                return "redirect:/admin/account/templateMessageSetting?updateFlag=1";
            }
            wechatTmForMod.setTmid(wechatTm.getTmid());
            int flag = wechatTmService.updatePartial(wechatTmForMod);
            if(flag==1){
                return "redirect:/admin/account/templateMessageSetting?updateFlag=1";
            }else{
                model.addAttribute("errorMessage","更新失败");
            }
        }else{
            wechatTmForMod.setBindid(bindid);
            wechatTmForMod.setTmtype(wechatTm.getTmtype());
            wechatTmForMod.setTmname(wechatTm.getTmname());
            wechatTmForMod.setTmid(wechatTm.getTmid());
            if(StringUtils.isBlank(wechatTm.getTmid())){
                return "redirect:/admin/account/templateMessageSetting?updateFlag=1";
            }
            int flag = wechatTmService.insert(wechatTmForMod);
            if(flag==1){
                return "redirect:/admin/account/templateMessageSetting?" + "updateFlag=1";
            }else{
                model.addAttribute("errorMessage","更新失败");
            }
        }
        model.addAttribute("wechatTm", wechatTm);
        return "admin/templateMessageDetail";
    }

    /**
     * 删除模板
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/deleteTemplateMessage")
    public String deleteUser(HttpServletRequest request,Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        String bindid = wechatBinding.getUuid();
        String tmtype = request.getParameter("tmtype");
        WechatTm wechatTm = new WechatTm();
        wechatTm.setBindid(bindid);
        wechatTm.setTmtype(tmtype);
        int deleteFlag = 0;
        WechatTm wechatTmResult = wechatTmService.queryForObjectByUniqueKey(wechatTm);
        if(null != wechatTmResult){
            WechatError wechatError = WechatBindingUtil.deleteTemplate(wechatTmResult.getTmid());
            //成功
            if(0 == wechatError.getErrcode()){
                deleteFlag = wechatTmService.delete(wechatTmResult);
            }
        }
        return "redirect:/admin/account/templateMessageSetting?deleteFlag=" + deleteFlag;
    }


    /**
     * 图文集界面
     * @return
     */
    @RequestMapping(value = "/articleMessage")
    public String articleMessage(Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != wechatBinding){
            String page = request.getParameter("page");
            int pageno = 0;
            if(StringUtils.isNoneBlank(page)){
                pageno = Integer.parseInt(page);
            }
            MaterialNewsResult materialNewsResult = WechatBindingUtil.BatchGetMaterialNews(pageno*20, 20);
            model.addAttribute("materialNewsResult",materialNewsResult);
            model.addAttribute("pageno",pageno);

            //图文发送结果
            if(StringUtils.isNotBlank(request.getParameter("sendResult"))){
                model.addAttribute("successMessage", request.getParameter("sendResult"));
            }
        }
        return "admin/articleMessage";
    }

    /**
     * 图文集界面
     * @return
     */
    @RequestMapping(value = "/sendArticleMessage",method = RequestMethod.GET)
    public String sendArticleMessageInfo(Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != wechatBinding){
            String mediaid = request.getParameter("mediaid");
            model.addAttribute("mediaid", mediaid);

            //将开始日期提前一周
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            calendar.add(Calendar.DAY_OF_MONTH, -7);
            String startDateStr = DateFormatUtils.format(calendar.getTime(), "yyyy-MM-dd");
            model.addAttribute("startDateStr", startDateStr);
        }
        return "admin/sendArticleMessage";
    }
    /**
     * 图文集界面
     * @return
     */
    @RequestMapping(value = "/sendArticleMessage",method = RequestMethod.POST)
    public String sendArticleMessage(Model model,HttpServletRequest request){
        //todo
        return "admin/sendArticleMessage";
    }

    /**
     * 给非认证业主发送图文
     * @return
     */
    @RequestMapping(value = "/sendArticleMessageForUnautherized",method = RequestMethod.GET)
    public String sendArticleMessageForUnautherized(Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String sendResult = "";
        if(null != wechatBinding){
            String mediaid = request.getParameter("mediaid");
            //查询未认证用户的openid
            List<String> openids = wpUserService.queryUnautherizedWpUser(wechatBinding.getUuid(), mediaid);
            WechatBindingUtil.BatchSendMaterialNews(mediaid,openids);
            //保存发送历史
            respArticleHistoryService.saveRespArticleHistory(mediaid, openids);
            sendResult = "1";
        }
        return "redirect:/admin/account/articleMessage?sendResult="+sendResult;
    }

    /**
     * 给用户或经销商发送图文
     */
    @RequestMapping(value = "/sendArticleMessageForUserOrMerchant",method = RequestMethod.GET)
    public String sendArticleMessageForUserOrMerchant(HttpServletRequest request,Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String sendResult = "";
        if(null != wechatBinding){
            String mediaid = request.getParameter("mediaid");
            //查询openid
            String sendToMerchant = request.getParameter("sendToMerchant");
            String sendToUser = request.getParameter("sendToUser");
            String province = request.getParameter("province");
            String city = request.getParameter("city");
            String district = request.getParameter("district");
            List<String> openids = new ArrayList<>();
            List<String> merchantUserOpenids = new ArrayList<>();
            List<String> userOpenids = new ArrayList<>();
            if(StringUtils.isNotBlank(sendToMerchant) && StringUtils.isBlank(sendToUser)){
                //经销商账号openid
                merchantUserOpenids = platformUserService.queryPlatformUserOpenIdsByAddress(wechatBinding.getUuid(),province,city,district,mediaid);

            }else if(StringUtils.isBlank(sendToMerchant) && StringUtils.isNotBlank(sendToUser)){
                //用户openid
                WpUser wpUser = new WpUser();
                wpUser.setBindid(wechatBinding.getUuid());
                wpUser.setProvince(province);
                wpUser.setCity(city);
                wpUser.setDistrict(district);
                userOpenids = wpUserService.queryUserOpenIds(wpUser,mediaid);

            }else{
                //用户openid
                WpUser wpUser = new WpUser();
                wpUser.setBindid(wechatBinding.getUuid());
                wpUser.setProvince(province);
                wpUser.setCity(city);
                wpUser.setDistrict(district);
                userOpenids = wpUserService.queryUserOpenIds(wpUser,mediaid);

                //经销商账号openid
                merchantUserOpenids = platformUserService.queryPlatformUserOpenIdsByAddress(wechatBinding.getUuid(),province,city,district,mediaid);


            }
            for(String openid : merchantUserOpenids){
                if(!openids.contains(openid) && StringUtils.isNotBlank(openid)){
                    openids.add(openid);
                }
            }
            for(String openid : userOpenids){
                if(!openids.contains(openid) && StringUtils.isNotBlank(openid)){
                    openids.add(openid);
                }
            }

            WechatBindingUtil.BatchSendMaterialNews(mediaid,openids);
            //保存发送历史
            respArticleHistoryService.saveRespArticleHistory(mediaid, openids);
            sendResult = "1";
        }
        return "redirect:/admin/account/articleMessage?sendResult="+sendResult;
    }


    /**
     * 给指定业主发送图文
     * @return
     */
    @RequestMapping(value = "/sendArticleMessageForAssigned",method = RequestMethod.POST)
    public String sendArticleMessageForAssigned(Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String sendResult = "";
        if(null != wechatBinding){
            String mediaid = request.getParameter("mediaid");
            //获取指定用户的openid
            String openid = request.getParameter("openid");
            String[] split = openid.split(";");
            List<String> openids = Arrays.asList(split);

            WechatBindingUtil.BatchSendMaterialNews(mediaid,openids);
            //保存发送历史
            respArticleHistoryService.saveRespArticleHistory(mediaid, openids);
            sendResult = "1";
        }
        return "redirect:/admin/account/articleMessage?sendResult="+sendResult;
    }
    /**
     * 菜单配置界面
     * @return
     */
    @RequestMapping(value = "/menusSetting",method = RequestMethod.GET)
    public String menusSetting(Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != wechatBinding){
           String queryType = request.getParameter("queryType");
            model.addAttribute("queryType",queryType);
        }
        String queryType = request.getParameter("queryType");
        String originUrl = request.getParameter("originUrl");
        String tempUrl = request.getParameter("tempUrl");
        if("wechat".equals(queryType)){
            List<WpMenu> wpMenuNameList = wpMenuService.queryWpMenuNames(wechatBinding.getUuid());
            String menusFlag = request.getParameter("menusFlag");
            if(wpMenuNameList!=null && wpMenuNameList.size()>0){
                List<WpMenu> wpMenuList = new ArrayList<>();
                if(StringUtils.isNotBlank(menusFlag)){
                    model.addAttribute("menusFlag",menusFlag);
                    wpMenuList = wpMenuService.queryWpMenu(wechatBinding.getUuid(),menusFlag);
                }
                if(wpMenuList==null || wpMenuList.size()<1){
                    model.addAttribute("menusFlag","默认菜单");
                    wpMenuList = wpMenuService.queryWpMenu(wechatBinding.getUuid(),wpMenuNameList.get(0).getMenusname());
                }
                model.addAttribute("wpMenuList",wpMenuList);
                model.addAttribute("menusname",wpMenuList.get(0).getMenusname());
                model.addAttribute("menustype",wpMenuList.get(0).getMenustype());
                model.addAttribute("groupid",wpMenuList.get(0).getGroupid());
            }else{
                model.addAttribute("menusname","默认菜单");
                model.addAttribute("menustype","D");
                model.addAttribute("menusFlag","默认菜单");
            }
            model.addAttribute("wpMenuNameList",wpMenuNameList);
            //用户分组
            List<WechatGroup> wechatGroupList = WechatBindingUtil.getWechatGroups().getGroups();
            model.addAttribute("wechatGroupList",wechatGroupList);
        }
        String applayFalg =request.getParameter("applayFalg");
        if("1".equals(applayFalg)){
            model.addAttribute("successMessage","生成成功");
        }
        String deleteWechatFalg =request.getParameter("deleteWechatFalg");
        if("1".equals(deleteWechatFalg)){
            model.addAttribute("successMessage","删除成功");
        }
        model.addAttribute("originUrl",originUrl);
        model.addAttribute("tempUrl", tempUrl);
        model.addAttribute("queryType",queryType);
        return "admin/menusSetting";
    }

    /**
     * 菜单配置界面
     * @return
     */
    @RequestMapping(value = "/menusSetting",method = RequestMethod.POST)
    public String exchangeUrl(Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String queryType = request.getParameter("queryType");
        if("url".equals(queryType)){
            String exchageType=request.getParameter("exchageType");
            String originUrl = request.getParameter("originUrl");
            String redirectUri = originUrl;
            try {
                redirectUri = URLEncoder.encode(redirectUri, CommonConstants.ENCODING_UTF8);
            } catch (UnsupportedEncodingException e) {
                model.addAttribute("errorMessage","转换错误");
                return "admin/menusSetting";
            }
            String appid = wechatBinding.getAppid();

            if(exchageType.equals("OAuthFilter")){
                String requestUrl = WechatConstants.WECHAT_OAUTH2_URL.replace(WechatConstants.PARAM_PLACEHOLDER_APPID, appid)
                        .replace(WechatConstants.PARAM_PLACEHOLDER_REDIRECT_URI, redirectUri)
                        .replace(WechatConstants.PARAM_PLACEHOLDER_STATE, "mtx")
                        .replace(WechatConstants.PARAM_PLACEHOLDER_SCOPE, WechatConstants.OAUTH2_SCOPE_BASE);
                model.addAttribute("tempUrl", requestUrl);
            }
            model.addAttribute("originUrl",originUrl);
        }
        model.addAttribute("queryType",queryType);
        return "admin/menusSetting";
    }


    /**
     * 查询菜单
     * @param request
     * @return
     */
    @RequestMapping(value = "/queryMenu",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> queryMenu(HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String mainNO = request.getParameter("dlno");
        String childNo = request.getParameter("ddno");
        String menusname = request.getParameter("menusname");
        WpMenu wpMenu = new WpMenu();
        wpMenu.setBindid(wechatBinding.getUuid());
        wpMenu.setMenusname(menusname);
        //查找菜单详情
        if(StringUtils.isNoneBlank(mainNO)){
            wpMenu.setOrderno(Integer.parseInt(mainNO));
            wpMenu = wpMenuService.queryWpMenuMaster(wpMenu);
            //查找子菜单
            if(wpMenu!=null && StringUtils.isNoneBlank(mainNO) && !"0".equals(childNo)){
                WpMenu wpMenuChild = new WpMenu();
                wpMenuChild.setBindid(wechatBinding.getUuid());
                wpMenuChild.setOrderno(Integer.parseInt(childNo));
                wpMenuChild.setParentid(wpMenu.getUuid());
                wpMenu = wpMenuService.queryForObjectByUniqueKey(wpMenuChild);
            }
        }

        resultMap.put("wpMenu",wpMenu);
        return resultMap;
    }


    /**
     * 判读菜单组名称是否重复
     * @param request
     * @return
     */
    @RequestMapping(value = "/queryMenusname",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> queryMenusname(HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String menusname = request.getParameter("menusname");
        List<WpMenu> wpMenuList = wpMenuService.queryWpMenu(wechatBinding.getUuid(),menusname);
        if(wpMenuList!=null && wpMenuList.size()>0){
            resultMap.put("isRepeat","Y");
            return resultMap;
        }
        resultMap.put("isRepeat","N");
        return resultMap;
    }


    /**
     * 修改菜单组名称
     * @param request
     * @return
     */
    @RequestMapping(value = "/modifyMenusname",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> modifyMenusname(HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String newname = request.getParameter("newname");
        String oldname = request.getParameter("oldname");
        List<WpMenu> wpMenuList = wpMenuService.queryWpMenu(wechatBinding.getUuid(),newname);
        if(wpMenuList!=null && wpMenuList.size()>0){
            resultMap.put("flag","1");
            return resultMap;
        }
        wpMenuList = wpMenuService.queryWpMenuByName(wechatBinding.getUuid(),oldname);
        if(wpMenuList!=null && wpMenuList.size()>0){
            for(WpMenu wpMenu:wpMenuList){
                wpMenu.setMenusname(newname);
                wpMenuService.update(wpMenu);
            }
            return resultMap;
        }
        resultMap.put("flag","2");
        return resultMap;
    }


    /**
     * 设置菜单
     * @param request
     * @return
     */
    @RequestMapping(value = "/setMenu",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> setMenu(HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String mainNO = request.getParameter("dlno");
        String childNo = request.getParameter("ddno");
        String name = request.getParameter("name");
        String link = request.getParameter("link");
        String type = request.getParameter("type");
        String menusname = request.getParameter("menusname");
        String menustype = request.getParameter("menustype");
        String groupid = request.getParameter("groupid");
        if("默认菜单".equals(menusname)){
            groupid=null;
        }
        WpMenu wpMenu = new WpMenu();
        wpMenu.setBindid(wechatBinding.getUuid());
        wpMenu.setOrderno(Integer.parseInt(mainNO));
        wpMenu.setMenusname(menusname);
        wpMenu = wpMenuService.queryWpMenuMaster(wpMenu);
        //添加或修改子菜单
        if(StringUtils.isNoneBlank(childNo) &&!"0".equals(childNo)){
            if(wpMenu!=null){
                WpMenu wpMenuChild = new WpMenu();
                wpMenuChild.setBindid(wechatBinding.getUuid());
                wpMenuChild.setParentid(wpMenu.getUuid());
                wpMenuChild.setOrderno(Integer.parseInt(childNo));
                wpMenuChild.setMenusname(menusname);
                WpMenu wpMenuChildSample = wpMenuService.queryForObjectByUniqueKey(wpMenuChild);
                //修改子菜单
                if(wpMenuChildSample!=null){
                    wpMenuChildSample.setName(name);
                    wpMenuChildSample.setType(type);
                    wpMenuChildSample.setLink(link);
                    wpMenuService.updatePartial(wpMenuChildSample);
                    resultMap.put("wpMenu",wpMenuChildSample);
                    resultMap.put("successTxt","菜单修改成功");
                    return resultMap;
                }
                //添加子菜单
                //不是按顺序添加，报错
                List<WpMenu> wpMenuChildList = wpMenuService.queryWpMenuChild(wechatBinding.getUuid(),wpMenu.getUuid());
                if(wpMenuChildList!=null){
                    Integer no = Integer.parseInt(childNo);
                    if(no != (wpMenuChildList.size()+1) ){
                        resultMap.put("childNo",wpMenuChildList.size()+1);
                        return resultMap;
                    }
                }

                wpMenuChild.setBindid(wechatBinding.getUuid());
                wpMenuChild.setOrderno(Integer.parseInt(childNo));
                wpMenuChild.setParentid(wpMenu.getUuid());
                wpMenuChild.setName(name);
                wpMenuChild.setType(type);
                wpMenuChild.setLink(link);
                wpMenuChild.setMenusname(menusname);
                wpMenuChild.setMenustype(menustype);
                wpMenuChild.setGroupid(groupid);
                wpMenuService.insert(wpMenuChild);
                resultMap.put("wpMenu",wpMenuChild);
                resultMap.put("successTxt","菜单生成成功");
                //修改主菜单类型
                if(!"COMPLEX".equals(wpMenu.getType())){
                    wpMenu.setType("COMPLEX");
                    wpMenu.setParentid("");
                    wpMenuService.updatePartial(wpMenu);
                }
                return resultMap;
            }
            //主菜单不存在，报错
            resultMap.put("masterNO","Y");
            return resultMap;
        }else{
            //添加或修改主菜单
            //修改主菜单
            if(wpMenu!=null){
                WpMenu wpMenuChild = new WpMenu();
                wpMenuChild.setBindid(wechatBinding.getUuid());
                wpMenuChild.setOrderno(Integer.parseInt(childNo));
                wpMenuChild.setParentid(wpMenu.getUuid());
                List<WpMenu> wpMenuList = wpMenuService.queryWpMenuChild(wechatBinding.getUuid(), wpMenu.getUuid());
                //存在子菜单时，修改主菜单类型
                if(wpMenuList!=null && wpMenuList.size()>0){
                    wpMenu.setName(name);
                    wpMenu.setType("COMPLEX");
                    wpMenu.setParentid("");
                    wpMenuService.updatePartial(wpMenu);
                    resultMap.put("successTxt","菜单修改成功");
                    resultMap.put("wpMenu",wpMenu);
                    return resultMap;
                }

                wpMenu.setName(name);
                wpMenu.setType(type);
                wpMenu.setLink(link);
                wpMenu.setMenustype(menustype);
                wpMenu.setGroupid(groupid);
                wpMenuService.updatePartial(wpMenu);
                resultMap.put("wpMenu", wpMenu);
                resultMap.put("successTxt","菜单修改成功");
                return resultMap;
            }
            //添加主菜单
            wpMenu = new WpMenu();
            Integer aa = Integer.parseInt(mainNO);
            wpMenu.setBindid(wechatBinding.getUuid());
            wpMenu.setOrderno(Integer.parseInt(mainNO));
            wpMenu.setName(name);
            wpMenu.setType(type);
            wpMenu.setLink(link);
            wpMenu.setMenusname(menusname);
            wpMenu.setMenustype(menustype);
            wpMenu.setGroupid(groupid);
            wpMenuService.insert(wpMenu);
            resultMap.put("wpMenu",wpMenu);
            resultMap.put("successTxt","菜单生成成功");
            return resultMap;
        }
    }

    /**
     * 删除菜单
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteMenu",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteMenu(HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String mainNO = request.getParameter("dlno");
        String menusname = request.getParameter("menusname");
        int flag = 1;
        //删除一列菜单
        if(StringUtils.isNoneBlank(mainNO)){
            //删除主菜单
            WpMenu wpMenu = new WpMenu();
            wpMenu.setBindid(wechatBinding.getUuid());
            wpMenu.setOrderno(Integer.parseInt(mainNO));
            wpMenu.setMenusname(menusname);
            wpMenu = wpMenuService.queryWpMenuMaster(wpMenu);
            if(wpMenu !=null){
                //删除主菜单
                flag = wpMenuService.delete(wpMenu);
                if(flag!=1){
                    resultMap.put("flag",flag);
                    return resultMap;
                }
                //删除子菜单
                WpMenu wpMenuChild = new WpMenu();
                wpMenuChild.setParentid(wpMenu.getUuid());
                List<WpMenu> wpMenuChildList = wpMenuService.queryForList(wpMenuChild);
                if(wpMenuChildList!=null && wpMenuChildList.size()>0){
                    for(WpMenu wpMenuChildSample : wpMenuChildList){
                        WpMenu wpMenuChildForDlt = new WpMenu();
                        wpMenuChildForDlt.setUuid(wpMenuChildSample.getUuid());
                        flag = wpMenuService.delete(wpMenuChildForDlt);
                        if(flag!=1){
                            resultMap.put("flag",flag);
                            return resultMap;
                        }
                    }
                }
            }
            resultMap.put("flag",flag);
            return resultMap;
        }

        //删除所有菜单
        WpMenu wpMenu = new WpMenu();
        wpMenu.setBindid(wechatBinding.getUuid());
        wpMenu.setMenusname(menusname);
        List<WpMenu> wpMenuList = wpMenuService.queryForList(wpMenu);
        if(wpMenuList!=null && wpMenuList.size()>0){
            for(WpMenu wpMenuSample:wpMenuList){
                WpMenu wpMenuForDlt = new WpMenu();
                wpMenuForDlt.setUuid(wpMenuSample.getUuid());
                flag = wpMenuService.delete(wpMenuForDlt);
                if(flag!=1){
                    resultMap.put("flag",flag);
                    return resultMap;
                }
            }
        }
        resultMap.put("flag",flag);
        return resultMap;
    }


    /**
     * 应用菜单
     * @param request
     * @return
     */
    @RequestMapping(value = "/applyMenu",method = RequestMethod.POST)
    public String applyMenu(HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        String name = request.getParameter("name");
        WpMenu wpMenu = new WpMenu();
        wpMenu.setBindid(wechatBinding.getUuid());
        wpMenu.setMenusname(name);
        List<WpMenu> wpMenuList = wpMenuService.queryForList(wpMenu);
        if(wpMenuList!=null && wpMenuList.size()>0){
            wpMenuService.createWechatMenu(wechatBinding.getUuid(),name);
        }
        return "redirect:/admin/account/menusSetting?queryType=wechat&applayFalg=1&menusname="+name;
    }



    /**
     * 删除微信端菜单设置
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteWechatMenu",method = RequestMethod.POST)
    public String deleteWechatMenu(HttpServletRequest request){
        wpMenuService.deleteWechatMenu();
        return "redirect:/admin/account/menusSetting?queryType=wechat&wechatFalg=1";
    }


    /**
     * 用户分组界面
     * @return
     */
    @RequestMapping(value = "/groupUser",method = RequestMethod.GET)
    public String groupUser(Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String createFlag =request.getParameter("createFlag");
        if("1".equals(createFlag)){
            model.addAttribute("successMessage","创建成功");
        }
        String updateFlag =request.getParameter("updateFlag");
        if("1".equals(updateFlag)){
            model.addAttribute("successMessage","修改成功");
        }
        String deleteFlag =request.getParameter("deleteFlag");
        if("1".equals(deleteFlag)){
            model.addAttribute("successMessage","删除成功");
        }
        List<WechatGroup> wechatGroupList = WechatBindingUtil.getWechatGroups().getGroups();
        model.addAttribute("wechatGroupList",wechatGroupList);
        return "admin/groupUser";
    }


    /**
     * 创建或修改用户分组
     * @param request
     * @return
     */
    @RequestMapping(value = "/createGroup")
    public String createGroup(HttpServletRequest request){
        String groupId = request.getParameter("groupId");
        String name = request.getParameter("name");
        WechatGroup wechatGroup = new WechatGroup();
        wechatGroup.setName(name);
        //修改
        if(StringUtils.isNotBlank(groupId)){
            wechatGroup.setId(Integer.valueOf(groupId));
            WechatBindingUtil.updateWechatGroup(wechatGroup);
            return "redirect:/admin/account/groupUser?updateFlag=1";
        }
        //添加
        WechatBindingUtil.createWechatGroup(wechatGroup);
        return "redirect:/admin/account/groupUser?createFlag=1";
    }


    /**
     * 删除用户分组
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteGroup")
    public String deleteGroup(HttpServletRequest request){
        String groupId = request.getParameter("groupId");
        WechatGroup wechatGroup = new WechatGroup();
        wechatGroup.setId(Integer.valueOf(groupId));
        WechatBindingUtil.deleteWechatGroup(wechatGroup);
        return "redirect:/admin/account/groupUser?deleteFlag=1";
    }

    /**
     * 查询所有关注用户信息（从wp_user表中查询）
     * @param model
     * @return
     */
    @RequestMapping(value = "/queryAllWpUsersByBindid")
    public String queryAllWpUsersByBindid(@RequestParam(required = false,defaultValue = "1") int page,
                                          Model model, HttpServletRequest request){
        PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != wechatBinding){
            PageList<WpUser> wpUserList = wpUserService.queryAllWpUsersByBindid(wechatBinding.getUuid(), pageBounds);
            model.addAttribute("wpUserList", wpUserList);

            String syncFlag = request.getParameter("syncFlag");
            if("1".equals(syncFlag)){
                model.addAttribute("successMessage", "同步成功");
            }

        }
        return "admin/wpUserManage";
    }

    /**
     * 同步关注的用户信息
     * @return
     */
    @RequestMapping(value = "/synAttentionUserInfo")
    public String synAttentionUserInfo(){
        wpUserService.synAttentionUserInfo();
        return "redirect:/admin/account/queryAllWpUsersByBindid?syncFlag=1";
    }

    /**
     * 添加模板消息
     * @param wechatTm
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/addTemplateMessage",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> addTemplateMessage(WechatTm wechatTm,HttpServletRequest request, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String bindid = wechatBinding.getUuid();
        // 调用接口获取access_token
        String accessToken = WechatBindingUtil.getAccessToken();
        String tmid = AdvancedUtil.addTemplate(accessToken, request.getParameter("tmidshort"));
        int flag = 0;
        if(StringUtils.isNotBlank(tmid)){
            WechatTm wechatTmForMod = new WechatTm();
            wechatTmForMod.setTmid(tmid);
            wechatTmForMod.setBindid(bindid);
            wechatTmForMod.setTmtype(request.getParameter("tmtype"));
            wechatTmForMod.setTmname(request.getParameter("tmname"));
            flag = wechatTmService.insert(wechatTmForMod);
        }

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("addFlag", flag);
        return resultMap;
    }
}
