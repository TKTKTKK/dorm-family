package com.mtx.portal.controller.admin;

import com.mtx.common.entity.CommonCode;
import com.mtx.common.exception.ServiceException;
import com.mtx.common.service.CommonCodeService;
import com.mtx.common.utils.*;
import com.mtx.wechat.WechatConstants;
import com.mtx.wechat.entity.admin.WechatBaseCard;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.card.WechatCard;
import com.mtx.wechat.entity.card.base.BaseInfo;
import com.mtx.wechat.entity.card.base.DateInfo;
import com.mtx.wechat.entity.card.base.SKU;
import com.mtx.wechat.entity.card.general.GeneralCoupon;
import com.mtx.wechat.entity.card.general.GeneralCouponCard;
import com.mtx.wechat.entity.card.member.MemberCard;
import com.mtx.wechat.entity.card.member.MemberCoupon;
import com.mtx.wechat.service.WechatBaseCardService;
import com.mtx.wechat.service.WechatBindingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by shanny on 1/13/2015.
 */
@Controller
@RequestMapping(value = "/admin/card")
public class CardController {
    @Autowired
    private WechatBindingService wechatBindingService;
    @Autowired
    private WechatBaseCardService wechatBaseCardService;
    @Autowired
    private CommonCodeService commonCodeService;

    /**
     * 创建卡券界面
     * @return
     */
    @RequestMapping(value = "/createCard", method = RequestMethod.GET)
    public String createMemberCardPage(Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);

        //卡券颜色
        CommonCode commonCode = new CommonCode();
        commonCode.setCodetype("CARD_COLOR");
        commonCode.setOrderby("orderno");
        List<CommonCode> commonCodeList = commonCodeService.queryForList(commonCode);
        model.addAttribute("commonCodeList", commonCodeList);

        //领券期限
        List beginTermList = new ArrayList();
        for(int i=0; i<=90; i++){
            beginTermList.add(i);
        }
        model.addAttribute("beginTermList", beginTermList);

        List fixedTermList = new ArrayList();
        for(int i=1; i<=90; i++){
            fixedTermList.add(i);
        }
        model.addAttribute("fixedTermList", fixedTermList);

        String card_type = request.getParameter("card_type");
        if(StringUtils.isNotEmpty(card_type)){
            model.addAttribute("card_type", card_type);
        }else {
            model.addAttribute("card_type", WechatConstants.CARD_TYPE_GENERAL_COUPON);
        }
        if(WechatConstants.CARD_TYPE_MEMBER_CARD.equals(card_type)){
            model.addAttribute("preObj","member_card");
            model.addAttribute("actionStr","createMemberCard");
        }else{
            model.addAttribute("preObj","general_coupon");
            model.addAttribute("actionStr","createGeneralCard");
        }

        String successFlag = request.getParameter("successFlag");
        //创建卡券成功
        if("1".equals(successFlag)){
            model.addAttribute("successMessage", "创建成功！");
        }

