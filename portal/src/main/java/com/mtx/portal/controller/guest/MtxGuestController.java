package com.mtx.portal.controller.guest;

import com.mtx.common.entity.Attachment;
import com.mtx.common.service.AttachmentService;
import com.mtx.common.service.SequenceService;
import com.mtx.common.utils.*;
import com.mtx.family.entity.*;
import com.mtx.family.service.*;
import com.mtx.wechat.entity.WechatUserInfo;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.service.WechatBindingService;
import com.mtx.wechat.service.WechatUserInfoService;
import com.mtx.wechat.service.WpUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/guest")
public class MtxGuestController extends BaseGuestController{
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
    @Autowired
    private WechatUserInfoService wechatUserInfoService;
    @Autowired
    private MtxPointService mtxPointService;
    @Autowired
    private WpUserService wpUserService;
    @Autowired
    private MtxUserMachineService mtxUserMachineService;
    @Autowired
    private MachineService machineService;
    @Autowired
    private MtxVideoService mtxVideoService;
    @Autowired
    private QualityMgmtService qualityMgmtService;
    @Autowired
    private SequenceService sequenceService;
    @Autowired
    private AttachmentService attachmentService;
    @Autowired
    private MerchantService merchantService;
    @Autowired
    private WorkerService workerService;
    @Autowired
    private MtxExchangeRecordService mtxExchangeRecordService;


