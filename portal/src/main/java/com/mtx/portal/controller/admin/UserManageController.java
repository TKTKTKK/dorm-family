package com.mtx.portal.controller.admin;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.mtx.common.entity.PlatformPermit;
import com.mtx.common.entity.PlatformRole;
import com.mtx.common.entity.PlatformUser;
import com.mtx.common.entity.PlatformUserRole;
import com.mtx.common.service.PlatformPermitService;
import com.mtx.common.service.PlatformRoleService;
import com.mtx.common.service.PlatformUserRoleService;
import com.mtx.common.service.PlatformUserService;
import com.mtx.common.utils.StringUtils;
import com.mtx.common.utils.UserUtils;
import com.mtx.family.entity.Merchant;
import com.mtx.family.service.MerchantService;
import com.mtx.portal.PortalContants;
import com.mtx.wechat.entity.WechatUser;
import com.mtx.wechat.entity.WechatUserInfo;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.service.WechatBindingService;
import com.mtx.wechat.service.WechatUserInfoService;
import com.mtx.wechat.utils.WechatBindingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
            List<Merchant> merchantList = merchantService.selectMerchantForUser();
            if(merchantList == null || merchantList.size()== 0) {
                allMerchants = true;
                model.addAttribute("allMerchants", allMerchants);
            }
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
            //保存成功
            if("1".equals(deleteFlag)){
                model.addAttribute("successMessage", "删除成功");
            }

            String currentUserId = UserUtils.getUserId();
            model.addAttribute("currentUserId", currentUserId);
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
}