        return "admin/card/createCard";
    }

    /**
     * 创建会员卡
     * @return
     */
    @RequestMapping(value = "/createMemberCard", method = RequestMethod.POST)
    public String createMemberCard(MemberCard memberCard, Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);

        //转化baseInfo数据
        transformBaseInfoData(memberCard.getMember_card().getBase_info(), request);

        //新增会员卡至card表
        WechatBaseCard wechatBaseCard = new WechatBaseCard();
        wechatBaseCard.setBindid(wechatBinding.getUuid());
        wechatBaseCard.setCard_type(WechatConstants.CARD_TYPE_MEMBER_CARD);
        //baseInfo
        installBaseInfoData(wechatBaseCard, memberCard.getMember_card().getBase_info(), memberCard.getCard_type());

        //会员卡特有字段
        if(null != memberCard.getMember_card().getSupply_bonus() ){
            wechatBaseCard.setSupply_bonus("Y");
        }else {
            memberCard.getMember_card().setSupply_bonus(false);
            wechatBaseCard.setSupply_bonus("N");
        }
        if(null != memberCard.getMember_card().getSupply_balance() ){
            wechatBaseCard.setSupply_balance("Y");
        }else {
            memberCard.getMember_card().setSupply_balance(false);
            wechatBaseCard.setSupply_balance("N");
        }
        wechatBaseCard.setBonus_cleared(memberCard.getMember_card().getBonus_cleared());
        wechatBaseCard.setBonus_rules(memberCard.getMember_card().getBonus_rules());
        wechatBaseCard.setBalance_rules(memberCard.getMember_card().getBalance_rules());
        wechatBaseCard.setPrerogative(memberCard.getMember_card().getPrerogative());
        wechatBaseCard.setBind_old_card_url(memberCard.getMember_card().getBind_old_card_url());
        wechatBaseCard.setActivate_url(memberCard.getMember_card().getActivate_url());

        wechatBaseCard.setStatus("INIT");
        wechatBaseCard.setCard_id("TEMP-MEMBER-CARD-ID");

        //创建会员卡
        wechatBaseCardService.addCard(wechatBaseCard, memberCard);

        int successFlag = 1;

        return "redirect:/admin/card/createCard?card_type="+memberCard.getCard_type()+"&successFlag="+successFlag;
    }

    /**
     * 创建优惠券
     * @return
     */
    @RequestMapping(value = "/createGeneralCard", method = RequestMethod.POST)
    public String createGeneralCard(GeneralCouponCard generalCouponCard, Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);

        //转化baseInfo数据
        transformBaseInfoData(generalCouponCard.getGeneral_coupon().getBase_info(), request);

        //新增优惠券至card表
        WechatBaseCard wechatBaseCard = new WechatBaseCard();
        wechatBaseCard.setBindid(wechatBinding.getUuid());
        wechatBaseCard.setCard_type(WechatConstants.CARD_TYPE_GENERAL_COUPON);
        //baseInfo
        installBaseInfoData(wechatBaseCard, generalCouponCard.getGeneral_coupon().getBase_info(), generalCouponCard.getCard_type());

        //优惠券特有字段
        wechatBaseCard.setDetail(generalCouponCard.getGeneral_coupon().getDefault_detail());

        wechatBaseCard.setStatus("INIT");
        wechatBaseCard.setCard_id("TEMP-GENERAL-COUPON-CARD-ID");

        //创建优惠券
        wechatBaseCardService.addCard(wechatBaseCard, generalCouponCard);

        int successFlag = 1;

        return "redirect:/admin/card/createCard?card_type="+generalCouponCard.getCard_type()+"&successFlag="+successFlag;
    }

    /**
     * 转化baseInfo数据
     * @param baseInfo
     */
    private void transformBaseInfoData(BaseInfo baseInfo, HttpServletRequest request){
        baseInfo.setColor(baseInfo.getColor().split("-")[0]);
        //当选择 固定日期 时
        if(baseInfo.getDate_info().getType() == 1){
            String begin_timestampstr = request.getParameter("begin_timestampstr");
            String end_timestampstr = request.getParameter("end_timestampstr");
            baseInfo.getDate_info().setBegin_timestamp(String.valueOf(DateUtils.parseDate(begin_timestampstr).getTime() / 1000));
            baseInfo.getDate_info().setEnd_timestamp(String.valueOf(DateUtils.parseDate(end_timestampstr).getTime() / 1000));
        }
    }

    /**
     * 设置baseInfo相关字段
     * @param wechatBaseCard
     */
    private void installBaseInfoData(WechatBaseCard wechatBaseCard, BaseInfo baseInfo, String card_type){
        wechatBaseCard.setLogo_url(baseInfo.getLogo_url());
        wechatBaseCard.setCode_type(baseInfo.getCode_type());
        wechatBaseCard.setBrand_name(baseInfo.getBrand_name());
        wechatBaseCard.setTitle(baseInfo.getTitle());
        wechatBaseCard.setSub_title(baseInfo.getSub_title());
        wechatBaseCard.setColor(baseInfo.getColor());
        wechatBaseCard.setNotice(baseInfo.getNotice());
        wechatBaseCard.setDescription(baseInfo.getDescription());
        wechatBaseCard.setType(baseInfo.getDate_info().getType());
        //固定日期
        if(baseInfo.getDate_info().getType() == 1){
            wechatBaseCard.setBegin_timestamp(Long.parseLong(baseInfo.getDate_info().getBegin_timestamp()));
            wechatBaseCard.setEnd_timestamp(Long.parseLong(baseInfo.getDate_info().getEnd_timestamp()));
        }
        wechatBaseCard.setFixed_begin_term(baseInfo.getDate_info().getFixed_begin_term());
        wechatBaseCard.setFixed_term(baseInfo.getDate_info().getFixed_term());
        wechatBaseCard.setQuantity(baseInfo.getSku().getQuantity());
        if(null != baseInfo.getCan_share()){
            wechatBaseCard.setCan_share("Y");
        }else {
            wechatBaseCard.setCan_share("N");
        }
        //会员卡不支持转赠
        if(WechatConstants.CARD_TYPE_MEMBER_CARD.equals(card_type)){
            baseInfo.setCan_give_friend(false);
            wechatBaseCard.setCan_give_friend("N");
        }else {
            if(null != baseInfo.getCan_give_friend()){
                wechatBaseCard.setCan_give_friend("Y");
            }else{
                wechatBaseCard.setCan_give_friend("N");
            }
        }

        wechatBaseCard.setGet_limit(baseInfo.getGet_limit());
        wechatBaseCard.setService_phone(baseInfo.getService_phone());
    }

    /**
     * 商家信息
     * @return
     */
    @RequestMapping(value = "/brandInfo", method = RequestMethod.GET)
    public String businessInfo(Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != wechatBinding){
            model.addAttribute("logo_url", wechatBinding.getLogo_url());
            model.addAttribute("brand_name", wechatBinding.getBrand_name());
        }

        return "admin/card/brandInfo";
    }

    /**
     * 添加/修改商家信息
     * @param model
     * @return
     */
    @RequestMapping(value = "/brandInfo", method = RequestMethod.POST)
    public String addBusinessInfo(@RequestParam(value = "picture", required = false)MultipartFile multipartFile, HttpServletRequest request, Model model){
        WechatBinding wechatBinding = new WechatBinding();
        wechatBinding.setUuid(UserUtils.getUserBindId());
        wechatBinding = wechatBindingService.queryForObjectByPk(wechatBinding);

        String logoname = request.getParameter("logoname");
        String brand_name = request.getParameter("brand_name");
        if(!multipartFile.isEmpty()){
            //不能超过1M
            long fileSize = multipartFile.getSize();
            if(fileSize > 1000000){
                model.addAttribute("errorMessage", "抱歉，图片大小不能超过1M.");
            }else {
                //调用上传文件工具类 管理员模块
                logoname = UploadUtils.uploadFile(multipartFile, "admin");
            }
        }else{
            wechatBinding.setBrand_name(brand_name);
            try {
                wechatBinding.setVersionno(Integer.parseInt(request.getParameter("versionno")));
                if(StringUtils.isNotBlank(logoname)){
                    //上传商户LOGO
                    String logo_url = wechatBindingService.updateBrandLogo(logoname);
                    if(StringUtils.isNotBlank(logo_url)){
                        wechatBinding.setLogo_url(logo_url);
                    }
                }
                wechatBindingService.updatePartial(wechatBinding);
                CacheUtils.put(WechatConstants.BIND_DETAILS_CACHE,wechatBinding.getUuid(),wechatBinding);
                model.addAttribute("successMessage", "保存成功！");
            } catch (ServiceException e) {
                model.addAttribute("errorMessage", "系统忙，稍候再试");
            }
        }
        if(StringUtils.isBlank(logoname)){
            model.addAttribute("logo_url", wechatBinding.getLogo_url());
        }

        model.addAttribute("logoname", logoname);
        model.addAttribute("brand_name", brand_name);
        wechatBinding = wechatBindingService.queryForObjectByPk(wechatBinding);
        model.addAttribute("wechatBinding", wechatBinding);

        return "admin/card/brandInfo";
    }


    /**
     * 查询所有卡券
     * @param model
     * @return
     */
    @RequestMapping(value = "/searchAllCards")
    public String searchAllCards(Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);

        if(null != wechatBinding){
            WechatBaseCard wechatBaseCard = new WechatBaseCard();
            wechatBaseCard.setBindid(wechatBinding.getUuid());
            wechatBaseCard.setOrderby("modifyon desc");
            List<WechatBaseCard> wechatBaseCardList = wechatBaseCardService.queryForList(wechatBaseCard);
            model.addAttribute("wechatBaseCardList", wechatBaseCardList);

            String createFlag = request.getParameter("createFlag");
            if("1".equals(createFlag)){
                model.addAttribute("successMessage", "成功生成二维码");
            }
        }

        return "admin/card/searchAllCards";
    }


    /**
     * 卡券详情
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "/cardInfo", method = RequestMethod.GET)
    public String showCardInfo(Model model, HttpServletRequest request){
        String baseCardId = request.getParameter("baseCardId");
        WechatBaseCard wechatBaseCard = new WechatBaseCard();
        wechatBaseCard.setUuid(baseCardId);
        wechatBaseCard = wechatBaseCardService.queryForObjectByPk(wechatBaseCard);
        //固定日期区间
        if(wechatBaseCard.getType() == 1){
            String begin_timestampstr = DateUtils.formatDate(new Date(wechatBaseCard.getBegin_timestamp() * 1000));
            String end_timestampstr = DateUtils.formatDate(new Date(wechatBaseCard.getEnd_timestamp() * 1000));
            wechatBaseCard.setBegin_timestampstr(begin_timestampstr);
            wechatBaseCard.setEnd_timestampstr(end_timestampstr);
        }
        model.addAttribute("wechatBaseCard", wechatBaseCard);

        //卡券颜色
        CommonCode commonCode = new CommonCode();
        commonCode.setCodetype("CARD_COLOR");
        commonCode.setOrderby("orderno");
        List<CommonCode> commonCodeList = commonCodeService.queryForList(commonCode);
        model.addAttribute("commonCodeList", commonCodeList);
        //领券期限
        List beginTermList = new ArrayList();
        for(int i=0; i<=90; i++){
            beginTermList.add(i);
        }
        model.addAttribute("beginTermList", beginTermList);

        List fixedTermList = new ArrayList();
        for(int i=1; i<=90; i++){
            fixedTermList.add(i);
        }
        model.addAttribute("fixedTermList", fixedTermList);

        String saveFlag = request.getParameter("saveFlag");
        //保存成功
        if("1".equals(saveFlag)){
            model.addAttribute("successMessage", "保存成功");
        }

        return "admin/card/cardInfo";
    }

    /**
     * 修改卡券信息
     * @param wechatBaseCard
     * @return
     */
    @RequestMapping(value="/cardInfo", method = RequestMethod.POST)
    public String saveCardInfo(WechatBaseCard wechatBaseCard){
        //修改
        if(StringUtils.isNotBlank(wechatBaseCard.getUuid())){
            //转化baseCard数据
            transformBaseCardData(wechatBaseCard);

            //baseInfo start
            BaseInfo baseInfo = new BaseInfo();
            baseInfo.setLogo_url(wechatBaseCard.getLogo_url());
            baseInfo.setCode_type(wechatBaseCard.getCode_type());
            baseInfo.setBrand_name(wechatBaseCard.getBrand_name());
            baseInfo.setTitle(wechatBaseCard.getTitle());
            baseInfo.setSub_title(wechatBaseCard.getSub_title());
            baseInfo.setColor(wechatBaseCard.getColor());
            baseInfo.setNotice(wechatBaseCard.getNotice());
            baseInfo.setDescription(wechatBaseCard.getDescription());

            DateInfo dateInfo = new DateInfo();
            dateInfo.setType(wechatBaseCard.getType());
            //固定日期
            if(wechatBaseCard.getType() == 1){
                dateInfo.setBegin_timestamp(String.valueOf(wechatBaseCard.getBegin_timestamp()));
                dateInfo.setEnd_timestamp(String.valueOf(wechatBaseCard.getEnd_timestamp()));
            }
            dateInfo.setFixed_begin_term(wechatBaseCard.getFixed_begin_term());
            dateInfo.setFixed_term(wechatBaseCard.getFixed_term());
            baseInfo.setDate_info(dateInfo);

            SKU sku = new SKU();
            sku.setQuantity(wechatBaseCard.getQuantity());
            baseInfo.setSku(sku);

            baseInfo.setLocation_id_list(wechatBaseCard.getLocation_id_list());
            if("Y".equals(wechatBaseCard.getCan_share())){
                baseInfo.setCan_share(true);
            }else {
                baseInfo.setCan_share(false);
            }
            if("Y".equals(wechatBaseCard.getCan_give_friend())){
                baseInfo.setCan_give_friend(true);
            }else {
                baseInfo.setCan_give_friend(false);
            }
            baseInfo.setGet_limit(wechatBaseCard.getGet_limit());
            baseInfo.setService_phone(wechatBaseCard.getService_phone());
            //baseInfo end

            WechatCard wechatCard = new WechatCard();
            //特有字段
            //优惠券
            if(WechatConstants.CARD_TYPE_GENERAL_COUPON.equals(wechatBaseCard.getCard_type())){
                GeneralCoupon generalCoupon = new GeneralCoupon();
                generalCoupon.setBase_info(baseInfo);
                generalCoupon.setDefault_detail(wechatBaseCard.getDetail());

                GeneralCouponCard generalCouponCard = new GeneralCouponCard();
                generalCouponCard.setCard_type(WechatConstants.CARD_TYPE_GENERAL_COUPON);
                generalCouponCard.setGeneral_coupon(generalCoupon);

                wechatCard.setCard(generalCouponCard);
            }else if(WechatConstants.CARD_TYPE_MEMBER_CARD.equals(wechatBaseCard.getCard_type())){
                //会员卡
                MemberCoupon memberCoupon = new MemberCoupon();
                memberCoupon.setBase_info(baseInfo);
                if("Y".equals(wechatBaseCard.getSupply_bonus())){
                    memberCoupon.setSupply_bonus(true);
                }else {
                    memberCoupon.setSupply_bonus(false);
                }
                memberCoupon.setBonus_cleared(wechatBaseCard.getBonus_cleared());
                memberCoupon.setBonus_rules(wechatBaseCard.getBonus_rules());
                memberCoupon.setPrerogative(wechatBaseCard.getPrerogative());
                memberCoupon.setBind_old_card_url(wechatBaseCard.getBind_old_card_url());
                memberCoupon.setActivate_url(wechatBaseCard.getActivate_url());

                MemberCard memberCard = new MemberCard();
                memberCard.setCard_type(WechatConstants.CARD_TYPE_MEMBER_CARD);
                memberCard.setMember_card(memberCoupon);

                wechatCard.setCard(memberCard);
            }

            //修改卡券
            wechatBaseCardService.updateCard(wechatBaseCard, wechatCard);
        }
        return "redirect:/admin/card/cardInfo?saveFlag=1&baseCardId="+wechatBaseCard.getUuid();
    }

    /**
     * 转化baseCard数据
     * @param wechatBaseCard
     */
    private void transformBaseCardData(WechatBaseCard wechatBaseCard){
        wechatBaseCard.setColor(wechatBaseCard.getColor().split("-")[0]);
        //当选择 固定日期 时
        if(wechatBaseCard.getType() == 1){
            wechatBaseCard.setBegin_timestamp(DateUtils.parseDate(wechatBaseCard.getBegin_timestampstr()).getTime() / 1000);
            wechatBaseCard.setEnd_timestamp(DateUtils.parseDate(wechatBaseCard.getEnd_timestampstr()).getTime() / 1000);
        }

        if(StringUtils.isNotBlank(wechatBaseCard.getCan_share())){
            wechatBaseCard.setCan_share("Y");
        }else {
            wechatBaseCard.setCan_share("N");
        }
        if(StringUtils.isNotBlank(wechatBaseCard.getCan_give_friend())){
            wechatBaseCard.setCan_give_friend("Y");
        }else {
            wechatBaseCard.setCan_give_friend("N");
        }

        //特有字段
        //会员卡
        if(WechatConstants.CARD_TYPE_MEMBER_CARD.equals(wechatBaseCard.getCard_type())){
            if(StringUtils.isNotBlank(wechatBaseCard.getSupply_bonus())){
                wechatBaseCard.setSupply_bonus("Y");
            }else {
                wechatBaseCard.setSupply_bonus("N");
            }
            if(StringUtils.isNotBlank(wechatBaseCard.getSupply_balance())){
                wechatBaseCard.setSupply_balance("Y");
            }else {
                wechatBaseCard.setSupply_balance("N");
            }
        }

    }

    /**
     * 生成二维码
     * @return
     */
    @RequestMapping(value = "/creaetQrCode")
    public String createQrCode(HttpServletRequest request){
        String baseCardId = request.getParameter("baseCardId");
        WechatBaseCard wechatBaseCard = new WechatBaseCard();
        wechatBaseCard.setUuid(baseCardId);
        wechatBaseCard = wechatBaseCardService.queryForObjectByPk(wechatBaseCard);
        //生成二维码
        wechatBaseCardService.createQrCode(wechatBaseCard);
          return "redirect:/admin/card/searchAllCards?createFlag=1";
    }
}