    @RequestMapping(value = "/product_center")
    public String product_center(Model model) {
        MtxProduct mtxProduct = new MtxProduct();
        mtxProduct.setStatus("ON_SALE");
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

    @RequestMapping(value = "/message",method = RequestMethod.GET)
    public String enquiry(MtxConsultDetail mtxConsultDetail, String userid, Model model, HttpServletRequest request) {
        if(StringUtils.isBlank(userid)){
            WpUser user=getWechatMemberInfo(request);
            userid=user.getUuid();
        }
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
     * 注册
     */
    @RequestMapping(value = "/register",method = RequestMethod.GET)
    public String register() {
        return "guest/register";
    }

    @RequestMapping(value = "/register",method = RequestMethod.POST)
    public String addRegister(WpUser wpUser, String machineno,HttpServletRequest req,Model model) {
        WpUser userTemp=getWechatMemberInfo(req);
        if(StringUtils.isNotBlank(userTemp.getIfauth())&&"Y".equals(userTemp.getIfauth())){
            model.addAttribute("ErrorMessage","您已是会员，无需重复注册！");
            return "guest/register";
        }else{
            Machine machine=new Machine();
            if(StringUtils.isNotBlank(machineno)){
                machine.setMachineno(machineno);
                machine=machineService.queryForObjectByUniqueKey(machine);
                if(machine!=null){
                    mtxMemberService.insertMemberAndPoint(wpUser,userTemp,machine);
                }else{
                    model.addAttribute("ErrorMessage","机器号有误！该机器不存在！");
                    return "guest/register";
                }
            }
        }
        return "redirect:/guest/product_center";
    }

    /**
     * 会员中心
     * @return
     */
    @RequestMapping(value = "/member/center",method = RequestMethod.GET)
    public String member_center(String userid,Model model,HttpServletRequest req) {
        if(StringUtils.isBlank(userid)){
            WpUser user =new WpUser();
            user=getWechatMemberInfo(req);
            if(user!=null){
                userid=user.getUuid();
            }
        }
        if(StringUtils.isNotBlank(userid)){
            WpUser user =new WpUser();
            user.setUuid(userid);
            user=wpUserService.queryForObjectByPk(user);
            model.addAttribute("user",user);
        }
        model.addAttribute("userid",userid);
        return "guest/member_center";
    }

    /**
     * 积分列表
     * @return
     */
    @RequestMapping(value = "/member/point_list",method = RequestMethod.GET)
    public String point_list(String userid,Model model) {
        if(StringUtils.isNotBlank(userid)){
            WpUser user=new WpUser();
            user.setUuid(userid);
            user=wpUserService.queryForObjectByPk(user);
            MtxPoint point=new MtxPoint();
            point.setUserid(userid);
            List<MtxPoint> pointList=mtxPointService.queryPointForList(point);
            int surplusPoint=0,consumePoint=0;
            if(user!=null){
                if(user.getPoints()>0){
                    surplusPoint=user.getPoints();
                }
            }
            consumePoint=mtxPointService.queryCountConsumePoint(userid);
            model.addAttribute("surplusPoint",surplusPoint);
            model.addAttribute("consumePoint",Math.abs(consumePoint));
            model.addAttribute("pointList",pointList);
            model.addAttribute("userid",userid);
        }
        return "guest/point_list";
    }


    /**
     * 员工信息
     */
    @RequestMapping(value = "/staff/bind",method = RequestMethod.GET)
    public String staffInfo() {
        return "guest/staff_center";
    }

    @RequestMapping(value = "/staff/bind",method = RequestMethod.POST)
    public String staffInfo(WechatUserInfo wechatUserInfo,HttpServletRequest req,Model model) {
        wechatUserInfo.setBindid(getBindid(req));
        wechatUserInfo.setOpenid(getOpenid(req));
        wechatUserInfo.setType("STAFF");
        wechatUserInfoService.addStaffInfo(wechatUserInfo);
        model.addAttribute("success","保存成功!");
        return "guest/staff_center";
    }

    /**
     * 个人中心
     */
    @RequestMapping(value = "/member/userInfo",method = RequestMethod.GET)
    public String userInfo(String userid,Model model) {
        if(StringUtils.isNotBlank(userid)){
            WpUser user=new WpUser();
            user.setUuid(userid);
            user=wpUserService.queryForObjectByPk(user);
            if(user!=null){
                model.addAttribute("user",user);
            }
        }
        return "guest/userInfo";
    }

    /**
     * 我的产品
     */
    @RequestMapping(value = "/member/product_list",method = RequestMethod.GET)
    public String product_list(String userid,Model model) {
        if(StringUtils.isNotBlank(userid)){
            MtxUserMachine machine=new MtxUserMachine();
            machine.setUserid(userid);
            List<MtxUserMachine> machineList=new ArrayList<MtxUserMachine>();
            machineList=mtxUserMachineService.queryMachineList(userid,"MACHINE");
            model.addAttribute("machineList",machineList);
            model.addAttribute("userid",userid);
        }
        return "guest/product_list";
    }

    /**
     * 添加我的配件
     */
    @RequestMapping(value = "/productInfo",method = RequestMethod.GET)
    public String productInfo(String userid,Model model) {
        model.addAttribute("userid",userid);
        return "guest/productInfo";
    }

    @RequestMapping(value = "/productInfo",method = RequestMethod.POST)
    public String productInfo(Machine machine,String userid,Model model) {
        String message=null;
        if(StringUtils.isNotBlank(machine.getMachineno())){
            Machine machineTemp=new Machine();
            machineTemp.setMachineno(machine.getMachineno());
            machineTemp=machineService.queryForObjectByUniqueKey(machineTemp);
            if(machineTemp!=null){
                message=mxtProductService.addUserMachine(machine,userid);
            }else{
                model.addAttribute("machine",machine);
                message="该机器不存在！请重试！";
            }
        }
        model.addAttribute("message",message);
        model.addAttribute("userid",userid);
        return "guest/productInfo";
    }

    /**
     * 保养列表
     */
    @RequestMapping(value = "/member/maintain_list",method = RequestMethod.GET)
    public String maintain_list(HttpServletRequest request,Model model){

        WpUser wpUser = getWechatMemberInfo(request);
        model.addAttribute("wpUser",wpUser);
        QualityMgmt qualityMgmt = new QualityMgmt();
        qualityMgmt.setReporter(wpUser.getUuid());
        qualityMgmt.setType("MAINTAIN");
        model.addAttribute("type","MAINTAIN");
        qualityMgmt.setOrderby("createon desc");
        List<QualityMgmt> qualityMgmtList = qualityMgmtService.queryForList(qualityMgmt);
        model.addAttribute("qualityMgmtList",qualityMgmtList);
        return "guest/qualityMgmt_list";
    }

    /**
     * 保养详情
     */
    @RequestMapping(value = "/qualityMgmt_info",method = RequestMethod.GET)
    public String maintain_info(HttpServletRequest request,Model model){
        String qualityMgmtId= request.getParameter("qualityMgmtId");
        if(StringUtils.isNotBlank(qualityMgmtId)){
            QualityMgmt qualityMgmt = new QualityMgmt();
            qualityMgmt.setUuid(qualityMgmtId);
            qualityMgmt = qualityMgmtService.queryForObjectByPk(qualityMgmt);
            model.addAttribute("qualityMgmt", qualityMgmt);

            if(StringUtils.isNotBlank(qualityMgmt.getMerchantid())){
                Merchant merchant = new Merchant();
                merchant.setUuid(qualityMgmt.getMerchantid());
                merchant = merchantService.queryForObjectByPk(merchant);
                model.addAttribute("merchant",merchant);
            }

            Attachment workerAttachment = new Attachment();
            workerAttachment.setRefid(qualityMgmtId);
            workerAttachment.setType("worker");
            List<Attachment> workerAttachmentList = attachmentService.queryForList(workerAttachment);
            model.addAttribute("workerAttachmentList",workerAttachmentList);

            Worker worker = new Worker();
            worker.setRefid(qualityMgmtId);
            List<Worker> workerList = workerService.queryForList(worker);
            model.addAttribute("workerList",workerList);
        }
        return "guest/qualityMgmt_info";
    }

    /**
     * 报修列表
     */
    @RequestMapping(value = "/member/repair_list",method = RequestMethod.GET)
    public String repair_list(HttpServletRequest request,Model model){

        WpUser wpUser = getWechatMemberInfo(request);
        model.addAttribute("wpUser",wpUser);
        QualityMgmt qualityMgmt = new QualityMgmt();
        qualityMgmt.setReporter(wpUser.getUuid());
        qualityMgmt.setType("REPAIR");
        model.addAttribute("type","REPAIR");
        qualityMgmt.setOrderby("createon desc");
        List<QualityMgmt> qualityMgmtList = qualityMgmtService.queryForList(qualityMgmt);
        model.addAttribute("qualityMgmtList",qualityMgmtList);
        return "guest/qualityMgmt_list";
    }

    /**
     * 报修信息
     */
    @RequestMapping(value = "/member/repair_info",method = RequestMethod.GET)
    public String repair_info(){
        return "guest/repair_info";
    }

    /**
     * 报修信息
     */
    @RequestMapping(value = "/member/repair_info",method = RequestMethod.POST)
    public String repair_info(QualityMgmt qualityMgmt, RedirectAttributes redirectAttributes, HttpServletRequest request){

        String[] qualityMgmtImgs = request.getParameterValues("qualityMgmtImg");

        //添加
        WpUser wpUser = getWechatMemberInfo(request);
        qualityMgmt.setReporter(wpUser.getUuid());
        qualityMgmt.setReportername(wpUser.getName());
        qualityMgmt.setReporterphone(wpUser.getContactno());
        qualityMgmt.setType("REPAIR");
        qualityMgmt.setStatus("NEW");
        qualityMgmt.setSnno(sequenceService.getRepairSeqNo());
        qualityMgmtService.saveQualityMgmt(qualityMgmt,qualityMgmtImgs);
        redirectAttributes.addFlashAttribute("successMessage", "保存成功");

        return "redirect:/guest/member/repair_list";
    }

    /**
     * 保养小视屏
     */
    @RequestMapping(value = "/member/video",method = RequestMethod.GET)
    public String maintain(Model model) {
        MtxVideo video=new MtxVideo();
        List<MtxVideo> videoList=mtxVideoService.queryForList(video);
        model.addAttribute("videoList",videoList);
        return "guest/maintain_video";
    }

    @RequestMapping(value = "/getVideoUrl", method = RequestMethod.POST)
    @ResponseBody
    public Map getVideoUrl(String uuid){
        MtxVideo video=new MtxVideo();
        if(StringUtils.isNotBlank(uuid)){
            video.setUuid(uuid);
            video=mtxVideoService.queryForObjectByPk(video);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("video", video);
        return resultMap;
    }

    @RequestMapping(value = "/getMtxParts", method = RequestMethod.POST)
    @ResponseBody
    public Map getMtxParts(String code){
        Machine machine=new Machine();
        if(StringUtils.isNotBlank(code)){
            machine.setMachineno(code);
            machine=machineService.queryForObjectByUniqueKey(machine);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("machine", machine);
        return resultMap;
    }

    /**
     * 配件中心
     */
    @RequestMapping(value = "/parts_center",method = RequestMethod.GET)
    public String parts_center(Model model,HttpServletRequest request) {
        String Flag=request.getParameter("Flag");
        if(StringUtils.isNotBlank(Flag)){
            model.addAttribute("Flag",Flag);
        }
        return "guest/parts_center";
    }

    @RequestMapping(value = "/parts_center",method = RequestMethod.POST)
    public String parts_center(String code,Model model) {
        Machine partsCenter=new Machine();
        if(StringUtils.isNotBlank(code)){
            partsCenter.setMachineno(code);
            partsCenter=machineService.queryForObjectByUniqueKey(partsCenter);
            if(partsCenter!=null){
                Attachment attachment=new Attachment();
                attachment.setRefid(partsCenter.getUuid());
                List<Attachment> attachmentList=attachmentService.queryForList(attachment);
                model.addAttribute("attachmentList",attachmentList);
            }
        }
        model.addAttribute("partsCenter",partsCenter);
        model.addAttribute("Flag","1");
        model.addAttribute("code",code);
        return "guest/parts_center";
    }

    /**
     * 积分兑换中心
     */
    @RequestMapping(value = "/member/good_exchange",method = RequestMethod.GET)
    public String good_exchange(Model model,HttpServletRequest req) {
        MtxProduct product=new MtxProduct();
        product.setType("EXCHANGE_GOOD");
        product.setStatus("ON_SALE");
        List<MtxProduct> productList=mxtProductService.queryForList(product);
        model.addAttribute("productList",productList);
        return "guest/good_exchange_center";
    }

    /**
     * 商品详情
     */
    @RequestMapping(value = "/good_detail",method = RequestMethod.GET)
    public String good_detail(Model model,MtxProduct mtxProduct) {
        MtxProduct mtxProductTemp= mxtProductService.queryForObjectByPk(mtxProduct);
        model.addAttribute("mtxProduct",mtxProductTemp);
        return "guest/good_detail";
    }

    /**
     * 商品兑换
     */
    @RequestMapping(value = "/exchange",method = RequestMethod.GET)
    public String exchange(Model model,MtxProduct mtxProduct) {
        MtxProduct mtxProductTemp= mxtProductService.queryForObjectByPk(mtxProduct);
        model.addAttribute("mtxProduct",mtxProductTemp);
        return "guest/exchange";
    }

    /**
     * 我的配件
     */
    @RequestMapping(value = "/member/parts_list",method = RequestMethod.GET)
    public String part_list(String userid,Model model) {
        if(StringUtils.isNotBlank(userid)){
            MtxUserMachine machine=new MtxUserMachine();
            machine.setUserid(userid);
            List<MtxUserMachine> machineList=new ArrayList<MtxUserMachine>();
            machineList=mtxUserMachineService.queryMachineList(userid,"PARTS");
            model.addAttribute("machineList",machineList);
            model.addAttribute("userid",userid);
        }
        return "guest/parts_list";
    }

    @RequestMapping(value = "/parts_info",method = RequestMethod.GET)
    public String parts_info(String userid,Model model) {
        model.addAttribute("userid",userid);
        return "guest/parts_info";
    }

    @RequestMapping(value = "/parts_info",method = RequestMethod.POST)
    public String parts_info(Machine machine,String userid,Model model) {
        String message=null;
        if(StringUtils.isNotBlank(machine.getMachineno())){
            Machine machineTemp=new Machine();
            machineTemp.setMachineno(machine.getMachineno());
            machineTemp=machineService.queryForObjectByUniqueKey(machineTemp);
            if(machineTemp!=null){
                message=machineService.addUserMachine(machine,userid);
            }else{
                model.addAttribute("machine",machine);
                message="该机器不存在！请重试！";
            }
        }
        model.addAttribute("message",message);
        model.addAttribute("userid",userid);
        return "guest/parts_info";
    }

    @RequestMapping(value = "/exchange",method = RequestMethod.POST)
    public String exchange(MtxExchangeRecord mMtxExchangeRecord,MtxProduct product,Model model,HttpServletRequest req,RedirectAttributes redirectAttributes) {
        String message=null;
        WpUser user =new WpUser();
        String productid=req.getParameter("productid");
        if(StringUtils.isNotBlank(productid)){
            product.setUuid(productid);
        }
        user=getWechatMemberInfo(req);
        product=mxtProductService.queryForObjectByPk(product);
        if(product!=null){
            if(user!=null){
                int point=product.getPoints();
                int allPoint=0;
                if(mMtxExchangeRecord.getCount()>0){
                    allPoint=mMtxExchangeRecord.getCount()*point;
                }
                if(user.getPoints()>=allPoint){
                    mtxExchangeRecordService.addExchangeRecord(user.getUuid(),product.getUuid(),mMtxExchangeRecord);
                    redirectAttributes.addFlashAttribute("successMessage", "恭喜,兑换成功!");
                }else{
                    model.addAttribute("mMtxExchangeRecord",mMtxExchangeRecord);
                    message="积分不足，请重试！";
                    model.addAttribute("mtxProduct",product);
                    model.addAttribute("message",message);
                    return "guest/exchange";
                }
            }
        }else{
            model.addAttribute("mtxProduct",product);
            message="该商品不存在！";
            model.addAttribute("message",message);
            return "guest/exchange";
        }
        return "redirect:/guest/member/good_exchange";
    }
}