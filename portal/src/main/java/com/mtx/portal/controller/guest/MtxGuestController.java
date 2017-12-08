package com.mtx.portal.controller.guest;

import com.mtx.common.utils.StringUtils;
import com.mtx.family.entity.MtxConsult;
import com.mtx.family.entity.MtxProduct;
import com.mtx.family.service.MtxConsultService;
import com.mtx.family.service.MtxProductService;
import com.mtx.portal.controller.admin.BaseAdminController;
import com.mtx.wechat.service.WechatBindingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


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
    private MtxConsultService mtxConsultService;


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

    @RequestMapping(value = "/consult",method = RequestMethod.GET)
    public String consult(Model model,MtxProduct mtxProduct) {
        MtxProduct mtxProductTemp= mxtProductService.queryForObjectByPk(mtxProduct);
        model.addAttribute("mtxProduct",mtxProductTemp);
        return "guest/consult";
    }

    @RequestMapping(value = "/consult",method = RequestMethod.POST)
    public String saveMtxConsult(MtxConsult mtxConsult){
        if(StringUtils.isBlank(mtxConsult.getProductid())){
            mtxConsult.setProductid(null);
        }
        if(StringUtils.isBlank(mtxConsult.getDetail())){
            mtxConsult.setDetail(null);
        }
        mtxConsultService.insert(mtxConsult);
        return "redirect:/guest/product_center";
    }

    @RequestMapping(value = "/message")
    public String enquiry(Model model) {
        return "guest/message";
    }
}