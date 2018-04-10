package com.dorm.portal.controller.admin;

import com.dorm.common.entity.PlatformRole;
import com.dorm.common.entity.PlatformUser;
import com.dorm.common.security.UsernamePasswordToken;
import com.dorm.common.service.PlatformRoleService;
import com.dorm.common.service.PlatformUserService;
import com.dorm.common.utils.RequestUtil;
import com.dorm.common.utils.StringUtils;
import com.dorm.common.utils.UserUtils;
import com.dorm.family.entity.Merchant;
import com.dorm.family.service.MerchantService;
import com.dorm.wechat.service.WechatBindingService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by wensheng on 14-12-13.
 */
@Controller
@RequestMapping(value = "/admin")
public class LoginController {

    @Autowired
    private PlatformUserService platformUserService;
    @Autowired
    private WechatBindingService wechatBindingService;
    @Autowired
    private MerchantService merchantService;
    @Autowired
    private PlatformRoleService platformRoleService;


    /**
     * 登录界面
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "admin/login";
    }


    /**
     * 登录失败，真正登录的POST请求由Filter完成
     * @param username
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String username,
                        HttpServletRequest request,
                        Model model) {
        PlatformUser user = UserUtils.getUser();
        // 如果已经登录，则跳转到管理首页
        if(user.getUuid() != null){
            return "redirect:/admin/home" ;
        }
        model.addAttribute(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM, username);
        //model.addAttribute("isValidateCodeLogin", RequestUtil.isValidateCodeLogin(username, true, false));
        String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
//        if("CaptchaException".equals(error)){
//            model.addAttribute("errorMessage", "验证码不正确！");
//        }else
        if("FreezeException".equals(error)){
            model.addAttribute("errorMessage", "账号异常！");
        }else{
            model.addAttribute("errorMessage", "用户名或者密码不正确！");
        }
        return "admin/login";
    }

    /**
     * 登录成功
     */
    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String home(HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
        PlatformUser user = UserUtils.getUser();
        // 登录成功后，验证码计算器清零
        RequestUtil.isValidateCodeLogin(user.getUsername(), false, true);
        //当前账号WechatBinding放入Cache
        wechatBindingService.getWechatBindingByUser();

        String ifHqUser = "N";
        String ifMerchantManager = "N";
        List<PlatformRole> platformRoleList = platformRoleService.queryUserRoleListForUser();
        for(PlatformRole pr:platformRoleList){
            if(pr.getRolekey().split("_")[0].equals("HQ") || pr.getRolekey().equals("WP_SUPER")){
                ifHqUser = "Y";
            }
            if(pr.getRolekey().equals("MERCHANT_MANAGER")){
                ifMerchantManager = "Y";
            }
        }
        model.addAttribute("ifHqUser",ifHqUser);
        model.addAttribute("ifMerchantManager",ifMerchantManager);

        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);

        String merchantId = request.getParameter("merchantId");
        if(StringUtils.isNotBlank(merchantId)){
            model.addAttribute("merchantId",merchantId);
        }else{
            if("Y".equals(ifHqUser)){
                model.addAttribute("merchantId",null);
            }else{
                model.addAttribute("merchantId",merchantList.get(0).getUuid());
            }
        }
        return "admin/home";
    }


    /**
     * 注册界面
     * @return
     */
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register() {
        return "admin/register";
    }

    /**
     * 注册提交
     * @param platformUser
     * @param model
     * @return
     */
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(PlatformUser platformUser,Model model) {
        PlatformUser tempUser = platformUserService.getPlatformUserByUserName(platformUser.getUsername());
        if(tempUser == null){
            platformUserService.registerPlatformUser(platformUser);
            UsernamePasswordToken token = new UsernamePasswordToken();
            token.setUsername(platformUser.getUsername());
            token.setPassword(platformUser.getPlainpassword().toCharArray());
            SecurityUtils.getSubject().login(token);
            return "redirect:/admin/home";
        }else{
            model.addAttribute("errorMessage", "用户名已存在");
            return "admin/register";
        }
    }


    /**
     * 登出
     * @return
     */
    @RequestMapping("/logout")
    public String logout() {
        SecurityUtils.getSubject().logout();
        return "redirect:/admin/login";
    }

    /**
     * 修改密码界面
     * @return
     */
    @RequestMapping(value = "/changePassword", method = RequestMethod.GET)
    public String changePasswordPage(){
        return "admin/changePassword";
    }

    /**
     * 修改密码界面
     * @return
     */
    @RequestMapping(value = "/changePassword", method = RequestMethod.POST)
    public String changePassword(@RequestParam(value = "oldPassword", required = false)String oldPassword, @RequestParam(value = "newPassword", required = false)String newPassword, Model model){
        boolean result = platformUserService.changPassword(oldPassword, newPassword);
        if(result){
            model.addAttribute("successMessage", "修改成功！");
        }else {
            model.addAttribute("errorMessage", "原始密码输入有误！");
        }
        return "admin/changePassword";
    }


}
