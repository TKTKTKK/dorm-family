package com.mtx.portal.controller.guest;

import com.mtx.common.utils.*;
import com.mtx.family.entity.*;
import com.mtx.family.service.*;
import com.mtx.wechat.service.WechatBindingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value = "/guest")
public class MtxGuestController{
    private Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private WechatBindingService wechatBindingService;
    @Autowired
    private MtxProductService mxtProductService;
    @Autowired
    private MtxReserveService mtxReserveService;
    @Autowired
    private MtxConsultService mtxConsultService;
    @Autowired
    private MtxConsultDetailService mtxConsultDetailService;
    @Autowired
    private MtxMemberService mtxMemberService;


    @RequestMapping(value = "/product_center")
    public String product_center(Model model) {
        MtxProduct mtxProduct = new MtxProduct();
        mtxProduct.setStatus("1");
        List<MtxProduct> mtxProductList= mxtProductService.queryForList(mtxProduct);
        model.addAttribute("mtxProductList",mtxProductList);
        return "guest/product_center";
    }

    @RequestMapping(value = "/product_detail")
    public String goods_detail(Model model,MtxProduct mtxProduct) {
        MtxProduct mtxProductTemp= mxtProductService.queryForObjectByPk(mtxProduct);
        model.addAttribute("mtxProduct",mtxProductTemp);
        return "guest/product_detail";
    }

    @RequestMapping(value = "/reserve",method = RequestMethod.GET)
    public String reserve(Model model,MtxProduct mtxProduct) {
        MtxProduct mtxProductTemp= mxtProductService.queryForObjectByPk(mtxProduct);
        model.addAttribute("mtxProduct",mtxProductTemp);
        return "guest/reserve";
    }

    @RequestMapping(value = "/reserve",method = RequestMethod.POST)
    public String saveMtxReserve(MtxReserve mtxReserve){
        if(StringUtils.isBlank(mtxReserve.getProductid())){
            mtxReserve.setProductid(null);
        }
        if(StringUtils.isBlank(mtxReserve.getDetail())){
            mtxReserve.setDetail(null);
        }
        mtxReserveService.insert(mtxReserve);
        return "redirect:/guest/product_center";
    }

    @RequestMapping(value = "/message")
    public String enquiry(MtxConsultDetail mtxConsultDetail, String userid, Model model, HttpServletRequest request) {
        if(StringUtils.isNotBlank(userid)){
            MtxConsult mtxConsult=new MtxConsult();
            mtxConsult.setUserid(userid);
            List<MtxConsult> consultList=mtxConsultService.queryForList(mtxConsult);
            if(consultList.size()==0){
                model.addAttribute("userid",userid);
            }else{
                MtxConsult consult=consultList.get(0);
                model.addAttribute("userid",consult.getUserid());
                model.addAttribute("identify",consult.getIdentify());
                model.addAttribute("flag","1");
                mtxConsultDetail.setConsultid(consult.getUuid());
            }
        }
        List<MtxConsultDetail> mtxConsultDetailList = mtxConsultDetailService.queryForListWithPagination(mtxConsultDetail);
        model.addAttribute("mtxConsultDetailList", mtxConsultDetailList);
        String flag=request.getParameter("flag");
        if(StringUtils.isNotBlank(flag)){
            model.addAttribute("flag",flag);
        }
        return "guest/message";
    }

    @RequestMapping(value = "/addMessage",method = RequestMethod.POST)
    public String addMessage(MtxConsult mtxConsult,String content) {
        String userid=mtxConsultService.addMessage(mtxConsult,content);
        return "redirect:/guest/message?userid="+userid+"&flag=1";
    }

    /**
     * 登录注册
     */
    @RequestMapping(value = "/login")
    public String login() {
        return "guest/login";
    }
    @RequestMapping(value = "/register",method = RequestMethod.GET)
    public String register() {
        return "guest/register";
    }
    @RequestMapping(value = "/register",method = RequestMethod.POST)
    public String addRegister(MtxMember mtxMember) {
        if(StringUtils.isBlank(mtxMember.getMerchantid())){
            mtxMember.setMerchantid("2ae953499da148d89cc3209a00e3b265");
        }
        mtxMemberService.insert(mtxMember);
        return "guest/register";
    }
}