package com.dorm.portal.controller.guest;

import com.dorm.common.entity.Attachment;
import com.dorm.common.entity.PlatformUser;
import com.dorm.common.service.AttachmentService;
import com.dorm.common.service.PlatformUserService;
import com.dorm.common.service.SequenceService;
import com.dorm.common.utils.StringUtils;
import com.dorm.family.entity.*;
import com.dorm.family.service.*;
import com.dorm.wechat.entity.WechatUserInfo;
import com.dorm.wechat.entity.WpUser;
import com.dorm.wechat.service.WechatBindingService;
import com.dorm.wechat.service.WechatUserInfoService;
import com.dorm.wechat.service.WpUserService;
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
import java.util.*;

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
    @Autowired
    private MtxProductService mtxProductService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private MtxActivityService mtxActivityService;
    @Autowired
    private MtxActivityParticipantService mtxActivityParticipantService;
    @Autowired
    private MtxLuckyParticipantService mtxLuckyParticipantService;
    @Autowired
    private TrainService trainService;
    @Autowired
    private StudentService studentService;
    @Autowired
    private RepairService repairService;
    @Autowired
    private DormitoryService dormitoryService;
    @Autowired
    private PlatformUserService platformUserService;

    @RequestMapping(value = "/studentPortal",method = RequestMethod.GET)
    public String goStudentPortal(HttpServletRequest request,Model model){
        String stuId = request.getParameter("stuId");
        if(StringUtils.isNotBlank(stuId)){
            Student student = new Student();
            student.setUuid(stuId);
            student = studentService.queryForObjectByPk(student);
            model.addAttribute("student",student);
        }
        return "guest/studentPortal";
    }

    @RequestMapping(value = "/studentPortal",method = RequestMethod.POST)
    public String studentPortal(HttpServletRequest request, Model model){

        String stuno = request.getParameter("stuno");
        String idnoForCheck = request.getParameter("idnoForCheck");
        Student tempStudent = new Student();
        tempStudent.setStuno(stuno);
        tempStudent.setIdno(idnoForCheck);
        model.addAttribute("student",tempStudent);
        String type = request.getParameter("type");
        model.addAttribute("type",type);
        Student student = new Student();
        student.setStuno(stuno);
        student = studentService.queryForObjectByUniqueKey(student);
        if(null != student){
            String idno = student.getIdno();
            if(!idno.equals(idnoForCheck)){
                model.addAttribute("errorMessage","请检查证件号码是否正确！");
                return "guest/studentPortal";
            }
        }else{
            model.addAttribute("errorMessage","请检查学号是否正确！");
            return "guest/studentPortal";
        }

        if("REPAIR".equals(type)){
            return "redirect:/guest/repair_list?stuId="+student.getUuid();
        }else if("CONSULT".equals(type)){
            return "redirect:/guest/consult_list?stuno="+stuno;
        }else if("MESSAGE".equals(type)){
            return "redirect:/guest/message_list?stuno="+stuno;
        }else if("HYGIENE".equals(type)){
            return "redirect:/guest/hygiene_list?stuno="+stuno;
        }else if("VIOLATION".equals(type)){
            return "redirect:/guest/violation_list?stuno="+stuno;
        }else{
            return "redirect:/guest/wandefee_list?stuno="+stuno;
        }

    }


    @RequestMapping(value = "/product_center")
    public String product_center(Model model,HttpServletRequest requset) {
        MtxProduct mtxProduct = new MtxProduct();
        mtxProduct.setStatus("ON_SALE");
        mtxProduct.setType("PRODUCT");
        List<MtxProduct> mtxProductList= mxtProductService.queryForList(mtxProduct);
        model.addAttribute("mtxProductList",mtxProductList);
        String success=requset.getParameter("success");
        model.addAttribute("success",success);
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
    public String saveMtxReserve(MtxReserve mtxReserve, RedirectAttributes redirectAttributes){
        if(StringUtils.isBlank(mtxReserve.getProductid())){
            mtxReserve.setProductid(null);
        }
        if(StringUtils.isBlank(mtxReserve.getDetail())){
            mtxReserve.setDetail(null);
        }
        mtxReserve.setStatus("N_DEAL");
        mtxReserveService.insert(mtxReserve);
        redirectAttributes.addAttribute("success","预订成功！");
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
        WpUser userTemp=new WpUser();
        userTemp.setUuid(userid);
        userTemp=wpUserService.queryForObjectByPk(userTemp);
        model.addAttribute("user",userTemp);
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
    public String addRegister(WpUser wpUser, Machine machinetemp,HttpServletRequest req,Model model) {
        WpUser userTemp=getWechatMemberInfo(req);
        if(StringUtils.isNotBlank(userTemp.getIfauth())&&"Y".equals(userTemp.getIfauth())){
            model.addAttribute("ErrorMessage","您已是会员，无需重复注册！");
            return "guest/register";
        }else{
            Machine machine=new Machine();
            if(StringUtils.isNotBlank(machinetemp.getMachineno())){
                machine.setMachineno(machinetemp.getMachineno());
                machine=machineService.queryForObjectByUniqueKey(machine);
                if(machine!=null){
                    mtxMemberService.insertMemberAndPoint(wpUser,userTemp,machine);
                }else{
                    model.addAttribute("wpUser",wpUser);
                    model.addAttribute("machine",machinetemp);
                    model.addAttribute("ErrorMessage","机器填写有误！确认后重试！");
                    return "guest/register";
                }
            }
        }
        return "redirect:/guest/member/center";
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

    @RequestMapping(value = "/userInfo",method = RequestMethod.POST)
    public String userInfo(WpUser user,Model model) {
        WpUser userTemp=new WpUser();
        userTemp.setUuid(user.getUuid());
        userTemp=wpUserService.queryForObjectByPk(userTemp);
        userTemp.setName(user.getName());
        userTemp.setContactno(user.getContactno());
        userTemp.setAddress(user.getAddress());
        wpUserService.updatePartial(userTemp);
        model.addAttribute("user",userTemp);
        model.addAttribute("message","恭喜！修改成功！");
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
                message=machineService.addUserMachine(machine,userid,"MACHINE");
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
    @RequestMapping(value = "/repair_info",method = RequestMethod.GET)
    public String maintain_info(HttpServletRequest request,Model model){
        String repairId= request.getParameter("repairId");
        if(StringUtils.isNotBlank(repairId)){
            Repair repair = new Repair();
            repair.setUuid(repairId);
            repair = repairService.queryForObjectByPk(repair);
            model.addAttribute("repair", repair);

            if(StringUtils.isNotBlank(repair.getDormitoryid())){
                Dormitory dormitory = new Dormitory();
                dormitory.setUuid(repair.getDormitoryid());
                dormitory = dormitoryService.queryForObjectByPk(dormitory);
                model.addAttribute("dormitory",dormitory);
            }

            Attachment reporterAttachment = new Attachment();
            reporterAttachment.setRefid(repairId);
            reporterAttachment.setType("student");
            List<Attachment> reporterAttachmentList = attachmentService.queryForList(reporterAttachment);
            model.addAttribute("reporterAttachmentList",reporterAttachmentList);

            Attachment workerAttachment = new Attachment();
            workerAttachment.setRefid(repairId);
            workerAttachment.setType("worker");
            List<Attachment> workerAttachmentList = attachmentService.queryForList(workerAttachment);
            model.addAttribute("workerAttachmentList",workerAttachmentList);

            if(StringUtils.isNotBlank(repair.getWorker())){
                PlatformUser platformUser = new PlatformUser();
                platformUser.setUuid(repair.getWorker());
                platformUser = platformUserService.queryForObjectByPk(platformUser);
                model.addAttribute("platformUser",platformUser);
            }

        }
        return "guest/repair_info";
    }

    /**
     * 保存保养、报修用户评价
     */
    @RequestMapping(value = "/saveEvaluateInfo",method = RequestMethod.POST)
    public String saveEvaluateInfo(QualityMgmt qualityMgmt,RedirectAttributes redirectAttributes){
        qualityMgmtService.updatePartial(qualityMgmt);
        redirectAttributes.addFlashAttribute("successMessage","评价完成！");
        return "redirect:/guest/qualityMgmt_info?qualityMgmtId="+qualityMgmt.getUuid();
    }

    /**
     * 报修列表
     */
    @RequestMapping(value = "/repair_list",method = RequestMethod.GET)
    public String repair_list(HttpServletRequest request,Model model){

        String stuId = request.getParameter("stuId");
        model.addAttribute("stuId",stuId);

        Repair repair = new Repair();
        repair.setReporter(stuId);
        repair.setOrderby("createon desc");
        List<Repair> repairList = repairService.queryForList(repair);
        model.addAttribute("repairList",repairList);
        return "guest/repair_list";
    }

    /**
     * 培训列表
     */
    @RequestMapping(value = "/member/train_list",method = RequestMethod.GET)
    public String train_list(HttpServletRequest request,Model model){

        WpUser wpUser = getWechatMemberInfo(request);
        model.addAttribute("wpUser",wpUser);
        Train train = new Train();
        train.setPerson(wpUser.getUuid());
        train.setOrderby("createon desc");
        List<Train> trainList = trainService.queryForList(train);
        model.addAttribute("trainList",trainList);
        return "guest/train_list";
    }

    /**
     * 培训信息
     */
    @RequestMapping(value = "/member/train_info",method = RequestMethod.GET)
    public String train_info(HttpServletRequest request,Model model){
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

        }

        return "guest/train_info";
    }

    /**
     * 保存培训评价
     */
    @RequestMapping(value = "/saveSituationInfo",method = RequestMethod.POST)
    public String saveSituationInfo(Train train,RedirectAttributes redirectAttributes){
        trainService.updatePartial(train);
        redirectAttributes.addFlashAttribute("successMessage","评价完成！");
        return "redirect:/guest/member/train_info?trainId="+train.getUuid();
    }

    /**
     * 报修信息
     */
    @RequestMapping(value = "/repair_add",method = RequestMethod.GET)
    public String repair_add(Model model,HttpServletRequest request){
        String stuId = request.getParameter("stuId");
        Student student = new Student();
        student.setUuid(stuId);
        student = studentService.queryForObjectByPk(student);
        model.addAttribute("student",student);

        Dormitory dormitory = new Dormitory();
        dormitory.setUuid(student.getDormitoryid());
        dormitory = dormitoryService.queryForObjectByPk(dormitory);
        model.addAttribute("dormitory",dormitory);


        return "guest/repair_add";
    }

    /**
     * 报修信息
     */
    @RequestMapping(value = "/repair_add",method = RequestMethod.POST)
    public String repair_add(Repair repair, RedirectAttributes redirectAttributes, HttpServletRequest request){

        String[] repairImgs = request.getParameterValues("repairImg");

        //添加
        repair.setType("STUDENT");
        repair.setStatus("NEW");
        repair.setSnno(sequenceService.getRepairSeqNo());
        repairService.createRepair(repair,repairImgs);
        redirectAttributes.addFlashAttribute("successMessage", "保存成功");

        return "redirect:/guest/repair_list?stuId"+repair.getReporter();
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

    @RequestMapping(value = "/goProductDetail", method = RequestMethod.POST)
    @ResponseBody
    public Map goProductDetail(String model){
        MtxProduct product=new MtxProduct();
        if(StringUtils.isNotBlank(model)){
            product.setModel(model);
            product=mxtProductService.queryForObjectByUniqueKey(product);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("mtxProduct", product);
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
            partsCenter.setType("PARTS");
            List<Machine> partsCenterList=machineService.queryForList(partsCenter);
            if(partsCenterList.size()>0){
                partsCenter=partsCenterList.get(0);
                if(partsCenter!=null){
                    Attachment attachment=new Attachment();
                    attachment.setRefid(partsCenter.getUuid());
                    List<Attachment> attachmentList=attachmentService.queryForList(attachment);
                    model.addAttribute("attachmentList",attachmentList);
                }
            }
        }//为了区分是机器还是配件
        if(StringUtils.isNotBlank(partsCenter.getUuid())){
            model.addAttribute("partsCenter",partsCenter);
            model.addAttribute("Flag","1");
        }else{
            model.addAttribute("Flag","0");
        }
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
    public String exchange(Model model,MtxProduct mtxProduct,HttpServletRequest req) {
        WpUser user=new WpUser();
        user=getWechatMemberInfo(req);
        MtxProduct mtxProductTemp= mxtProductService.queryForObjectByPk(mtxProduct);
        model.addAttribute("mtxProduct",mtxProductTemp);
        MtxUserMachine userMachine=new MtxUserMachine();
        userMachine.setUserid(user.getUuid());
        List<String> merchantidList=new ArrayList<String>();
        List<MtxUserMachine> userMachineList=mtxUserMachineService.queryForList(userMachine);
        if(userMachineList.size()>0){
            for(int i=0;i<userMachineList.size();i++){
                Machine machine=new Machine();
                machine.setUuid(userMachineList.get(i).getMachineid());
                machine=machineService.queryForObjectByPk(machine);
                Order order=new Order();
                order.setUuid(machine.getOrderid());
                order=orderService.queryForObjectByPk(order);
                merchantidList.add(order.getMerchantid());
            }
        }
        List<String> merchantList=new ArrayList<String>();
        if(merchantidList.size()>0){
            merchantList=merchantService.queryMerchantNameList(merchantidList);
        }
        model.addAttribute("merchantList",merchantList);
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

    /**
     * 我的兑换
     */
    @RequestMapping(value = "/member/exchange_list",method = RequestMethod.GET)
    public String exchange_list(String userid,Model model) {
        if(StringUtils.isNotBlank(userid)){
            MtxExchangeRecord exchangeRecord=new MtxExchangeRecord();
            exchangeRecord.setUserid(userid);
            List<MtxExchangeRecord> exchangeList=new ArrayList<MtxExchangeRecord>();
            exchangeList=mtxExchangeRecordService.queryExchangeRecordList(userid);
            if(exchangeList.size()>0){
                for(MtxExchangeRecord e:exchangeList){
                    if(StringUtils.isNotBlank(e.getContactno())){
                        String phone[]=e.getContactno().split(",");
                        if(phone.length>1){
                            e.setContactno(phone[0]);
                            break;
                        }
                    }
                }
            }
            model.addAttribute("exchangeList",exchangeList);
            model.addAttribute("userid",userid);
        }
        return "guest/exchange_list";
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
                message=machineService.addUserMachine(machine,userid,"PARTS");
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

    /**
     * 活动列表
     */
    @RequestMapping(value = "/activity_list",method = RequestMethod.GET)
    public String activity_list(Model model) {
        MtxActivity mtxActivity = new MtxActivity();
        mtxActivity.setOrderby("createon desc");
        List<MtxActivity> mtxActivityList = mtxActivityService.queryForList(mtxActivity);
        model.addAttribute("mtxActivityList",mtxActivityList);
        return "guest/activity_list";
    }

    /**
     * 活动详情
     */
    @RequestMapping(value = "/activity_info",method = RequestMethod.GET)
    public String activity_info(Model model,HttpServletRequest request) {

        WpUser wpUser = getWechatMemberInfo(request);
        model.addAttribute("wpUser",wpUser);

        String activityId = request.getParameter("activityId");
        if(StringUtils.isNotBlank(activityId)){
            MtxActivity mtxActivity = new MtxActivity();
            mtxActivity.setUuid(activityId);
            mtxActivity = mtxActivityService.queryForObjectByPk(mtxActivity);
            model.addAttribute("mtxActivity",mtxActivity);

            Attachment attachment = new Attachment();
            attachment.setRefid(activityId);
            List<Attachment> attachmentList = attachmentService.queryForList(attachment);
            model.addAttribute("attachmentList",attachmentList);

            if(null != mtxActivity){

                //判断是否已参加
                if(null != wpUser){
                    MtxActivityParticipant tempParticipant = new MtxActivityParticipant();
                    tempParticipant.setUserid(wpUser.getUuid());
                    tempParticipant.setActivityid(activityId);
                    List<MtxActivityParticipant> tempParticipantList = mtxActivityParticipantService.queryForList(tempParticipant);
                    if(null != tempParticipantList && tempParticipantList.size() > 0){
                        model.addAttribute("participanted","Y");
                    }
                }

                MtxActivityParticipant mtxActivityParticipant = new MtxActivityParticipant();
                mtxActivityParticipant.setActivityid(activityId);
                List<MtxActivityParticipant> activityParticipantList = mtxActivityParticipantService.queryForParticipantList(mtxActivityParticipant);
                model.addAttribute("activityParticipantList",activityParticipantList);

                mtxActivityParticipant.setStatus("WIN");
                List<MtxActivityParticipant> winParticipantList = mtxActivityParticipantService.queryForParticipantList(mtxActivityParticipant);
                model.addAttribute("winParticipantList",winParticipantList);
            }
        }

        return "guest/activity_info";
    }

    @RequestMapping(value = "/participateActivity",method = RequestMethod.GET)
    public String participateActivity(HttpServletRequest request){

        String activityId = request.getParameter("activityId");
        String name = request.getParameter("name");
        String contactno = request.getParameter("contactno");
        String area = request.getParameter("area");

        WpUser wpUser = getWechatMemberInfo(request);
        if(StringUtils.isNotBlank(name)){
            wpUser.setName(name);
        }
        if(StringUtils.isNotBlank(contactno)){
            wpUser.setContactno(contactno);
        }
        if(StringUtils.isNotBlank(area)){
            wpUser.setArea(Double.valueOf(area));
        }

        mtxActivityService.participateActivity(activityId,wpUser);

        return "redirect:/guest/activity_info?activityId="+activityId;
    }

}