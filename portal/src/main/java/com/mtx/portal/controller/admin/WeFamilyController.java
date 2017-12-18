package com.mtx.portal.controller.admin;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.entity.Attachment;
import com.mtx.common.entity.CommonCode;
import com.mtx.common.entity.PlatformUser;
import com.mtx.common.exception.ServiceException;
import com.mtx.common.service.AttachmentService;
import com.mtx.common.service.CommonCodeService;
import com.mtx.common.service.PlatformUserService;
import com.mtx.common.service.SequenceService;
import com.mtx.common.utils.DateUtils;
import com.mtx.common.utils.StringUtils;
import com.mtx.common.utils.UploadUtils;
import com.mtx.common.utils.UserUtils;
import com.mtx.family.entity.*;
import com.mtx.family.service.*;
import com.mtx.portal.PortalContants;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.service.WechatBindingService;
import com.mtx.wechat.service.WpUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.HashMap;

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
    @Autowired
    private OrderService orderService;
    @Autowired
    private SequenceService sequenceService;
    @Autowired
    private MachineService machineService;
    @Autowired
    private LogisticsService logisticsService;
    @Autowired
    private MtxProductService mxtProductService;
    @Autowired
    private MtxReserveService mtxReserveService;
    @Autowired
    private MtxConsultService mtxConsultService;
    @Autowired
    private MtxConsultDetailService mtxConsultDetailService;
    @Autowired
    private MtxPointService mtxPointService;
    @Autowired
    private WpUserService wpUserService;
    @Autowired
    private ReceiptService receiptService;
    @Autowired
    private AttachmentService attachmentService;
    @Autowired
    private TrainService trainService;
    @Autowired
    private CommonCodeService commonCodeService;
    @Autowired
    private MtxVideoService mtxVideoService;
    @Autowired
    private RepairService repairService;
    @Autowired
    private RepairWorkerService repairWorkerService;
    @Autowired
    private PlatformUserService platformUserService;

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

    /**
     * 产品管理
     */
    @RequestMapping(value = "/MtxProduct")
    public String MtxProduct(@RequestParam(required = false, defaultValue = "1") int page, MtxProduct mtxProduct, Model model, HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String flag="1";
        if (null != wechatBinding) {
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<MtxProduct> mtxProductList = mxtProductService.queryForListWithPagination(mtxProduct, pageBounds,flag);
            model.addAttribute("mtxProductList", mtxProductList);
            model.addAttribute("mtxProduct",mtxProduct);
        }
        String successFlag=request.getParameter("deleteFlag");
        if("1".equals(successFlag)){
            model.addAttribute("successFlag","删除成功");
        }
        return "admin/wefamily/mtxProductManage";
    }

    @RequestMapping(value = "/goMtxProduct", method = RequestMethod.GET)
    public String goMtxProduct(Model model,MtxProduct mtxProduct){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        MtxProduct mtxProductTemp=mxtProductService.queryForObjectByPk(mtxProduct);
        model.addAttribute("mtxProduct",mtxProductTemp);
        return "admin/wefamily/mtxProductInfo";
    }

    @RequestMapping(value = "/updateMtxProduct",method = RequestMethod.POST)
    public String updateMtxProduct(@RequestParam(value = "imgfile", required = false)MultipartFile multipartFile, MtxProduct mtxProduct, RedirectAttributes redirectAttributes, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != multipartFile && !multipartFile.isEmpty()){
            String foldername = "product";
            String filename = UploadUtils.uploadFile(multipartFile, foldername);
            mtxProduct.setImg(filename);
        }
        if (StringUtils.isBlank(mtxProduct.getUuid())) {
            mtxProduct.setType("PRODUCT");
            int p=0;
            if(mtxProduct.getPrice()!=null){
                double price = mtxProduct.getPrice();
                p = (int) price;
                mtxProduct.setPoints(p);
            }
            mxtProductService.insert(mtxProduct);
            model.addAttribute("mtxProduct", mtxProduct);
            model.addAttribute("successMessage", "保存成功！");
        } else {
            try {
                mxtProductService.updatePartial(mtxProduct);
                MtxProduct mtxProductTemp = mxtProductService.queryForObjectByPk(mtxProduct);
                model.addAttribute("mtxProduct", mtxProductTemp);
            } catch (ServiceException e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "数据已修改，请重试！");
                return "redirect:/admin/wefamily/goMtxProduct?uuid=" + mtxProduct.getUuid();

            }
            model.addAttribute("successMessage", "保存成功！");
        }
        return "admin/wefamily/mtxProductInfo";
    }

    @RequestMapping(value = "/deleteMtxProduct", method = RequestMethod.POST)
    @ResponseBody
    public Map deleteMtxProduct(MtxProduct mtxProduct){
        int deleteFlag=mxtProductService.delete(mtxProduct);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }

    /**
     * 订单管理（界面）
     * @param model
     * @return
     */
    @RequestMapping(value = "/orderManage",method = RequestMethod.GET)
    public String orderManage(Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
        model.addAttribute("successMessage",request.getParameter("successMessage"));
        return "admin/wefamily/orderManage";
    }

    /**
     * 订单管理
     * @param order
     * @param model
     * @return
     */
    @RequestMapping(value = "/orderManage",method = RequestMethod.POST)
    public String orderManage(@RequestParam(required = false,defaultValue = "1") int page,Order order,Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
        model.addAttribute("order",order);
        if(null != wechatBinding){
            String startDateStr = request.getParameter("startDateStr");
            model.addAttribute("startDateStr", startDateStr);
            String endDateStr = request.getParameter("endDateStr");
            model.addAttribute("endDateStr", endDateStr);
            Date startDate = DateUtils.parseDate(startDateStr);
            Date endDate = DateUtils.parseDate(endDateStr);
            startDate = DateUtils.getDateStart(startDate);
            endDate = DateUtils.getDateEnd(endDate);
            String startDateTimeStr = "";
            if(null != startDate){
                startDateTimeStr = DateUtils.formatDate(startDate, "yyyy-MM-dd HH:mm:ss");
            }
            String endDateTimeStr = "";
            if(null != endDate){
                endDateTimeStr = DateUtils.formatDate(endDate, "yyyy-MM-dd HH:mm:ss");
            }
            order.setBindid(wechatBinding.getUuid());
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<Order> orderList = orderService.queryOrderList(order, startDateTimeStr, endDateTimeStr, pageBounds);
            model.addAttribute("orderList", orderList);

            //删除结果
            String deleteFlag = request.getParameter("deleteFlag");
            if("1".equals(deleteFlag)){
                model.addAttribute("successMessage", "删除成功");
            }else if("0".equals(deleteFlag)){
                model.addAttribute("errorMessage", "删除失败");
            }
            //订单发送结果
            String sendFlag = request.getParameter("sendFlag");
            if("1".equals(sendFlag)){
                model.addAttribute("successMessage", "发送成功");
            }else if("0".equals(sendFlag)){
                model.addAttribute("errorMessage", "发送失败");
            }
        }

        return "admin/wefamily/orderManage";
    }

    /**
     * 删除订单
     * @param request
     * @return
     */
    @RequestMapping("/deleteOrder")
    @ResponseBody
    public Map<String, Object> deleteOrder(HttpServletRequest request){
        int deleteFlag = 0;
        String orderId = request.getParameter("orderId");
        if(StringUtils.isNotBlank(orderId)){
            Order order = new Order();
            order.setUuid(orderId);
            deleteFlag = orderService.delete(order);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }

    /**
     * 发送订单
     * @param request
     * @return
     */
    @RequestMapping("/sendOrder")
    @ResponseBody
    public Map<String, Object> sendOrder(HttpServletRequest request){
        int sendFlag = 0;
        String orderId = request.getParameter("orderId");
        String versionno = request.getParameter("versionno");
        if(StringUtils.isNotBlank(orderId)){
            Order order = new Order();
            order.setUuid(orderId);
            order.setVersionno(Integer.valueOf(versionno));
            sendFlag = orderService.sendOrder(order);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("sendFlag", sendFlag);
        return resultMap;
    }

    /**
     * 订单信息（界面）
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/orderInfo",method = RequestMethod.GET)
    public String orderInfo(HttpServletRequest request,Model model){
        String merchantId = request.getParameter("merchantId");
        Merchant merchant = new Merchant();
        merchant.setUuid(merchantId);
        merchant = merchantService.queryForObjectByPk(merchant);
        model.addAttribute("merchant",merchant);
        String orderId = request.getParameter("orderId");
        if(StringUtils.isNotBlank(orderId)){
            Order order = new Order();
            order.setUuid(orderId);
            order = orderService.queryForObjectByPk(order);
            model.addAttribute("order", order);
        }
        return "admin/wefamily/orderInfo";
    }

    /**
     * 订单信息
     * @param order
     * @param redirectAttributes
     * @param model
     * @return
     */
    @RequestMapping(value = "/orderInfo",method = RequestMethod.POST)
    public String orderInfo(Order order, RedirectAttributes redirectAttributes, Model model){
        order.setBindid(UserUtils.getUserBindId());
        //修改
        if(StringUtils.isNotBlank(order.getUuid())){
            try {
                orderService.updatePartial(order);
                redirectAttributes.addFlashAttribute("successMessage", "保存成功");
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "系统忙，稍候再试");
            }
        }else{
            //添加
            order.setStatus("NEW");
            order.setSnno(sequenceService.getOrderSeqNo());
            List<Order> orderList = orderService.queryOrderForSnnoRepeat(order);
            if(null != orderList && orderList.size()>0){
                model.addAttribute("errorMessage", "抱歉，订单编号重复!");
                return  "admin/wefamily/orderInfo";
            }
            orderService.insert(order);
            redirectAttributes.addFlashAttribute("successMessage", "保存成功");
            order = new Order();
        }

        return "redirect:orderInfo?orderId=" + order.getUuid();
    }

    /**
     * 机器管理（界面）
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "/machineManage",method = RequestMethod.GET)
    public String machineManage(Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        model.addAttribute("successMessage",request.getParameter("successMessage"));
        return "admin/wefamily/machineManage";
    }

    /**
     * 机器管理
     * @param machine
     * @param model
     * @return
     */
    @RequestMapping(value = "/machineManage",method = RequestMethod.POST)
    public String machineManage(@RequestParam(required = false,defaultValue = "1") int page,Machine machine,Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        model.addAttribute("machine",machine);
        if(null != wechatBinding){
            String startDateStr = request.getParameter("startDateStr");
            model.addAttribute("startDateStr", startDateStr);
            String endDateStr = request.getParameter("endDateStr");
            model.addAttribute("endDateStr", endDateStr);
            Date startDate = DateUtils.parseDate(startDateStr);
            Date endDate = DateUtils.parseDate(endDateStr);
            startDate = DateUtils.getDateStart(startDate);
            endDate = DateUtils.getDateEnd(endDate);
            String startDateTimeStr = "";
            if(null != startDate){
                startDateTimeStr = DateUtils.formatDate(startDate, "yyyy-MM-dd HH:mm:ss");
            }
            String endDateTimeStr = "";
            if(null != endDate){
                endDateTimeStr = DateUtils.formatDate(endDate, "yyyy-MM-dd HH:mm:ss");
            }
            machine.setBindid(wechatBinding.getUuid());
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<Machine> machineList = machineService.queryMachineList(machine, startDateTimeStr, endDateTimeStr, pageBounds);
            model.addAttribute("machineList", machineList);

            //删除结果
            String deleteFlag = request.getParameter("deleteFlag");
            if("1".equals(deleteFlag)){
                model.addAttribute("successMessage", "删除成功");
            }else if("0".equals(deleteFlag)){
                model.addAttribute("errorMessage", "删除失败");
            }
        }

        return "admin/wefamily/machineManage";
    }

    /**
     * 机器信息（界面）
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/machineInfo",method = RequestMethod.GET)
    public String machineInfo(HttpServletRequest request,Model model){
        String machineId = request.getParameter("machineId");
        if(StringUtils.isNotBlank(machineId)){
            Machine machine = new Machine();
            machine.setUuid(machineId);
            machine = machineService.queryForObjectByPk(machine);
            model.addAttribute("machine", machine);
        }
        return "admin/wefamily/machineInfo";
    }

    /**
     * 机器信息
     * @param machine
     * @param redirectAttributes
     * @param model
     * @return
     */
    @RequestMapping(value = "/machineInfo",method = RequestMethod.POST)
    public String machineInfo(Machine machine, RedirectAttributes redirectAttributes, Model model){
        machine.setBindid(UserUtils.getUserBindId());
        List<Machine> machineList = machineService.queryMachineForNoRepeat(machine);
        if(null != machineList && machineList.size()>0){
            model.addAttribute("errorMessage", "抱歉，机器号重复!");
            return  "admin/wefamily/machineInfo";
        }
        //修改
        if(StringUtils.isNotBlank(machine.getUuid())){
            try {
                machineService.updatePartial(machine);
                redirectAttributes.addFlashAttribute("successMessage", "保存成功");
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "系统忙，稍候再试");
            }
        }else{
            //添加
            machineService.insert(machine);
            redirectAttributes.addFlashAttribute("successMessage", "保存成功");
            machine = new Machine();
        }

        return "redirect:machineInfo?machineId=" + machine.getUuid();
    }

    /**
     * 删除机器
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteMachine")
    @ResponseBody
    public Map<String, Object> deleteMachine(HttpServletRequest request){
        int deleteFlag = 0;
        String machineId = request.getParameter("machineId");
        if(StringUtils.isNotBlank(machineId)){
            Machine machine = new Machine();
            machine.setUuid(machineId);
            deleteFlag = machineService.delete(machine);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }

    /**
     * 订单详情
     */
    @RequestMapping(value = "/orderDetail",method = RequestMethod.GET)
    public String orderDetail(@RequestParam(required = false,defaultValue = "1") int page,Model model,HttpServletRequest request){
        String orderId = request.getParameter("orderId");
        if(StringUtils.isNotBlank(orderId)){
            Order order = new Order();
            order.setUuid(orderId);
            order = orderService.queryForObjectByPk(order);
            model.addAttribute("order",order);
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            List<Machine> machineList = machineService.queryMachineByOrderId(orderId,pageBounds);
            model.addAttribute("machineList",machineList);

            Logistics logistics = new Logistics();
            logistics.setOrderid(orderId);
            logistics.setOrderby("createon desc");
            List<Logistics> logisticsList = logisticsService.queryForList(logistics);
            model.addAttribute("logisticsList",logisticsList);

            Receipt receipt = new Receipt();
            receipt.setOrderid(orderId);
            List<Receipt> receiptList = receiptService.queryForList(receipt);
            model.addAttribute("receiptList",receiptList);

            Attachment attachment = new Attachment();
            attachment.setRefid(orderId);
            attachment.setOrderby("createon");
            List<Attachment> attachmentList = attachmentService.queryForList(attachment);
            model.addAttribute("attachmentList", attachmentList);
        }
        model.addAttribute("successMessage",request.getParameter("successMessage"));

        //订单删除机器结果
        String deleteFlag = request.getParameter("deleteFlag");
        if("1".equals(deleteFlag)){
            model.addAttribute("successMessage", "删除成功");
        }else if("0".equals(deleteFlag)){
            model.addAttribute("errorMessage", "删除失败");
        }

        //订单发送结果
        String sendFlag = request.getParameter("sendFlag");
        if("1".equals(sendFlag)){
            model.addAttribute("successMessage", "发送成功");
        }else if("0".equals(sendFlag)){
            model.addAttribute("errorMessage", "发送失败");
        }

        //订单发送结果
        String finishFlag = request.getParameter("finishFlag");
        if("1".equals(finishFlag)){
            model.addAttribute("successMessage", "订单已完成");
        }else if("0".equals(finishFlag)){
            model.addAttribute("errorMessage", "操作失败");
        }

        return "admin/wefamily/orderDetail";
    }

    /**
     *订单添加机器
     */
    @RequestMapping(value = "/addMachineForOrder",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> addMachineForOrder(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        Machine machine = new Machine();
        machine.setBindid(UserUtils.getUserBindId());
        machine.setMachinename(request.getParameter("machinenameAdd"));
        machine.setMachinemodel(request.getParameter("machinemodelAdd"));
        machine.setMachineno(request.getParameter("machinenoAdd"));
        machine.setEngineno(request.getParameter("enginenoAdd"));
        machine.setProductiondate(request.getParameter("productiondateAdd"));
        String versionno = request.getParameter("versionno");
        if(StringUtils.isNotBlank(versionno)){
            machine.setVersionno(Integer.valueOf(versionno));
        }

        String orderId = request.getParameter("orderId");

        String machineId = request.getParameter("machineId");
        if(StringUtils.isNotBlank(machineId)){
            machine.setUuid(machineId);
            List<Machine> machineList = machineService.queryMachineForNoRepeat(machine);
            if(null != machineList && machineList.size() > 0){
                resultMap.put("returnMsg","机器号重复！");
            }else{
                machineService.updatePartial(machine);
                resultMap.put("successMessage", "修改成功");
            }
        }else{
            if(StringUtils.isNotBlank(orderId)){
                try {
                    String returnMsg = orderService.addMachineForOrder(orderId,machine);
                    if(StringUtils.isNotBlank(returnMsg)){
                        resultMap.put("returnMsg",returnMsg);
                    }else{
                        resultMap.put("successMessage", "添加成功");
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                    resultMap.put("errorMessage", "系统忙，稍候再试");
                }
            }
        }
        return resultMap;
    }

    /**
     * 订单删除机器
     */
    @RequestMapping("/deleteMachineForOrder")
    @ResponseBody
    public Map<String, Object> deleteMachineForOrder(HttpServletRequest request){
        int deleteFlag = 0;
        String machineId = request.getParameter("machineId");
        if(StringUtils.isNotBlank(machineId)){
            deleteFlag = orderService.deleteMachineForOrder(machineId);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }

    /**
     *订单添加物流
     */
    @RequestMapping(value = "/addLogisticsForOrder",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> addLogisticsForOrder(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        String orderId = request.getParameter("orderId");

        Logistics logistics = new Logistics();
        logistics.setBindid(UserUtils.getUserBindId());
        logistics.setOrderid(orderId);
        logistics.setDriverphone(request.getParameter("driverphoneAdd"));
        logistics.setPlatenumber(request.getParameter("platenumberAdd"));
        logistics.setLocation(request.getParameter("locationAdd"));
        String remarks = request.getParameter("remarksAdd");
        if(StringUtils.isNotBlank(remarks)){
            logistics.setRemarks(remarks);
        }

        try {
            logisticsService.insert(logistics);
            resultMap.put("successMessage", "添加成功");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            resultMap.put("errorMessage", "系统忙，稍候再试");
        }


        return resultMap;
    }

    /**
     *订单添加回执
     */
    @RequestMapping(value = "/addReceiptForOrder",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> addReceiptForOrder(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        String orderId = request.getParameter("orderId");

        Receipt receipt = new Receipt();
        receipt.setOrderid(orderId);
        receipt.setReceiptdt(request.getParameter("receiptdtAdd"));
        receipt.setSatisfaction(request.getParameter("satisfactionAdd"));
        String question = request.getParameter("questionAdd");
        if(StringUtils.isNotBlank(question)){
            receipt.setQuestion(question);
        }
        String[] receiptImg = request.getParameterValues("receiptImg");

        String receiptId = request.getParameter("receiptId");
        try {
            if(StringUtils.isNotBlank(receiptId)){
                receipt.setUuid(receiptId);
                String receiptVersionno = request.getParameter("receiptVersionno");
                receipt.setVersionno(Integer.valueOf(receiptVersionno));
                receiptService.updateReceipt(receipt,receiptImg);
                resultMap.put("successMessage", "修改成功");
            }else{
                receiptService.saveReceipt(receipt,receiptImg);
                resultMap.put("successMessage", "添加成功");
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            resultMap.put("errorMessage", "系统忙，稍候再试");
        }


        return resultMap;
    }

    /**
     * 订单结束
     */
    @RequestMapping("/finishOrder")
    @ResponseBody
    public Map<String, Object> finishOrder(HttpServletRequest request){
        int finishFlag = 0;
        String orderId = request.getParameter("orderId");
        String versionno = request.getParameter("versionno");
        if(StringUtils.isNotBlank(orderId)){
            Order order = new Order();
            order.setUuid(orderId);
            order.setVersionno(Integer.valueOf(versionno));
            finishFlag = orderService. finishOrder(order);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("finishFlag", finishFlag);
        return resultMap;
    }

    /**
     * 咨询管理
     */
    @RequestMapping(value = "/mtxReserveManage")
    public String mtxReserveManage(@RequestParam(required = false, defaultValue = "1") int page, MtxReserve mtxReserve, Model model) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if (null != wechatBinding) {
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<MtxReserve> mtxReserveList = mtxReserveService.queryForListWithPagination(mtxReserve, pageBounds);
            model.addAttribute("mtxReserveList", mtxReserveList);
            model.addAttribute("mtxReserve",mtxReserve);
        }
        return "admin/wefamily/mtxReserveManage";
    }

    /**
     * 留言管理
     */
    @RequestMapping(value = "/mtxConsultManage")
    public String mtxConsultManage(@RequestParam(required = false, defaultValue = "1") int page, MtxConsult mtxConsult, Model model) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if (null != wechatBinding) {
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<MtxConsult> mtxConsultList = mtxConsultService.queryForListWithPagination(mtxConsult, pageBounds);
            model.addAttribute("mtxConsultList", mtxConsultList);
            model.addAttribute("mtxConsult",mtxConsult);
        }
        return "admin/wefamily/mtxConsultManage";
    }

    @RequestMapping(value = "/goMtxConsultDetail")
    public String goMtxConsultDetail(MtxConsultDetail mtxConsultDetail, Model model,String uuid,HttpServletRequest request) {
        if(StringUtils.isNotBlank(uuid)){
            mtxConsultDetail.setConsultid(uuid);
            model.addAttribute("uuid",uuid);
        }
        List<MtxConsultDetail> mtxConsultDetailList = mtxConsultDetailService.queryForListWithPagination(mtxConsultDetail);
        model.addAttribute("mtxConsultDetailList", mtxConsultDetailList);
        String successMsg=request.getParameter("successMsg");
        if(StringUtils.isNotBlank(successMsg)&&"1".equals(successMsg)){
            model.addAttribute("successMessage","回复成功！");
        }
        if(StringUtils.isNotBlank(successMsg)&&"0".equals(successMsg)){
            model.addAttribute("errorMessage","回复失败！");
        }
        return "admin/wefamily/mtxConsultDetailManage";
    }


    @RequestMapping(value = "/answer")
    public String answer(MtxConsultDetail mtxConsultDetail) {
        String flag=mtxConsultService.answerQuestion(mtxConsultDetail);
        String successMsg=null;
        if("Y".equals(flag)){
            successMsg="1";
        }else{
            successMsg="0";
        }
        return "redirect:goMtxConsultDetail?uuid="+mtxConsultDetail.getConsultid()+"&successMsg="+successMsg;
    }

    /**
     * 会员管理
     */
    @RequestMapping(value = "/mtxWpUserManage")
    public String mtxWpUserManage(@RequestParam(required = false, defaultValue = "1") int page, WpUser wpUser, Model model, HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if (null != wechatBinding) {
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<WpUser> wpUserList = wpUserService.queryForListWithPagination(wpUser, pageBounds);
            model.addAttribute("wpUserList", wpUserList);
            model.addAttribute("wpUser",wpUser);
        }
        String successFlag=request.getParameter("deleteFlag");
        if("1".equals(successFlag)){
            model.addAttribute("successFlag","删除成功");
        }
        return "admin/wefamily/mtxWpUserManage";
    }

    @RequestMapping(value = "/goWpUser", method = RequestMethod.GET)
    public String goWpUser(Model model,WpUser wpUser){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        WpUser wpUserTemp=wpUserService.queryForObjectByPk(wpUser);
        model.addAttribute("wpUser",wpUserTemp);
        return "admin/wefamily/wpUserInfo";
    }

    @RequestMapping(value = "/updateWpUser",method = RequestMethod.POST)
    public String updateWpUser(@RequestParam(value = "imgfile", required = false)MultipartFile multipartFile, WpUser wpUser, RedirectAttributes redirectAttributes, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != multipartFile && !multipartFile.isEmpty()){
            String foldername = "member";
            String filename = UploadUtils.uploadFile(multipartFile, foldername);
            wpUser.setHeadimgurl(filename);
        }
        if (StringUtils.isNotBlank(wpUser.getUuid())) {
            try {
                wpUserService.updatePartial(wpUser);
                WpUser wpUserTemp = wpUserService.queryForObjectByPk(wpUser);
                model.addAttribute("wpUser", wpUserTemp);
            } catch (ServiceException e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "数据已修改，请重试！");
                return "redirect:/admin/wefamily/goWpUser?uuid=" + wpUser.getUuid();

            }
            model.addAttribute("successMessage", "保存成功！");
        }
        return "admin/wefamily/wpUserInfo";
    }

    @RequestMapping(value = "/deleteWpUser", method = RequestMethod.POST)
    @ResponseBody
    public Map deleteWpUser(WpUser wpUser){
        int deleteFlag=wpUserService.delete(wpUser);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }

    /**
     * 商品兑换管理
     */
    @RequestMapping(value = "/mtxGoodManage")
    public String mtxGoodManage(@RequestParam(required = false, defaultValue = "1") int page, MtxProduct mtxProduct, Model model, HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String flag="0";
        if (null != wechatBinding) {
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<MtxProduct> mtxProductList = mxtProductService.queryForListWithPagination(mtxProduct, pageBounds,flag);
            model.addAttribute("mtxProductList", mtxProductList);
            model.addAttribute("mtxProduct",mtxProduct);
        }
        String successFlag=request.getParameter("deleteFlag");
        if("1".equals(successFlag)){
            model.addAttribute("successFlag","删除成功");
        }
        return "admin/wefamily/mtxGoodManage";
    }

    @RequestMapping(value = "/goMtxGood", method = RequestMethod.GET)
    public String goMtxGood(Model model,MtxProduct mtxProduct){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        MtxProduct mtxProductTemp=mxtProductService.queryForObjectByPk(mtxProduct);
        model.addAttribute("mtxProduct",mtxProductTemp);
        return "admin/wefamily/mtxGoodInfo";
    }

    @RequestMapping(value = "/updateMtxGood",method = RequestMethod.POST)
    public String updateMtxGood(@RequestParam(value = "imgfile", required = false)MultipartFile multipartFile, MtxProduct mtxProduct, RedirectAttributes redirectAttributes, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if(null != multipartFile && !multipartFile.isEmpty()){
            String foldername = "product";
            String filename = UploadUtils.uploadFile(multipartFile, foldername);
            mtxProduct.setImg(filename);
        }
        if (StringUtils.isBlank(mtxProduct.getUuid())) {
            mtxProduct.setType("EXCHANGE_GOOD");
            mxtProductService.insert(mtxProduct);
            model.addAttribute("mtxProduct", mtxProduct);
            model.addAttribute("successMessage", "保存成功！");
        } else {
            try {
                mxtProductService.updatePartial(mtxProduct);
                MtxProduct mtxProductTemp = mxtProductService.queryForObjectByPk(mtxProduct);
                model.addAttribute("mtxProduct", mtxProductTemp);
            } catch (ServiceException e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "数据已修改，请重试！");
                return "redirect:/admin/wefamily/goMtxGood?uuid=" + mtxProduct.getUuid();

            }
            model.addAttribute("successMessage", "保存成功！");
        }
        return "admin/wefamily/mtxGoodInfo";
    }
    @RequestMapping(value = "/deleteMtxGood", method = RequestMethod.POST)
    @ResponseBody
    public Map deleteMtxGood(MtxProduct mtxProduct){
        int deleteFlag=mxtProductService.delete(mtxProduct);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }

    /**
     * 积分管理
     */
    @RequestMapping(value = "/mtxPointManage")
    public String mtxPointManage(@RequestParam(required = false, defaultValue = "1") int page, MtxPoint mtxPoint, Model model, HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if (null != wechatBinding) {
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<MtxPoint> mtxPointList = mtxPointService.queryForListWithPagination(mtxPoint, pageBounds);
            model.addAttribute("mtxPointList", mtxPointList);
            model.addAttribute("mtxPoint",mtxPoint);
        }
        return "admin/wefamily/mtxPointManage";
    }

    /**
     * 验证产品型号是否存在
     */

    @RequestMapping(value = "/validModelIsExist", method = RequestMethod.POST)
    @ResponseBody
    public Boolean validModelIsExist(String model,String uuid){
        List<MtxProduct> productList=new ArrayList<MtxProduct>();
        if(StringUtils.isNotBlank(model)){
            productList=mxtProductService.validModelIsExist(model,uuid);
        }
        if(productList.size()>0){
            return false;
        }else{
            return true;
        }
    }

    /**
     * 验证物料编码是否存在
     */
    @RequestMapping(value = "/ifMaterialCodeExist", method = RequestMethod.POST)
    @ResponseBody
    public Boolean ifMaterialCodeExist(String code,String uuid){
        List<Machine> machineList=new ArrayList<Machine>();
        Machine machineTemp=new Machine();
        machineTemp.setBindid(UserUtils.getUserBindId());
        if(StringUtils.isNotBlank(uuid)){
            machineTemp.setUuid(uuid);
        }
        if(StringUtils.isNotBlank(code)){
            machineTemp.setMachineno(code);
            machineList=machineService.queryMachineForNoRepeat(machineTemp);
        }
        if(machineList.size()>0){
            return false;
        }else{
            return true;
        }
    }

    /**
     *培训管理
     */
    @RequestMapping(value = "/trainManage",method = RequestMethod.GET)
    public String trainManage(Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        model.addAttribute("successMessage",request.getParameter("successMessage"));
        return "admin/wefamily/trainManage";
    }

    /**
     * 培训管理
     * @param train
     * @param model
     * @return
     */
    @RequestMapping(value = "/trainManage",method = RequestMethod.POST)
    public String trainManage(@RequestParam(required = false,defaultValue = "1") int page,Train train,Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        model.addAttribute("train",train);
        if(null != wechatBinding){
            String startDateStr = request.getParameter("startDateStr");
            model.addAttribute("startDateStr", startDateStr);
            String endDateStr = request.getParameter("endDateStr");
            model.addAttribute("endDateStr", endDateStr);
            Date startDate = DateUtils.parseDate(startDateStr);
            Date endDate = DateUtils.parseDate(endDateStr);
            startDate = DateUtils.getDateStart(startDate);
            endDate = DateUtils.getDateEnd(endDate);
            String startDateTimeStr = "";
            if(null != startDate){
                startDateTimeStr = DateUtils.formatDate(startDate, "yyyy-MM-dd HH:mm:ss");
            }
            String endDateTimeStr = "";
            if(null != endDate){
                endDateTimeStr = DateUtils.formatDate(endDate, "yyyy-MM-dd HH:mm:ss");
            }
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<Train> trainList = trainService.queryTrainList(train, startDateTimeStr, endDateTimeStr, pageBounds);
            model.addAttribute("trainList", trainList);

            //删除结果
            String deleteFlag = request.getParameter("deleteFlag");
            if("1".equals(deleteFlag)){
                model.addAttribute("successMessage", "删除成功");
            }else if("0".equals(deleteFlag)){
                model.addAttribute("errorMessage", "删除失败");
            }
        }

        return "admin/wefamily/trainManage";
    }

    /**
     * 培训信息（界面）
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/trainInfo",method = RequestMethod.GET)
    public String trainInfo(HttpServletRequest request,Model model){

        List<CommonCode> programCodeList = commonCodeService.queryCodeList("TRAIN_PROGRAM");
        model.addAttribute("programCodeList",programCodeList);

        String trainId = request.getParameter("trainId");
        if(StringUtils.isNotBlank(trainId)){
            Train train = new Train();
            train.setUuid(trainId);
            train = trainService.queryForObjectByPk(train);
            model.addAttribute("train", train);

            if(null != train){

                if(StringUtils.isNotBlank(train.getProgram())){
                    String[] trainPrograms= train.getProgram().split(",");
                    if(null != trainPrograms){
                        List<String> trainProgramList = new ArrayList<>();
                        for(String program : trainPrograms){
                            trainProgramList.add(program);
                        }
                        model.addAttribute("trainProgramList",trainProgramList);
                    }
                }
            }


            Attachment attachment = new Attachment();
            attachment.setRefid(trainId);
            List<Attachment> attachmentList = attachmentService.queryForList(attachment);
            model.addAttribute("attachmentList",attachmentList);
        }

        //培训结果
        String finishFlag = request.getParameter("finishFlag");
        if("1".equals(finishFlag)){
            model.addAttribute("successMessage", "培训已完成");
        }else if("0".equals(finishFlag)){
            model.addAttribute("errorMessage", "操作失败");
        }
        return "admin/wefamily/trainInfo";
    }

    /**
     * 培训信息
     * @param train
     * @param redirectAttributes
     * @param model
     * @return
     */
    @RequestMapping(value = "/trainInfo",method = RequestMethod.POST)
    public String trainInfo(Train train, RedirectAttributes redirectAttributes, Model model,HttpServletRequest request){

        //培训项目
        String trainProgramStr = "";
        String[] trainPrograms = request.getParameterValues("programs");
        if(null != trainPrograms){
            for(String program : trainPrograms){
                trainProgramStr += program + ",";
            }
            if(StringUtils.isNotBlank(trainProgramStr)){
                train.setProgram(trainProgramStr);
            }
        }

        String[] trainImgs = request.getParameterValues("trainImg");

        //修改
        if(StringUtils.isNotBlank(train.getUuid())){
            try {
                trainService.updateTrain(train,trainImgs);
                redirectAttributes.addFlashAttribute("successMessage", "保存成功");
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "系统忙，稍候再试");
            }
        }else{
            trainService.saveTrain(train,trainImgs);
            redirectAttributes.addFlashAttribute("successMessage", "保存成功");
        }

        return "redirect:trainInfo?trainId=" + train.getUuid();
    }

    //自动查询机器列表
    @RequestMapping(value = "/queryMachineList")
    @ResponseBody
    public Map<String, Object> queryMachineList(HttpServletRequest request){
        String machineno = request.getParameter("machineno");
        if(StringUtils.isNotBlank(machineno)){
            if(machineno.indexOf("%") > -1){
                machineno = machineno.replace("%","\\%");
            }
            if(machineno.indexOf("_") > -1){
                machineno = machineno.replace("_","\\_");
            }
        }

        List<Machine> autoQueryMachineList = machineService.queryMachineListForAuto(machineno);


        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("autoQueryMachineList", autoQueryMachineList);
        return resultMap;
    }

    /**
     * 根据id查询机器
     * @param request
     * @return
     */
    @RequestMapping(value = "/queryMachineById", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> queryMachineById(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String machineId = request.getParameter("machineId");
        Machine machine = new Machine();
        machine.setUuid(machineId);
        machine = machineService.queryForObjectByPk(machine);
        resultMap.put("machine", machine);
        return resultMap;
    }

    /**
     * 培训结束
     */
    @RequestMapping("/finishTrain")
    @ResponseBody
    public Map<String, Object> finishTrain(HttpServletRequest request){
        int finishFlag = 0;
        String trainId = request.getParameter("trainId");
        String versionno = request.getParameter("versionno");
        if(StringUtils.isNotBlank(trainId)){
            Train train = new Train();
            train.setUuid(trainId);
            train.setVersionno(Integer.valueOf(versionno));
            finishFlag = trainService. finishTrain(train);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("finishFlag", finishFlag);
        return resultMap;
    }

    /**
     * 删除培训
     * @param request
     * @return
     */
    @RequestMapping("/deleteTrain")
    @ResponseBody
    public Map<String, Object> deleteTrain(HttpServletRequest request){
        int deleteFlag = 0;
        String trainId = request.getParameter("trainId");
        if(StringUtils.isNotBlank(trainId)){
            Train train = new Train();
            train.setUuid(trainId);
            deleteFlag = trainService.delete(train);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }

    /**
     * 培训列表
     * @param model
     * @return
     */
    @RequestMapping(value = "/trainManageForPhone")
    public String trainManageForPhone(Model model) {
        Train train = new Train();
        train.setCreateby(UserUtils.getUserId());
        List<Train> trainList = trainService.queryTrainListForPhone(train);
        model.addAttribute("trainList",trainList);
        return "admin/wefamily/trainManageForPhone";
    }

    @RequestMapping(value = "/trainInfoForPhone",method = RequestMethod.GET)
    public String trainInfoForPhone(Model model,HttpServletRequest request){
        String trainId= request.getParameter("trainId");
        if(StringUtils.isNotBlank(trainId)){
            Train train = new Train();
            train.setUuid(trainId);
            train = trainService.queryForObjectByPk(train);
            model.addAttribute("train", train);

            if(null != train){

                if(StringUtils.isNotBlank(train.getProgram())){
                    String[] trainPrograms= train.getProgram().split(",");
                    if(null != trainPrograms){
                        List<String> trainProgramList = new ArrayList<>();
                        for(String program : trainPrograms){
                            trainProgramList.add(program);
                        }
                        model.addAttribute("trainProgramList",trainProgramList);
                    }
                }
            }

            Attachment attachment = new Attachment();
            attachment.setRefid(trainId);
            List<Attachment> attachmentList = attachmentService.queryForList(attachment);
            model.addAttribute("attachmentList",attachmentList);

            //培训完成结果
            String finishFlag = request.getParameter("finishFlag");
            if("1".equals(finishFlag)){
                model.addAttribute("successMessage", "培训已完成");
            }else if("0".equals(finishFlag)){
                model.addAttribute("errorMessage", "操作失败");
            }
        }

        return "admin/wefamily/trainInfoForPhone";
    }

    @RequestMapping(value = "/trainInfoForPhone",method = RequestMethod.POST)
    public String trainInfoForPhone(Model model,HttpServletRequest request,Train train, RedirectAttributes redirectAttributes){
        //培训项目
        String trainProgramStr = "";
        String[] trainPrograms = request.getParameterValues("trainPrograms");
        if(null != trainPrograms){
            for(String program : trainPrograms){
                trainProgramStr += program + ",";
            }
            if(StringUtils.isNotBlank(trainProgramStr)){
                train.setProgram(trainProgramStr);
            }
        }

        String[] trainImgs = request.getParameterValues("trainImg");

        //修改
        if(StringUtils.isNotBlank(train.getUuid())){
            try {
                trainService.updateTrain(train,trainImgs);
                redirectAttributes.addFlashAttribute("successMessage", "保存成功");
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "系统忙，稍候再试");
            }
        }else{
            trainService.saveTrain(train,trainImgs);
            redirectAttributes.addFlashAttribute("successMessage", "保存成功");
        }

        return "redirect:trainInfoForPhone?trainId=" + train.getUuid();
    }

    /**
     * 视频管理
     */
    @RequestMapping(value = "/mtxVideoManage")
    public String mtxVideoManage(@RequestParam(required = false, defaultValue = "1") int page, MtxVideo mtxVideo, Model model, HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if (null != wechatBinding) {
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<MtxVideo> mtxVideoList = mtxVideoService.queryForListWithPagination(mtxVideo, pageBounds);
            model.addAttribute("mtxVideoList", mtxVideoList);
            model.addAttribute("mtxVideo",mtxVideo);
        }
        String successFlag=request.getParameter("deleteFlag");
        if("1".equals(successFlag)){
            model.addAttribute("successFlag","删除成功");
        }
        return "admin/wefamily/mtxVideoManage";
    }

    /**
     * 报修管理
     */
    @RequestMapping(value = "/repairManage",method = RequestMethod.GET)
    public String repairManage(Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        return "admin/wefamily/repairManage";
    }

    /**
     * 报修管理
     * @param repair
     * @param model
     * @return
     */
    @RequestMapping(value = "/repairManage",method = RequestMethod.POST)
    public String repairManage(@RequestParam(required = false,defaultValue = "1") int page,Repair repair,Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        model.addAttribute("train",repair);
        if(null != wechatBinding){
            String startDateStr = request.getParameter("startDateStr");
            model.addAttribute("startDateStr", startDateStr);
            String endDateStr = request.getParameter("endDateStr");
            model.addAttribute("endDateStr", endDateStr);
            Date startDate = DateUtils.parseDate(startDateStr);
            Date endDate = DateUtils.parseDate(endDateStr);
            startDate = DateUtils.getDateStart(startDate);
            endDate = DateUtils.getDateEnd(endDate);
            String startDateTimeStr = "";
            if(null != startDate){
                startDateTimeStr = DateUtils.formatDate(startDate, "yyyy-MM-dd HH:mm:ss");
            }
            String endDateTimeStr = "";
            if(null != endDate){
                endDateTimeStr = DateUtils.formatDate(endDate, "yyyy-MM-dd HH:mm:ss");
            }
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<Repair> repairList = repairService.queryRepairList(repair, startDateTimeStr, endDateTimeStr, pageBounds);
            model.addAttribute("repairList", repairList);

            //删除结果
            String deleteFlag = request.getParameter("deleteFlag");
            if("1".equals(deleteFlag)){
                model.addAttribute("successMessage", "删除成功");
            }else if("0".equals(deleteFlag)){
                model.addAttribute("errorMessage", "删除失败");
            }
        }

        return "admin/wefamily/repairManage";
    }

    /**
     * 报修信息
     */
    @RequestMapping(value = "/repairInfo",method = RequestMethod.GET)
    public String repairInfo(HttpServletRequest request,Model model){

        String repairId= request.getParameter("repairId");
        if(StringUtils.isNotBlank(repairId)){
            Repair repair = new Repair();
            repair.setUuid(repairId);
            repair = repairService.queryForObjectByPk(repair);
            model.addAttribute("repair",repair);

            if(StringUtils.isNotBlank(repair.getMerchantid())){
                Merchant merchant = new Merchant();
                merchant.setUuid(repair.getMerchantid());
                merchant = merchantService.queryForObjectByPk(merchant);
                model.addAttribute("merchant",merchant);

                List<PlatformUser> repairWorkerList = platformUserService.queryWorkersByMerchantId(merchant.getUuid());
                model.addAttribute("repairWorkerList",repairWorkerList);
            }else{
                Machine machine = new Machine();
                machine.setMachinemodel(repair.getMachinemodel());
                machine.setMachineno(repair.getMachineno());
                machine.setEngineno(repair.getEngineno());
                Merchant merchant = merchantService.queryMerchantByMachineInfo(machine);
                model.addAttribute("merchant",merchant);
            }

            Attachment reporterAttachment = new Attachment();
            reporterAttachment.setRefid(repairId);
            reporterAttachment.setType("reporter");
            List<Attachment> reporterAttachmentList = attachmentService.queryForList(reporterAttachment);
            model.addAttribute("reporterAttachmentList",reporterAttachmentList);

            Attachment workerAttachment = new Attachment();
            workerAttachment.setRefid(repairId);
            workerAttachment.setType("worker");
            List<Attachment> workerAttachmentList = attachmentService.queryForList(workerAttachment);
            model.addAttribute("workerAttachmentList",workerAttachmentList);

        }

        model.addAttribute("successMessage",request.getParameter("successMessage"));

        //分配报修结果
        String distributeFlag = request.getParameter("distributeFlag");
        if("1".equals(distributeFlag)){
            model.addAttribute("successMessage", "分配成功");
        }else if("0".equals(distributeFlag)){
            model.addAttribute("errorMessage", "分配失败");
        }

        //维修完成结果
        String finishFlag = request.getParameter("finishFlag");
        if("1".equals(finishFlag)){
            model.addAttribute("successMessage", "维修已完成");
        }else if("0".equals(finishFlag)){
            model.addAttribute("errorMessage", "操作失败");
        }

        return "admin/wefamily/repairInfo";
    }

    /**
     *报修保存机器信息
     */
    @RequestMapping(value = "/saveReportRepairInfo",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> saveReportRepairInfo(Repair repair,HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        String returnMsg = repairService.saveReportRepairInfo(repair);
        if(StringUtils.isNotBlank(returnMsg)){
            resultMap.put("returnMsg",returnMsg);
        }else{
            resultMap.put("successMessage", "保存成功");
            resultMap.put("repairId",repair.getUuid());
        }
        return resultMap;
    }

    /**
     * 分配报修
     */
    @RequestMapping("/distributeRepair")
    @ResponseBody
    public Map<String, Object> distributeRepair(HttpServletRequest request){
        int distributeFlag = 0;
        String repairId = request.getParameter("repairId");
        String merchantId = request.getParameter("merchantId");
        String versionno = request.getParameter("versionno");
        if(StringUtils.isNotBlank(repairId)){
            Repair repair = new Repair();
            repair.setUuid(repairId);
            repair.setMerchantid(merchantId);
            repair.setVersionno(Integer.valueOf(versionno));
            distributeFlag = repairService.distributeRepair(repair);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("distributeFlag", distributeFlag);
        return resultMap;
    }

    /**
     * 开始维修
     */
    @RequestMapping("/startRepair")
    @ResponseBody
    public Map<String, Object> startRepair(HttpServletRequest request){
        int startFlag = 0;
        String repairId = request.getParameter("repairId");
        String versionno = request.getParameter("versionno");
        if(StringUtils.isNotBlank(repairId)){
            Repair repair = new Repair();
            repair.setUuid(repairId);
            repair.setVersionno(Integer.valueOf(versionno));
            startFlag = repairService.startRepair(repair);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("startFlag", startFlag);
        return resultMap;
    }

    /**
     *保存维修信息
     */
    @RequestMapping(value = "/saveRepairInfo",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> saveRepairInfo(Repair repair,HttpServletRequest request,Model model){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        String repairId = request.getParameter("repairId");
        String versionno = request.getParameter("versionno");
        repair.setUuid(repairId);
        repair.setVersionno(Integer.valueOf(versionno));

        String workerId = request.getParameter("workerId");
        PlatformUser workerUser = platformUserService.getPlatformUserById(workerId);
        model.addAttribute("workerUser",workerUser);

        RepairWorker repairWorker = new RepairWorker();
        repairWorker.setRepairid(repairId);
        repairWorker.setUserid(workerUser.getUuid());

        List<RepairWorker> repairWorkerList = repairWorkerService.queryForList(repairWorker);
        if(null != repairWorkerList && repairWorkerList.size() > 0){
            repairWorker = repairWorkerList.get(0);
        }

        repairWorker.setName(workerUser.getName());
        repairWorker.setPhone(workerUser.getCellphone());


        String[] repairImgs = request.getParameterValues("repairImg");

        repairService.saveRepairInfo(repair,repairWorker,repairImgs);

        String saveType = request.getParameter("saveType");
        if("FINISH".equals(saveType)){
            Repair tempRepair = new Repair();
            tempRepair.setUuid(repairId);
            tempRepair = repairService.queryForObjectByPk(tempRepair);
            repairService.finishRepair(tempRepair);
        }
        resultMap.put("successMessage", "保存成功");
        return resultMap;
    }

    /**
     * 维修结束
     */
    @RequestMapping("/finishRepair")
    @ResponseBody
    public Map<String, Object> finishRepair(HttpServletRequest request){
        int finishFlag = 0;
        String repairId = request.getParameter("repairId");
        String versionno = request.getParameter("versionno");
        if(StringUtils.isNotBlank(repairId)){
            Repair repair = new Repair();
            repair.setUuid(repairId);
            repair.setVersionno(Integer.valueOf(versionno));
            finishFlag = repairService.finishRepair(repair);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("finishFlag", finishFlag);
        return resultMap;
    }

    /**
     * 维修列表
     * @param model
     * @return
     */
    @RequestMapping(value = "/repairManageForPhone")
    public String repairManageForPhone(Model model) {
        Repair repair = new Repair();
        List<Repair> repairList = repairService.queryRepairListForPhone(repair);
        model.addAttribute("repairList",repairList);
        return "admin/wefamily/repairManageForPhone";
    }

    @RequestMapping(value = "/repairInfoForPhone",method = RequestMethod.GET)
    public String repairInfoForPhone(Model model,HttpServletRequest request){
        String repairId= request.getParameter("repairId");
        if(StringUtils.isNotBlank(repairId)){
            Repair repair = new Repair();
            repair.setUuid(repairId);
            repair = repairService.queryForObjectByPk(repair);
            model.addAttribute("repair", repair);

            if(StringUtils.isNotBlank(repair.getMerchantid())){
                Merchant merchant = new Merchant();
                merchant.setUuid(repair.getMerchantid());
                merchant = merchantService.queryForObjectByPk(merchant);
                model.addAttribute("merchant",merchant);
            }

            Attachment reporterAttachment = new Attachment();
            reporterAttachment.setRefid(repairId);
            reporterAttachment.setType("reporter");
            List<Attachment> reporterAttachmentList = attachmentService.queryForList(reporterAttachment);
            model.addAttribute("reporterAttachmentList",reporterAttachmentList);

            Attachment workerAttachment = new Attachment();
            workerAttachment.setRefid(repairId);
            workerAttachment.setType("worker");
            List<Attachment> workerAttachmentList = attachmentService.queryForList(workerAttachment);
            model.addAttribute("workerAttachmentList",workerAttachmentList);

            RepairWorker repairWorker = new RepairWorker();
            repairWorker.setRepairid(repairId);
            List<RepairWorker> repairWorkerList = repairWorkerService.queryForList(repairWorker);
            model.addAttribute("repairWorkerList",repairWorkerList);
        }


        return "admin/wefamily/repairInfoForPhone";
    }

    @RequestMapping(value = "/repairInfoForPhone",method = RequestMethod.POST)
    public String repairInfoForPhone(Model model,HttpServletRequest request,Repair repair,RepairWorker repairWorker, RedirectAttributes redirectAttributes){

        String repairWorkerId = request.getParameter("repairworkerid");
        String repairWorkerVersionno = request.getParameter("repairworkerversionno");

        if(StringUtils.isNotBlank(repairWorkerId)){
            repairWorker.setUuid(repairWorkerId);
            repairWorker.setVersionno(Integer.valueOf(repairWorkerVersionno));
        }


        String[] repairImgs = request.getParameterValues("repairImg");

        //修改
        if(StringUtils.isNotBlank(repair.getUuid())){
            try {
                repairService.saveRepairInfo(repair,repairWorker,repairImgs);
                redirectAttributes.addFlashAttribute("successMessage", "保存成功");
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "系统忙，稍候再试");
            }
        }

        return "redirect:repairInfoForPhone?repairId=" + repair.getUuid();
    }

    @RequestMapping(value = "/goMtxVideo", method = RequestMethod.GET)
    public String goMtxVideo(Model model,MtxVideo mtxVideo){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        MtxVideo mtxVideoTemp=mtxVideoService.queryForObjectByPk(mtxVideo);
        model.addAttribute("mtxVideo",mtxVideoTemp);
        return "admin/wefamily/mtxVideoInfo";
    }

    @RequestMapping(value = "/updateMtxVideo",method = RequestMethod.POST)
    public String updateMtxVideo(MtxVideo mtxVideo, RedirectAttributes redirectAttributes, Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if (StringUtils.isBlank(mtxVideo.getUuid())) {
            mtxVideoService.insert(mtxVideo);
            model.addAttribute("mtxVideo", mtxVideo);
            model.addAttribute("successMessage", "保存成功！");
        } else {
            try {
                mtxVideoService.updatePartial(mtxVideo);
                MtxVideo mtxVideoTemp = mtxVideoService.queryForObjectByPk(mtxVideo);
                model.addAttribute("mtxVideo", mtxVideoTemp);
            } catch (ServiceException e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "数据已修改，请重试！");
                return "redirect:/admin/wefamily/goMtxVideo?uuid=" + mtxVideo.getUuid();

            }
            model.addAttribute("successMessage", "保存成功！");
        }
        return "admin/wefamily/mtxVideoInfo";
    }

    @RequestMapping(value = "/deleteMtxVideo", method = RequestMethod.POST)
    @ResponseBody
    public Map deleteMtxVideo(MtxVideo mtxVideo){
        int deleteFlag=mtxVideoService.delete(mtxVideo);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }
    public List<Attachment> getAttachmentByRefid(String refid){
        Attachment attachment=new Attachment();
        List<Attachment> attachmentList=new ArrayList<Attachment>();
        if(StringUtils.isNotBlank(refid)){
            attachment.setRefid(refid);
            attachmentList = attachmentService.queryForList(attachment);
        }
        return attachmentList;
    }

    /**
     * 配件管理
     */
    @RequestMapping(value = "/mtxPartsCenterManage")
    public String mtxPartsCenterManage(@RequestParam(required = false, defaultValue = "1") int page, Machine machine, Model model, HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if (null != wechatBinding) {
            machine.setType("PARTS");
            machine.setBindid(UserUtils.getUserBindId());
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<Machine> machineList = machineService.queryForListWithPagination(machine, pageBounds);
            model.addAttribute("machineList", machineList);
            model.addAttribute("machine",machine);
        }
        String successFlag=request.getParameter("deleteFlag");
        if("1".equals(successFlag)){
            model.addAttribute("successFlag","删除成功");
        }
        return "admin/wefamily/mtxPartsCenterManage";
    }

    @RequestMapping(value = "/goMtxPartsCenter", method = RequestMethod.GET)
    public String goMtxPartsCenter(Model model,Machine machine){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        Machine machineTemp=machineService.queryForObjectByPk(machine);
        model.addAttribute("machine",machineTemp);
        List<Attachment> attachmentList=new ArrayList<Attachment>();
        if(StringUtils.isNotBlank(machine.getUuid())){
            attachmentList=getAttachmentByRefid(machine.getUuid());
        }
        model.addAttribute("attachmentList",attachmentList);
        return "admin/wefamily/mtxPartsCenterInfo";
    }

    @RequestMapping(value = "/updateMtxPartsCenter",method = RequestMethod.POST)
    public String updateMtxPartsCenter(Machine machine, RedirectAttributes redirectAttributes, Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String[] detailImgs = request.getParameterValues("detailImg");
        if (StringUtils.isBlank(machine.getUuid())) {
            machine.setBindid(UserUtils.getUserBindId());
            machine.setType("PARTS");
            machineService.insert(machine);
            model.addAttribute("machine", machine);
            if(detailImgs!=null&&detailImgs.length>0){
                for(int i=0;i<detailImgs.length;i++){
                    Attachment attachment=new Attachment();
                    attachment.setRefid(machine.getUuid());
                    attachment.setName(detailImgs[i]);
                    attachmentService.insert(attachment);
                }
            }
            List<Attachment> attachmentList=new ArrayList<Attachment>();
            attachmentList=getAttachmentByRefid(machine.getUuid());
            model.addAttribute("attachmentList",attachmentList);
            model.addAttribute("successMessage", "保存成功！");
        } else {
            try {
                machineService.updatePartial(machine);
                Machine machineTemp = machineService.queryForObjectByPk(machine);
                model.addAttribute("machine", machineTemp);
                if(detailImgs!=null&&detailImgs.length>0){
                    for(int i=0;i<detailImgs.length;i++){
                        Attachment attachment=new Attachment();
                        attachment.setRefid(machine.getUuid());
                        attachment.setName(detailImgs[i]);
                        attachmentService.insert(attachment);
                    }
                }
                List<Attachment> attachmentList=new ArrayList<Attachment>();
                attachmentList=getAttachmentByRefid(machineTemp.getUuid());
                model.addAttribute("attachmentList",attachmentList);
            } catch (ServiceException e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "数据已修改，请重试！");
                return "redirect:/admin/wefamily/goMtxPartsCenter?uuid=" + machine.getUuid();

            }
            model.addAttribute("successMessage", "保存成功！");
        }
        return "admin/wefamily/mtxPartsCenterInfo";
    }

    @RequestMapping(value = "/deleteMtxPartsCenter", method = RequestMethod.POST)
    @ResponseBody
    public Map deleteMtxPartsCenter(Machine machine){
        int deleteFlag=machineService.delete(machine);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }
}