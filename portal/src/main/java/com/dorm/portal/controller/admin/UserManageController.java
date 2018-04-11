package com.dorm.portal.controller.admin;

import com.dorm.common.entity.*;
import com.dorm.common.service.*;
import com.dorm.common.utils.*;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.exception.ServiceException;
import com.dorm.family.entity.Merchant;
import com.dorm.family.entity.UserMerchant;
import com.dorm.family.service.MerchantService;
import com.dorm.family.service.UserMerchantService;
import com.dorm.portal.PortalContants;
import com.dorm.wechat.WechatConstants;
import com.dorm.wechat.entity.WechatGroup;
import com.dorm.wechat.entity.WechatUser;
import com.dorm.wechat.entity.WechatUserInfo;
import com.dorm.wechat.entity.admin.WechatBinding;
import com.dorm.wechat.service.WechatBindingService;
import com.dorm.wechat.service.WechatUserInfoService;
import com.dorm.wechat.utils.WechatBindingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/admin/usermanage")
public class UserManageController extends BaseAdminController {
    @Autowired
    private PlatformUserService platformUserService;
    @Autowired
    private PlatformPermitService platformPermitService;
    @Autowired
    private PlatformRoleService platformRoleService;
    @Autowired
    private PlatformUserRoleService platformUserRoleService;
    @Autowired
    private WechatBindingService wechatBindingService;
    @Autowired
    private WechatUserInfoService wechatUserInfoService;
    @Autowired
    private MerchantService merchantService;
    @Autowired
    private UserMerchantService userMerchantService;
    @Autowired
    private PlatformRolePermitService platformRolePermitService;
    @Autowired
    private BindRoleService bindRoleService;

