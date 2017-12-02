package com.mtx.portal.controller.admin;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.exception.ServiceException;
import com.mtx.common.utils.StringUtils;
import com.mtx.common.utils.UserUtils;
import com.mtx.family.entity.Merchant;
import com.mtx.family.service.MerchantService;
import com.mtx.portal.PortalContants;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.service.WechatBindingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
 * 微物业
 */
@Controller
@RequestMapping(value = "/admin/wefamily")
public class WeFamilyController extends BaseAdminController {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private WechatBindingService wechatBindingService;
    @Autowired
    private MerchantService merchantService;

    /**
     * 经销商管理界面
     *
     * @return
     */
    @RequestMapping(value = "/merchant")
    public String merchantManage(@RequestParam(required = false, defaultValue = "1") int page, Model model, HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if (null != wechatBinding) {

            Merchant merchant = new Merchant();
            merchant.setBindid(wechatBinding.getUuid());
            merchant.setOrderby("modifyon desc");
            //设置分页参数
            String userid = UserUtils.getUserId();
            List<Merchant> merchantList = merchantService.selectAssignedMerchantForUser();
            String topAccount = "";
            if (merchantList == null || merchantList.isEmpty()) {
                topAccount = "Y";
            }
            model.addAttribute("topAccount", topAccount);
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<Merchant> mtxMerchantList = merchantService.selectMerchantForUserWithPagination(userid, topAccount, merchant, pageBounds);
            model.addAttribute("merchantList", mtxMerchantList);

            String saveFlag = request.getParameter("saveFlag");
            if ("1".equals(saveFlag)) {
                model.addAttribute("successMessage", "保存成功");
            }
            String deleteFlag = request.getParameter("deleteFlag");
            if ("1".equals(deleteFlag)) {
                model.addAttribute("successMessage", "删除成功");
            }
        }
        return "admin/wefamily/merchantManage";
    }


    /**
     * 经销商信息界面
     *
     * @return
     */
    @RequestMapping(value = "/merchantInfo", method = RequestMethod.GET)
    public String showMerchantInfo(HttpServletRequest request, Model model) {
        String merchantId = request.getParameter("merchantId");
        if (StringUtils.isNoneBlank(merchantId)) {
            //查询小区信息
            Merchant merchant = new Merchant();
            merchant.setUuid(merchantId);
            merchant = merchantService.queryForObjectByPk(merchant);
            model.addAttribute("merchant", merchant);
        }
        model.addAttribute("view", request.getParameter("view"));
        return "admin/wefamily/merchantInfo";
    }

    /**
     * 修改/添加小区信息
     *
     * @return
     */
    @RequestMapping(value = "/merchantInfo", method = RequestMethod.POST)
    public String addMerchantInfo(@RequestParam(value = "picUrl", required = false) MultipartFile multipartFile, Merchant merchant, Model model) {
        //检查是否重名
        Merchant merchantForRepeat = merchantService.selectMerchantForSave(merchant);
        if (null != merchantForRepeat) {
            model.addAttribute("errorMessage", "抱歉，该经销商已存在！");
        } else {
            //修改
            if (StringUtils.isNotBlank(merchant.getUuid())) {
                Merchant merchantForMod = merchantService.queryForObjectByPk(merchant);
                merchantForMod.setName(merchant.getName());
                String contactno = merchant.getContactno().replaceAll("，", ",");
                merchantForMod.setContactno(contactno);
                merchantForMod.setAddress(merchant.getAddress());
                merchantForMod.setVersionno(merchant.getVersionno());
                merchantForMod.setProvince(merchant.getProvince());
                merchantForMod.setCity(merchant.getCity());
                merchantForMod.setDistrict(merchant.getDistrict());
                try {
                    merchantService.updatePartial(merchantForMod);
                    model.addAttribute("successMessage", "保存成功！");
                } catch (ServiceException e) {
                    model.addAttribute("errorMessage", "系统忙，稍候再试！");
                }
                merchant = merchantService.queryForObjectByPk(merchant);
            } else {
                //添加
                WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
                merchant.setBindid(wechatBinding.getUuid());
                merchantService.insert(merchant);
                model.addAttribute("successMessage", "保存成功！");
            }
            model.addAttribute("merchant", merchant);
        }
        return "redirect:/admin/wefamily/merchant";
    }

    /**
     * 删除
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteMerchant")
    public String deleteMerchant(HttpServletRequest request) {
        String merchantId = request.getParameter("merchantId");
        Merchant merchant = new Merchant();
        merchant.setUuid(merchantId);
        merchantService.delete(merchant);
        return "redirect:/admin/wefamily/merchant?successFlag=1";
    }

}