    /**
     * 用户微信管理
     * @return
     */
    @RequestMapping(value = "/wechatUserManage", method = RequestMethod.GET)
    public String userWechatManage(Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        PageBounds pageBounds = new PageBounds(1, PortalContants.PAGE_SIZE);
        WechatUserInfo wechatUserInfo = new WechatUserInfo();
        wechatUserInfo.setBindid(wechatBinding.getUuid());
        //默认查询没有创建账号的
        String ifCreateAccount = "N";
        model.addAttribute("ifCreateAccount",ifCreateAccount);
        List<WechatUserInfo> wechatUserInfoList = wechatUserInfoService.queryWechatUserInfoForPageList(wechatUserInfo, null, ifCreateAccount, pageBounds);
        model.addAttribute("wechatUserInfoList",wechatUserInfoList);

        return "admin/usermanage/wechatUserManage";
    }
    /**
     * 用户微信列表
     * @return
     */
    @RequestMapping(value = "/wechatUserManage", method = RequestMethod.POST)
    public String userWechatManage(@RequestParam(required = false,defaultValue = "1") int page,WechatUserInfo wechatUserInfo,Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        wechatUserInfo.setBindid(wechatBinding.getUuid());
        model.addAttribute("wechatUserInfo",wechatUserInfo);
        String ifsubscribe = request.getParameter("ifsubscribe");
        model.addAttribute("ifsubscribe",ifsubscribe);
        String ifCreateAccount = request.getParameter("ifCreateAccount");
        model.addAttribute("ifCreateAccount",ifCreateAccount);
        PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
        List<WechatUserInfo> wechatUserInfoList = wechatUserInfoService.queryWechatUserInfoForPageList(wechatUserInfo,ifsubscribe,ifCreateAccount,pageBounds);
        model.addAttribute("wechatUserInfoList",wechatUserInfoList);
        String saveFlag = request.getParameter("saveFlag");
        //保存成功
        if("1".equals(saveFlag)){
            model.addAttribute("successMessage", "保存成功");
        }
        String deleteFlag = request.getParameter("deleteFlag");
        //保存成功
        if("1".equals(deleteFlag)){
            model.addAttribute("successMessage", "删除成功");
        }
        return "admin/usermanage/wechatUserManage";
    }
    /**
     * 查询用户微信信息
     * @return
     */
    @RequestMapping(value = "/wechatUserInfo", method = RequestMethod.GET)
    public String wechatUserInfo(Model model,HttpServletRequest request){

        String wechatUserInfoId = request.getParameter("wechatUserInfoId");
        if(StringUtils.isNotBlank(wechatUserInfoId)){
            WechatUserInfo wechatUserInfo = new WechatUserInfo();
            wechatUserInfo.setUuid(wechatUserInfoId);
            wechatUserInfo.setBindid(UserUtils.getUserBindId());
            wechatUserInfo = wechatUserInfoService.queryUserInfoAndStatus(wechatUserInfo);
            model.addAttribute("wechatUserInfo",wechatUserInfo);
        }
        return "admin/usermanage/wechatUserInfo";
    }
    /**
     * 保存用户微信信息
     * @return
     */
    @RequestMapping(value = "/wechatUserInfo", method = RequestMethod.POST)
    public String wechatUserInfo(RedirectAttributes redirectAttributes,WechatUserInfo wechatUserInfo){

        try {
            wechatUserInfoService.updatePartial(wechatUserInfo);
            redirectAttributes.addFlashAttribute("successMessage", "保存成功");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "系统忙，稍候再试");
        }
        return "redirect:wechatUserInfo?wechatUserInfoId=" + wechatUserInfo.getUuid();
    }

    @RequestMapping(value = "/deleteWechatUserInfo",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> deleteWechatUserInfo(HttpServletRequest request){

        Map<String, Object> resultMap = new HashMap<String, Object>();
        String wechatUserInfoIdsStr = request.getParameter("wechatUserInfoIdsStr");
        try {
            int deleteFlag = wechatUserInfoService.deleteWechatUserInfos(wechatUserInfoIdsStr);
            resultMap.put("deleteFlag", deleteFlag);
        }catch (Exception e){
            resultMap.put("errorMessage", "系统忙，稍候再试");
        }
        return resultMap;
    }

    //检查是否有正在使用的账号绑定了微信
    @RequestMapping(value = "/checkwechatUserInfoIfBind")
    @ResponseBody
    public Map<String, Object> checkwechatUserInfoIfBind(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String wechatUserInfoIdsStr = request.getParameter("wechatUserInfoIdsStr");
        String bindedNamesStr = wechatUserInfoService.checkwechatUserInfoIfBind(wechatUserInfoIdsStr);
        resultMap.put("bindedNamesStr", bindedNamesStr);
        return resultMap;
    }

    //查询已有的职位列表
    @RequestMapping(value = "/queryPlatformUserTitleList")
    @ResponseBody
    public Map<String, Object> queryPlatformUserTitleList(HttpServletRequest request){
        String platformUserTitle = request.getParameter("platformUserTitle");
        if(StringUtils.isNotBlank(platformUserTitle)){
            if(platformUserTitle.indexOf("%") > -1){
                platformUserTitle = platformUserTitle.replace("%","\\%");
            }
            if(platformUserTitle.indexOf("_") > -1){
                platformUserTitle = platformUserTitle.replace("_","\\_");
            }
        }
        List<String> platformUserTitleList  = platformUserService.queryPlatformUserTitleDropdownList(UserUtils.getUserBindId(), platformUserTitle);

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("platformUserTitleList", platformUserTitleList);
        return resultMap;
    }


    //更改用户名
    @RequestMapping(value = "/changeUsername")
    public String changeUsername(HttpServletRequest request,RedirectAttributes redirectAttributes){
        String platformUserId = request.getParameter("platformUserId");
        String versionno =request.getParameter("versionno");
        String newUsername = request.getParameter("newUsername");
        PlatformUser tempUser = platformUserService.getPlatformUserByUserName(newUsername);
        if(null == tempUser){
            //更改用户姓名
            try {
                PlatformUser platformUser = new PlatformUser();
                platformUser.setUsername(newUsername);
                platformUser.setUuid(platformUserId);
                platformUser.setVersionno(Integer.valueOf(versionno));
                platformUserService.updatePartial(platformUser);
                redirectAttributes.addAttribute("successMessage", "保存成功");
            } catch (Exception e) {
                redirectAttributes.addAttribute("errorMessage", "系统忙，稍候再试");
            }
        }else {
            redirectAttributes.addAttribute("errorMessage", "用户名"+newUsername+"已存在");
        }
        String queryCommunityid = request.getParameter("queryCommunityid");
        redirectAttributes.addAttribute("communityid",queryCommunityid);
        String queryUsername = request.getParameter("queryUsername");
        redirectAttributes.addAttribute("username",queryUsername);
        String queryName = request.getParameter("queryName");
        redirectAttributes.addAttribute("name",queryName);
        String queryTopAccount = request.getParameter("queryTopAccount");
        redirectAttributes.addAttribute("topAccount",queryTopAccount);
        return "redirect:userInfo?userId=" + platformUserId;
    }


    //重置密码
    @RequestMapping(value = "/resetPassword",method = RequestMethod.POST)
    public String resetPassword(PlatformUser platformUser,RedirectAttributes redirectAttributes,HttpServletRequest request){
        String platformUserId = request.getParameter("platformUserId");
        String versionno = request.getParameter("versionno");
        platformUser.setUuid(platformUserId);
        platformUser.setVersionno(Integer.valueOf(versionno));
        try {
            String successFlag = platformUserService.resetPassword(platformUser);
            if("Y".equals(successFlag)){
                redirectAttributes.addAttribute("successMessage", "重置成功");
            }
        }catch (Exception e){
            redirectAttributes.addAttribute("errorMessage","系统忙，稍候再试");
        }

        String queryCommunityid = request.getParameter("queryCommunityid");
        redirectAttributes.addAttribute("communityid",queryCommunityid);
        String queryUsername = request.getParameter("queryUsername");
        redirectAttributes.addAttribute("username",queryUsername);
        String queryName = request.getParameter("queryName");
        redirectAttributes.addAttribute("name",queryName);
        String queryTopAccount = request.getParameter("queryTopAccount");
        redirectAttributes.addAttribute("topAccount",queryTopAccount);
        return "redirect:userInfo?userId=" + platformUser.getUuid();

    }

    /**
     * 角色分配界面
     * @return
     */
    @RequestMapping(value = "/roleDistribute", method = RequestMethod.GET)
    public String roleDistributePage(@RequestParam(required = false,defaultValue = "1") int page,Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        boolean allMerchants = false;
        if(null != wechatBinding){
            List<Merchant> merchantList = merchantService.selectAssignedMerchantForUser();
            if(merchantList == null || merchantList.size()== 0) {
                allMerchants = true;
                model.addAttribute("allMerchants", allMerchants);
            }
            merchantList = merchantService.selectMerchantForUser();
            model.addAttribute("merchantList", merchantList);

            String username = request.getParameter("username");
            String name = request.getParameter("name");
            String merchantid=request.getParameter("merchantid");
            if(StringUtils.isBlank(merchantid)){
                if(allMerchants){
                    merchantid="";
                }else{
                    merchantid = merchantList.get(0).getUuid();
                }
            }
            //默认查询非顶级账号
            String topAccount = request.getParameter("topAccount");
            if(StringUtils.isBlank(topAccount)){
                topAccount = "N";
            }
            model.addAttribute("username",username);
            model.addAttribute("name",name);
            model.addAttribute("merchantid",merchantid);
            model.addAttribute("topAccount",topAccount);
            model.addAttribute("page",page);
            //查询该bindid下的用户：（当前用户是超级管理员时，可以查看全部角色的用户；当前用户是管理员时，只可以查看非超级管理员角色的用户。）
            //设置分页参数
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            List<PlatformUser> platformUserList = platformUserService.selectNonSuperUsers(topAccount,merchantid,pageBounds,username,name);
            model.addAttribute("platformUserList", platformUserList);

            //所有非超级管理员角色
            List<PlatformRole> platformRoleList = platformRoleService.selectNonSuperRoles();
            model.addAttribute("roleList", platformRoleList);

            String saveFlag = request.getParameter("saveFlag");
            //保存成功
            if("1".equals(saveFlag)){
                model.addAttribute("successMessage", "保存成功");
            }

            String deleteFlag = request.getParameter("deleteFlag");
            //删除成功
            if("1".equals(deleteFlag)){
                model.addAttribute("successMessage", "删除成功");
            }

            String currentUserId = UserUtils.getUserId();
            model.addAttribute("currentUserId", currentUserId);

            String staffqrcode = wechatBinding.getStaffqrcode();

            if (StringUtils.isNotBlank(wechatBinding.getAppid())) {
                if(StringUtils.isBlank(staffqrcode)){
                    String domainUrl = RequestUtil.getDomainUrl();
                    String qrCodeUrl = domainUrl + "/guest/staff/bind";
                    staffqrcode = QRCodeUtil.generateQRCode(qrCodeUrl);
                    wechatBinding.setStaffqrcode(staffqrcode);
                    wechatBindingService.updatePartial(wechatBinding);
                    CacheUtils.remove(WechatConstants.BIND_DETAILS_CACHE,wechatBinding.getUuid());
                }
                model.addAttribute("staffqrcode", staffqrcode);
            }
        }
        return "admin/usermanage/roleDistribute";
    }


    /**
     * 角色分配
     * @param request
     * @return
     */
    @RequestMapping(value = "/roleDistribute", method = RequestMethod.POST)
    public String roleDistribute(HttpServletRequest request){
        String userId = request.getParameter("userId");
        if(StringUtils.isNotBlank(userId)){
            String[] roleIds = request.getParameterValues("role-" + userId);
            PlatformUserRole platformUserRole = new PlatformUserRole();
            platformUserRole.setUserid(userId);
            //根据userid删除用户角色关联
            platformUserRoleService.deleteUserRoleByUserId(userId);
            if(null != roleIds && roleIds.length > 0){
                for(String roleId : roleIds){
                    platformUserRole.setRoleid(roleId);
                    //添加用户角色关系
                    platformUserRoleService.createUserRole(platformUserRole);
                }
            }
        }
        return "redirect:/admin/usermanage/roleDistribute?saveFlag=1";
    }

    /**
     * 删除用户
     * @param request
     * @return
     */
    @RequestMapping("/deleteUser")
    @ResponseBody
    public Map<String, Object> deleteUser(HttpServletRequest request){
        int deleteFlag = 0;

        String userId = request.getParameter("userId");
        String merchantid = request.getParameter("merchantid");
        //删除用户信息
        deleteFlag = userMerchantService.deleteUserInfo(userId, merchantid);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }


    @RequestMapping(value = "/getStaffInfoByName", method = RequestMethod.GET)
    @ResponseBody
    public List  getStaffInfoByName( @RequestParam("name") String name){
        WechatUserInfo wechatUserInfo = new WechatUserInfo();
        wechatUserInfo.setBindid(UserUtils.getUserBindId());
        wechatUserInfo.setType("STAFF");
        wechatUserInfo.setName(name);
        wechatUserInfo.setOrderby("createon");
        List<WechatUserInfo> wechatUserInfoList = wechatUserInfoService.selectWechatUserInfoForStaff(wechatUserInfo);
        return wechatUserInfoList;
    }

    /**
     * 检查是否已关注
     * @param request
     * @return
     */
    @RequestMapping(value = "/checkIfSubscribe")
    @ResponseBody
    public Map<String, Object> checkIfSubscribe(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String openid = request.getParameter("openid");
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        WechatUser wechatUser = WechatBindingUtil.getWechatUser(wechatBinding.getUuid(), openid);
        if(null != wechatUser){
            int subscribeFlag = wechatUser.getSubscribe();
            if(subscribeFlag == 1){
                resultMap.put("nickname", wechatUser.getNickname());
                resultMap.put("headimgurl", wechatUser.getHeadimgurl());
            }
            resultMap.put("subscribeFlag", subscribeFlag);
        }
        return resultMap;
    }

    /**
     * 根据角色查询权限
     * @param request
     * @return
     */
    @RequestMapping(value = "/queryPermitListByRoleId")
    @ResponseBody
    public Map<String, Object> queryPermitListByRoleId(HttpServletRequest request){
        String roleId = request.getParameter("roleId");
        Map<String, Object> resultMap = new HashMap<String, Object>();
        List<PlatformPermit> permitList = UserUtils.queryPermitListByRoleId(roleId, "MENU");
        resultMap.put("permitList", permitList);
        return resultMap;
    }

    /**
     * 根据菜单名称查询菜单id
     * @param request
     * @return
     */
    @RequestMapping(value = "/queryPermitIdByMenuName")
    @ResponseBody
    public Map<String, Object> queryPermitIdByMenuName(HttpServletRequest request){
        String menuName = request.getParameter("menuName");
        PlatformPermit platformPermit = new PlatformPermit();
        platformPermit.setPermitname(menuName);
        platformPermit = platformPermitService.queryPermitIdByMenuName(menuName);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        if(null != platformPermit){
            resultMap.put("parentPermitId", platformPermit.getUuid());
        }
        return resultMap;
    }

    /**
     * 用户信息
     * @param model
     * @return
     */
    @RequestMapping(value = "/userInfo")
    public String showUserInfo(Model model, HttpServletRequest request, @RequestParam(required = false,defaultValue = "1") int page){

        model.addAttribute("view", request.getParameter("view"));

        String userId = request.getParameter("userId");
        String merchantid = request.getParameter("merchantid");
        model.addAttribute("queryMerchantid", merchantid);
        String username = request.getParameter("username");
        model.addAttribute("queryUsername",username);
        String name = request.getParameter("name");
        model.addAttribute("queryName",name);
        String topAccount = request.getParameter("topAccount");
        model.addAttribute("queryTopAccount",topAccount);
        String querytype = request.getParameter("querytype");
        model.addAttribute("querytype", querytype);

        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        boolean allMerchants = false;
        if(null != wechatBinding) {
            List<Merchant> merchantList = merchantService.selectAssignedMerchantForUser();
            if(merchantList == null || merchantList.size()== 0) {
                allMerchants = true;
                model.addAttribute("allMerchants", allMerchants);
            }
        }
        model.addAttribute("allMerchants",allMerchants);
        //片区信息
        if("district".equals(querytype)){
            if(StringUtils.isNotBlank(userId)){
                PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
                PageList<UserMerchant> userMerchantList = userMerchantService.queryUserMerchantListByUserId(userId, pageBounds);
                model.addAttribute("userMerchantList", userMerchantList);
                PlatformUser platformUser = platformUserService.getPlatformUserById(userId);
                model.addAttribute("platformUser", platformUser);
                List<Merchant> partialMerchantList = merchantService.queryMerchantListNotInUserMerhantTable(UserUtils.getUserBindId(),userId);
                model.addAttribute("partialMerchantList", partialMerchantList);
            }
        }else{
            //用户信息
            //用户信息界面初始信息
            model = initUserInfo(model);
            if(StringUtils.isNotBlank(userId)){
                PlatformUser platformUser = new PlatformUser();
                platformUser.setUuid(userId);
                platformUser = platformUserService.queryForObjectByPk(platformUser);
                //查询用户角色
                List<PlatformRole> platformRoleList = platformRoleService.getUserRoleList(platformUser.getUuid());
                String[] roles = new String[platformRoleList.size()];
                for(int i=0; i<platformRoleList.size(); i++){
                    roles[i] = platformRoleList.get(i).getUuid();
                }
                platformUser.setRoles(roles);
                model.addAttribute("platformUser", platformUser);
            }
            List<WechatGroup> wechatGroupList = WechatBindingUtil.getWechatGroups().getGroups();
            model.addAttribute("wechatGroupList",wechatGroupList);
        }
        model.addAttribute("successMessage",request.getParameter("successMessage"));
        model.addAttribute("errorMessage",request.getParameter("errorMessage"));

        String currentUserId = UserUtils.getUserId();
        model.addAttribute("currentUserId", currentUserId);

        String wechatUserInfoId = request.getParameter("wechatUserInfoId");
        model.addAttribute("wechatUserInfoId",wechatUserInfoId);
        if(StringUtils.isNotBlank(wechatUserInfoId)){
            WechatUserInfo wechatUserInfo = new WechatUserInfo();
            wechatUserInfo.setUuid(wechatUserInfoId);
            wechatUserInfo = wechatUserInfoService.queryForObjectByPk(wechatUserInfo);
            PlatformUser platformUser = new PlatformUser();
            platformUser.setUsername(wechatUserInfo.getContactno());
            platformUser.setName(wechatUserInfo.getName());
            platformUser.setCellphone(wechatUserInfo.getContactno());
            platformUser.setOpenid(wechatUserInfo.getOpenid());
            model.addAttribute("platformUser",platformUser);
        }

        return "admin/usermanage/userInfo";
    }

    /**
     * 用户信息界面初始信息
     * @param model
     * @return
     */
    public Model initUserInfo(Model model){
        //所有非超级管理员角色
        List<PlatformRole> platformRoleList = platformRoleService.queryRolesByBindId();
        model.addAttribute("roleList", platformRoleList);
        return model;
    }



    /**
     * 创建用户
     * @param platformUser
     * @return
     */
    @RequestMapping(value = "/saveUserInfo", method = RequestMethod.POST)
    public String createUser(PlatformUser platformUser, Model model, HttpServletRequest request){
        //用户信息界面初始信息
        model = initUserInfo(model);
        String queryCommunityid = request.getParameter("queryCommunityid");
        model.addAttribute("queryCommunityid", queryCommunityid);
        String queryUsername = request.getParameter("queryUsername");
        model.addAttribute("queryUsername",queryUsername);
        String queryName = request.getParameter("queryName");
        model.addAttribute("queryName",queryName);
        String queryTopAccount = request.getParameter("queryTopAccount");
        model.addAttribute("queryTopAccount",queryTopAccount);

        if(StringUtils.isNotBlank(platformUser.getUuid())){
            try {
                //修改用户信息
                userMerchantService.modifyUserInfo(platformUser);
                model.addAttribute("successMessage", "保存成功");
            } catch (Exception e) {
                model.addAttribute("errorMessage", "系统忙，稍候再试");
            }

            platformUser = platformUserService.queryForObjectByPk(platformUser);
            //查询用户角色
            List<PlatformRole> platformRoleList = platformRoleService.getUserRoleList(platformUser.getUuid());
            String[] roles = new String[platformRoleList.size()];
            for(int i=0; i<platformRoleList.size(); i++){
                roles[i] = platformRoleList.get(i).getUuid();
            }
            platformUser.setRoles(roles);
            model.addAttribute("platformUser", platformUser);
        }else {
            PlatformUser tempUser = platformUserService.getPlatformUserByUserName(platformUser.getUsername());
            if(null == tempUser){
                //添加用户信息
                String password = request.getParameter("inputPassword");
                platformUser.setPassword(password);
                userMerchantService.addUserInfo(platformUser);
                //发送手机短信验证码
//                SMSUtil.sendPlatformUserCreatedNotification(platformUser.getCellphone(), password.toString());
                model.addAttribute("platformUser", platformUser);
                model.addAttribute("successMessage", "保存成功");
                return "redirect:userInfo?userId="+platformUser.getUuid()+"&querytype=district";
            }else {
                model.addAttribute("errorMessage", "用户名已存在");
            }
        }
        String currentUserId = UserUtils.getUserId();
        model.addAttribute("currentUserId", currentUserId);
        List<WechatGroup> wechatGroupList = WechatBindingUtil.getWechatGroups().getGroups();
        model.addAttribute("wechatGroupList",wechatGroupList);
        return "admin/usermanage/userInfo";
    }

    /**
     * 权限管理界面
     * @param page
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/rolePermitManage", method = RequestMethod.GET)
    public String rolePermitManage(@RequestParam(required = false, defaultValue = "1")int page,HttpServletRequest request, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != wechatBinding) {
            String signType = request.getParameter("signType");
            if(StringUtils.isNoneBlank(signType)){
                model.addAttribute("signType",signType);
            }else{
                signType="role";
                model.addAttribute("signType","role");
            }
            //角色
            if("role".equals(signType)){
                List<PlatformRole> roleList = platformRoleService.queryBindRoleList();
                model.addAttribute("roleList", roleList);
            }

            //资源
            if("permit".equals(signType)){
                PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
                PageList<PlatformPermit> permitList = platformPermitService.getPermitList(pageBounds);
                model.addAttribute("permitList", permitList);
            }

            //权限配置
            if("rolepermit".equals(signType)){
                PlatformRolePermit platformRolePermit = new PlatformRolePermit();
                platformRolePermit.setOrderby("createon");
                List<PlatformRolePermit> rolePermitList = platformRolePermitService.getPermitList("");
                model.addAttribute("rolePermitList", rolePermitList);

            }
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

        return  "admin/usermanage/rolePermitManage";
    }

    @RequestMapping(value = "/createBindRole/{roleid}", method = RequestMethod.POST)
    public String createBindRole(@PathVariable("roleid") String roleid, Model model){
        String bindid = UserUtils.getUserBindId();
        BindRole bindRole = new BindRole();
        bindRole.setBindid(bindid);
        bindRole.setRoleid(roleid);
        bindRoleService.insert(bindRole);
        return "redirect:/admin/usermanage/rolePermitManage";
    }

    @RequestMapping(value = "/deleteBindRole/{bindroleid}", method = RequestMethod.POST)
    public String deleteBindRole(@PathVariable("bindroleid") String bindroleid, Model model){
        BindRole bindRole = new BindRole();
        bindRole.setUuid(bindroleid);
        bindRoleService.delete(bindRole);
        return "redirect:/admin/usermanage/rolePermitManage";
    }



    /**
     * 添加/修改角色
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/roleInfo", method = RequestMethod.GET)
    public String roleInfo(HttpServletRequest request, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        return "admin/usermanage/roleInfo";
    }

    /**
     * 添加/修改角色
     * @param platformRole
     * @param model
     * @return
     */
    @RequestMapping(value = "/roleInfo", method = RequestMethod.POST)
    public String addRoleInfo(PlatformRole platformRole, HttpServletRequest request,Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String signType = request.getParameter("signType");
        if(signType!=null && "role".equals(signType)){
            String roleId = request.getParameter("uuid");
            if(StringUtils.isNotBlank(roleId)){
                PlatformRole platformRoleSample = new PlatformRole();
                platformRoleSample.setUuid(roleId);
                platformRoleSample = platformRoleService.queryForObjectByPk(platformRoleSample);
                model.addAttribute("platformRole", platformRoleSample);
            }
            return "admin/usermanage/roleInfo";
        }
        String keyexist = getRolekey(platformRole);
        if("true".equals(keyexist)){
            model.addAttribute("platformRole", platformRole);
            model.addAttribute("rolekeyExist", keyexist);
            return "admin/usermanage/roleInfo";
        }
        String nameexist = getRolename(platformRole);
        if("true".equals(nameexist)){
            model.addAttribute("platformRole", platformRole);
            model.addAttribute("rolenameExist", nameexist);
            return "admin/usermanage/roleInfo";
        }
        //修改
        if(StringUtils.isNotBlank(platformRole.getUuid())){
            try {
                platformRoleService.updatePartial(platformRole);
                return "redirect:/admin/usermanage/rolePermitManage?updateFlag=1";

            } catch (ServiceException e) {
                model.addAttribute("platformRole", platformRole);
                model.addAttribute("errorMessage", "系统忙，稍候再试！");
                return "admin/usermanage/roleInfo";
            }
        }else {
            platformRole.setBindid(wechatBinding.getUuid());
            platformRoleService.createRole(platformRole);
            return "redirect:/admin/usermanage/rolePermitManage?saveFlag=1";
        }
    }

    /**
     * 角色CODE是否已存在
     * @param platformRole
     * @return
     */
    public String getRolekey(PlatformRole platformRole){
        PlatformRole platformRoleSample = new PlatformRole();
        platformRoleSample.setRolekey(platformRole.getRolekey());
        List<PlatformRole> platformRoleList = platformRoleService.queryForList(platformRoleSample);
        if(platformRoleList != null &&platformRoleList.size()>0){
            platformRoleSample=platformRoleList.get(0);
            if(platformRole.getUuid()!=null&&platformRole.getUuid().equals(platformRoleSample.getUuid())){
                return "false";
            }
            return "true";
        }
        return "false";
    }

    /**
     * 角色名称是否已存在
     * @param platformRole
     * @return
     */
    public String getRolename(PlatformRole platformRole){
        PlatformRole platformRoleSample = new PlatformRole();
        platformRoleSample.setRolename(platformRole.getRolename());
        List<PlatformRole> platformRoleList = platformRoleService.queryForList(platformRoleSample);
        if(platformRoleList != null &&platformRoleList.size()>0){
            platformRoleSample=platformRoleList.get(0);
            if(platformRole.getUuid()!=null&&platformRole.getUuid().equals(platformRoleSample.getUuid())){
                return "false";
            }
            return "true";
        }
        return "false";
    }

    /**
     * 添加/修改资源
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/permitInfo", method = RequestMethod.GET)
    public String permitInfo(HttpServletRequest request, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        List<PlatformPermit> parentPermitList = platformPermitService.queryPermitList("");
        model.addAttribute("parentPermitList", parentPermitList);
        return "admin/usermanage/permitInfo";
    }

    /**
     * 添加/修改资源
     * @param platformPermit
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "/permitInfo", method = RequestMethod.POST)
    public String addPermitInfo(PlatformPermit platformPermit, Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String signType = request.getParameter("signType");
        if(signType!=null && "permit".equals(signType)){
            String permitId = request.getParameter("uuid");
            if(StringUtils.isNotBlank(permitId)){
                PlatformPermit platformPermitSample  = platformPermitService.queryPermitIdByMenuId(permitId);
                model.addAttribute("platformPermit", platformPermitSample);
            }
            List<PlatformPermit> parentPermitList = platformPermitService.queryPermitList("");
            model.addAttribute("parentPermitList", parentPermitList);
            return "admin/usermanage/permitInfo";
        }
        String nameExist = getPermitname(platformPermit);
        if("true".equals(nameExist)){
            List<PlatformPermit> parentPermitList = platformPermitService.queryPermitList("");
            model.addAttribute("parentPermitList", parentPermitList);
            model.addAttribute("platformPermit", platformPermit);
            model.addAttribute("nameExist", nameExist);
            return "admin/usermanage/permitInfo";
        }
        String resourceExist = getPermitresource(platformPermit);
        if("true".equals(resourceExist)){
            List<PlatformPermit> parentPermitList = platformPermitService.queryPermitList("");
            model.addAttribute("parentPermitList", parentPermitList);
            model.addAttribute("platformPermit", platformPermit);
            model.addAttribute("resourceExist", resourceExist);
            return "admin/usermanage/permitInfo";
        }
        List<PlatformPermit> permitList = platformPermitService.queryPermitList("");
        model.addAttribute("permitList", permitList);
        String[] permitids = request.getParameterValues("permitid");
        //修改
        if(StringUtils.isNotBlank(platformPermit.getUuid())){
            try {
                PlatformPermit platformPermitSample = new PlatformPermit();
                platformPermitSample.setUuid(platformPermit.getUuid());
                platformPermitSample = platformPermitService.queryForObjectByPk(platformPermitSample);
                if(!StringUtils.isNoneBlank(platformPermit.getParentpermitid())){
                    platformPermit.setParentpermitid(null);
                    if(platformPermit.getMenuicon()!=null){
                        platformPermitSample.setMenuicon(platformPermit.getMenuicon());
                    }else{
                        platformPermitSample.setMenuicon("");
                    }
                }
                if(StringUtils.isNoneBlank(platformPermit.getParentpermitid())){
                    platformPermitSample.setMenuicon("");
                }
                platformPermitSample.setParentpermitid(platformPermit.getParentpermitid());
                platformPermitSample.setPermittype(platformPermit.getPermittype());
                platformPermitSample.setPermitresource(platformPermit.getPermitresource());
                platformPermitSample.setPermitname(platformPermit.getPermitname());
                platformPermitSample.setPermitorder(platformPermit.getPermitorder());
                platformPermitSample.setStatus(platformPermit.getStatus());
                platformPermitService.update(platformPermitSample);
                return "redirect:/admin/usermanage/rolePermitManage?signType=permit&updateFlag=1";

            } catch (ServiceException e) {
                List<PlatformPermit> parentPermitList = platformPermitService.queryPermitList("");
                model.addAttribute("parentPermitList", parentPermitList);
                model.addAttribute("platformPermit", platformPermit);
                model.addAttribute("errorMessage", "系统忙，稍候再试！");
                return "admin/usermanage/roleInfo";
            }
        }else {
            if(!StringUtils.isNoneBlank(platformPermit.getParentpermitid())){
                platformPermit.setParentpermitid(null);
            }
            if(StringUtils.isNoneBlank(platformPermit.getParentpermitid())){
                platformPermit.setMenuicon("");
            }
            platformPermitService.insert(platformPermit);
            return "redirect:/admin/usermanage/rolePermitManage?signType=permit&saveFlag=1";
        }
    }

    /**
     * 资源名称是否已存在
     * @param platformPermit
     * @return
     */
    public String getPermitname(PlatformPermit platformPermit){
        PlatformPermit platformPermitSample = platformPermitService.queryPermitIdByMenuName(platformPermit.getPermitname());
        if(platformPermitSample != null && platformPermitSample.getUuid()!= null){
            if(platformPermit.getUuid()!=null && platformPermitSample.getUuid().equals(platformPermit.getUuid())){
                return "false";
            }
            return "true";
        }
        return "false";
    }

    /**
     * 资源地址是否已存在
     * @param platformPermit
     * @return
     */
    public String getPermitresource(PlatformPermit platformPermit){
        PlatformPermit platformPermitSample = platformPermitService.queryPermitIdByResource(platformPermit.getPermitresource());
        if(platformPermitSample != null &&platformPermitSample.getUuid()!= null){
            if(platformPermit.getUuid()!=null && platformPermitSample.getUuid().equals(platformPermit.getUuid())){
                return "false";
            }
            return "true";
        }
        return "false";
    }

    /**
     * 添加/修改权限
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/rolePermitInfo", method = RequestMethod.GET)
    public String rolePermitInfo(HttpServletRequest request, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);

        PlatformRole platformRole = new PlatformRole();
        List<PlatformRole> platformRoleList = platformRoleService.queryForList(platformRole);
        model.addAttribute("platformRoleList", platformRoleList);

        List<PlatformPermit> permitList = platformPermitService.queryPermitList("");
        int i=0;
        for(PlatformPermit platformPermit:permitList){
            permitList.get(i).setChildPermits(platformPermitService.queryPermitList(platformPermit.getUuid()));
            i++;
        }
        model.addAttribute("permitList", permitList);
        return "admin/usermanage/rolePermitInfo";
    }


    /**
     * 添加/修改权限
     * @param platformRolePermit
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "/rolePermitInfo", method = RequestMethod.POST)
    public String addPermitInfo(PlatformRolePermit platformRolePermit, Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String signType = request.getParameter("signType");
        if(signType!=null && "rolepermit".equals(signType)){
            String rolePermitId = request.getParameter("uuid");
            String rolename = request.getParameter("name");
            if(StringUtils.isNotBlank(rolePermitId)){
                List<PlatformRolePermit> rolePermitList = platformRolePermitService.getPermitList(rolePermitId);
                PlatformRolePermit platformRolePermitSample = rolePermitList.get(0);
                model.addAttribute("platformRolePermit", platformRolePermitSample);
            }
            if(!StringUtils.isNotBlank(rolePermitId)&&StringUtils.isNotBlank(rolename)){
                PlatformRolePermit platformRolePermitSample = new PlatformRolePermit();
                platformRolePermitSample.setRolename(rolename);
                model.addAttribute("platformRolePermit", platformRolePermitSample);
            }

            PlatformRole platformRole = new PlatformRole();
            List<PlatformRole> platformRoleList = platformRoleService.queryForList(platformRole);
            model.addAttribute("platformRoleList", platformRoleList);

            List<PlatformPermit> permitList = platformPermitService.queryPermitList("");
            int i=0;
            for(PlatformPermit platformPermit:permitList){
                permitList.get(i).setChildPermits(platformPermitService.queryPermitList(platformPermit.getUuid()));
                i++;
            }
            model.addAttribute("permitList", permitList);
            return "admin/usermanage/rolePermitInfo";
        }
        String[] permitids = request.getParameterValues("permitid");
        //修改
        if(StringUtils.isNotBlank(platformRolePermit.getRoleid())){
            PlatformRolePermit platformRolePermitSample = new PlatformRolePermit();
            platformRolePermitSample.setRoleid(platformRolePermit.getRoleid());
            platformRolePermitService.deleteByRoleId(platformRolePermit.getRoleid());
        }
        PlatformRole platformRole = new PlatformRole();
        platformRole.setRolename(platformRolePermit.getRolename());
        platformRole = platformRoleService.queryForObjectByUniqueKey(platformRole);
        platformRolePermit.setRoleid(platformRole.getUuid());
        if(permitids!=null){
            for(String permitid:permitids){
                PlatformRolePermit platformRolePermitSample = new PlatformRolePermit();
                PlatformPermit platformPermit = platformPermitService.queryPermitIdByMenuId(permitid);
                platformRolePermitSample.setRoleid(platformRolePermit.getRoleid());
                platformRolePermitSample.setPermitid(platformPermit.getUuid());
                int flag3 = platformRolePermitService.insert(platformRolePermitSample);
            }
        }
        return "redirect:/admin/usermanage/rolePermitManage?updateFlag=1&signType=rolepermit";
    }

    /**
     * 删除角色/资源/权限
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteRole", method = RequestMethod.GET)
    public String deleteRole(Model model,HttpServletRequest request){
        String uuid=request.getParameter("uuid");
        String signType = request.getParameter("signType");
        //角色
        if("role".equals(signType)){
            PlatformRole platformRole = new PlatformRole();
            platformRole.setUuid(uuid);
            int flag = platformRoleService.delete(platformRole);
            return "redirect:/admin/usermanage/rolePermitManage?signType=role&deleteFlag="+flag;
        }
        //资源
        if("permit".equals(signType)){
            PlatformPermit platformPermit=new PlatformPermit();
            platformPermit.setUuid(uuid);
            int flag = platformPermitService.delete(platformPermit);
            return "redirect:/admin/usermanage/rolePermitManage?signType=permit&deleteFlag="+flag;
        }
        //权限配置
        if("rolepermit".equals(signType)){
            int flag = platformRolePermitService.deleteByRoleId(uuid);
            return "redirect:/admin/usermanage/rolePermitManage?signType=rolepermit&deleteFlag="+flag;
        }
        return "redirect:/admin/usermanage/rolePermitManage";
    }

    /**
     * @param request
     * @return
     */
    @RequestMapping(value = "/queryUserMerchantInfo")
    @ResponseBody
    public Map<String, Object> queryUserMerchantInfo(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String userMerchantId = request.getParameter("userMerchantId");
        if(StringUtils.isNotBlank(userMerchantId)){
            UserMerchant userMerchant = userMerchantService.queryUserMerchantInfoById(userMerchantId);
            resultMap.put("userMerchant", userMerchant);
        }
        return resultMap;
    }

    /**
     *
     * @param userMerchant
     * @param redirectAttributes
     * @param request
     * @return
     */
    @RequestMapping(value = "/saveUserMerchant", method = RequestMethod.POST)
    public String saveUserMerchant(UserMerchant userMerchant,
                                    RedirectAttributes redirectAttributes,HttpServletRequest request){
        String queryMerchantid = request.getParameter("queryMerchantid");
        redirectAttributes.addAttribute("merchantid",queryMerchantid);
        String queryUsername = request.getParameter("queryUsername");
        redirectAttributes.addAttribute("username",queryUsername);
        String queryName = request.getParameter("queryName");
        redirectAttributes.addAttribute("name",queryName);
        String queryTopAccount = request.getParameter("queryTopAccount");
        redirectAttributes.addAttribute("topAccount",queryTopAccount);
        //修改
        if(StringUtils.isNotBlank(userMerchant.getUuid())){
            try {
                UserMerchant tempUserMerchant = userMerchantService.queryForObjectByPk(userMerchant);
                if(null != tempUserMerchant){
                    tempUserMerchant.setMerchantid(userMerchant.getMerchantid());
                    userMerchantService.update(tempUserMerchant);
                    redirectAttributes.addAttribute("successMessage", "保存成功");
                }
            } catch (Exception e) {
                redirectAttributes.addAttribute("errorMessage", "系统忙，稍候再试");
            }
        }else{
            //添加
            userMerchantService.insert(userMerchant);
            redirectAttributes.addAttribute("successMessage", "保存成功");
        }
        return "redirect:userInfo?userId=" + userMerchant.getUserid() + "&querytype=district";
    }

    /**
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "/deleteUserMerchant")
    public String deleteUserMerchant(HttpServletRequest request,
                                   RedirectAttributes redirectAttributes) {
        String userMerchantId = request.getParameter("userMerchantId");
        String userId = request.getParameter("userId");
        String queryMerchantid = request.getParameter("queryMerchantid");
        redirectAttributes.addAttribute("merchantid", queryMerchantid);
        String queryUsername = request.getParameter("queryUsername");
        redirectAttributes.addAttribute("username", queryUsername);
        String queryName = request.getParameter("queryName");
        redirectAttributes.addAttribute("name", queryName);
        String queryTopAccount = request.getParameter("queryTopAccount");
        redirectAttributes.addAttribute("topAccount", queryTopAccount);

        if (StringUtils.isNotBlank(userMerchantId)) {
            UserMerchant userMerchant = new UserMerchant();
            userMerchant.setUuid(userMerchantId);
            userMerchantService.delete(userMerchant);
            redirectAttributes.addAttribute("successMessage", "删除成功");
        }

        return "redirect:userInfo?userId=" + userId + "&querytype=district";
    }

    @RequestMapping(value = "/checkIfUserMerchant")
    @ResponseBody
    public Map<String, Object> checkIfUserCommunity(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String userId = request.getParameter("userId");
        PageBounds pageBounds = new PageBounds();
        List<UserMerchant> userMerchantList = userMerchantService.queryUserMerchantListByUserId(userId,pageBounds);
        if(userMerchantList.size()==0){
            resultMap.put("checkIfUserMerchantFlag", "N");
        }
        return resultMap;
    }
}
