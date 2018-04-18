package com.dorm.portal.controller.admin;

import com.dorm.common.entity.Attachment;
import com.dorm.common.entity.PlatformRole;
import com.dorm.common.entity.PlatformUser;
import com.dorm.common.service.*;
import com.dorm.common.utils.*;
import com.dorm.family.entity.*;
import com.dorm.family.service.*;
import com.dorm.portal.PortalContants;
import com.dorm.portal.utils.ExportUtil;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.exception.ServiceException;
import com.dorm.wechat.entity.WpUser;
import com.dorm.wechat.entity.admin.WechatBinding;
import com.dorm.wechat.service.WechatBindingService;
import com.dorm.wechat.service.WpUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.util.*;
import java.util.HashMap;


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
    private QualityMgmtService qualityMgmtService;
    @Autowired
    private WorkerService workerService;
    @Autowired
    private PlatformUserService platformUserService;
    @Autowired
    private MtxExchangeRecordService mtxExchangeRecordService;
    @Autowired
    private MtxUserMachineService mtxUserMachineService;
    @Autowired
    private MtxActivityService mtxActivityService;
    @Autowired
    private PlatformRoleService platformRoleService;
    @Autowired
    private MtxActivityParticipantService mtxActivityParticipantService;
    @Autowired
    private MtxLuckyParticipantService mtxLuckyParticipantService;
    @Autowired
    private PartsImportService partsImportService;
    @Autowired
    private DormitoryService dormitoryService;
    @Autowired
    private AddressService addressService;
    @Autowired
    private AddressImportService addressImportService;
    @Autowired
    private StudentService studentService;


    /**
     *
     * @return
     */
    @RequestMapping(value = "/stuInfo", method = RequestMethod.POST)
    public String stuInfo(Student student, Model model,HttpServletRequest request,RedirectAttributes redirectAttributes) {
        //检查是否重复
        Student studentForRepeat = studentService.getStudentForSave(student);

        if (null != studentForRepeat) {
            model.addAttribute("errorMessage", "抱歉，该学号对应学生信息已存在！");
            model.addAttribute("student",student);
            List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
            model.addAttribute("dormitoryList",dormitoryList);
            return "admin/wefamily/stuInfo";
        } else {
            //修改
            if (StringUtils.isNotBlank(student.getUuid())) {
                try {
                    studentService.updatePartial(student);
                    redirectAttributes.addFlashAttribute("successMessage", "保存成功！");
                } catch (ServiceException e) {
                    redirectAttributes.addFlashAttribute("errorMessage", "系统忙，稍候再试！");
                }
                student = studentService.queryForObjectByPk(student);
            } else {
                //添加
                WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
                student.setBindid(wechatBinding.getUuid());
                if(StringUtils.isBlank(student.getIdtype())){
                    student.setIdtype(null);
                    student.setIdno(null);
                }
                if(StringUtils.isBlank(student.getNation())){
                    student.setNation(null);
                }
                if(StringUtils.isBlank(student.getPolitical())){
                    student.setPolitical(null);
                }
                studentService.insert(student);
                redirectAttributes.addFlashAttribute("successMessage", "保存成功！");
            }
        }
        return "redirect:/admin/wefamily/stuInfo?studentId="+student.getUuid();
    }


    /**
     * 获取分层列表
     * @return
     */
    @RequestMapping(value = "/{dormitoryid}/layer", produces = "application/json")
    public @ResponseBody Map<String, Object> getlayerJson(@PathVariable("dormitoryid") String dormitoryid,HttpServletRequest request,Model model){

        Address address = new Address();
        address.setDormitoryid(dormitoryid);

        List<Address> layerList = addressService.getLayerListForDropDown(address);
        List<Map<String,Object>> returnMapList = new ArrayList<Map<String,Object>>();
        for(Address tempAddress : layerList){
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("layer",tempAddress.getLayer());
            returnMapList.add(map);
        }

        Map<String, Object> responseMap = new HashMap<String, Object>();
        responseMap.put("layerList",returnMapList);
        return responseMap;
    }

    /**
     *
     * @param dormitoryid
     * @param layer
     * @return
     */
    @RequestMapping(value = "/{dormitoryid}/{layer}/roomno", produces = "application/json")
    public @ResponseBody Map<String, Object> getRoomnoJson(
            @PathVariable("dormitoryid") String dormitoryid,
            @PathVariable("layer") String layer){
        Address address = new Address();
        address.setDormitoryid(dormitoryid);
        address.setLayer(layer);
        address.setOrderby("roomno");
        List<Address> addressList = addressService.getRoomnoListForDropDown(address);
        List<Map<String,Object>> returnMapList = new ArrayList<Map<String,Object>>();
        for(Address tempAddress : addressList){
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("roomno", tempAddress.getRoomno());
            returnMapList.add(map);
        }
        Map<String, Object> responseMap = new HashMap<String, Object>();
        responseMap.put("roomnoList",returnMapList);
        return responseMap;
    }

    /**
     * 学生信息界面
     * @param model
     * @return
     */
    @RequestMapping(value = "/stuManage",method = RequestMethod.GET)
    public String stuManage(Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);

        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

        String fromAddress = request.getParameter("fromAddress");
        if("Y".equals(fromAddress)){
            String dormitoryId = request.getParameter("dormitoryId");
            String layer = request.getParameter("layer");
            String roomno = request.getParameter("roomno");

            Student student = new Student();
            student.setBindid(UserUtils.getUserBindId());
            student.setDormitoryid(dormitoryId);
            student.setLayer(layer);
            student.setRoomno(roomno);

            PageBounds pageBounds = new PageBounds(1, PortalContants.PAGE_SIZE);
            PageList<Student> studentPageList = studentService.getStuListWithPagination(student, pageBounds);

            model.addAttribute("studentPageList",studentPageList);
            model.addAttribute("student",student);
        }

        return "admin/wefamily/stuManage";
    }

    /**
     * 学生管理
     *
     * @return
     */
    @RequestMapping(value = "/stuManage",method = RequestMethod.POST)
    public String stuManage(@RequestParam(required = false, defaultValue = "1") int page, Model model, HttpServletRequest request,Student student) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if (null != wechatBinding) {

            student.setBindid(wechatBinding.getUuid());
            student.setOrderby("modifyon desc");

            List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
            model.addAttribute("dormitoryList",dormitoryList);

            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<Student> studentPageList = studentService.getStuListWithPagination(student, pageBounds);
            model.addAttribute("studentPageList",studentPageList);

            model.addAttribute("student",student);

            String saveFlag = request.getParameter("saveFlag");
            if ("1".equals(saveFlag)) {
                model.addAttribute("successMessage", "保存成功");
            }
            String deleteFlag = request.getParameter("deleteFlag");
            if ("1".equals(deleteFlag)) {
                model.addAttribute("successMessage", "删除成功");
            }
        }
        return "admin/wefamily/stuManage";
    }

    /**
     * 学生信息界面
     *
     * @return
     */
    @RequestMapping(value = "/stuInfo", method = RequestMethod.GET)
    public String stuInfo(HttpServletRequest request, Model model) {

        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

        String studentId = request.getParameter("studentId");
        if(StringUtils.isNotBlank(studentId)){
            Student student = new Student();
            student.setUuid(studentId);
            student = studentService.queryForObjectByPk(student);
            model.addAttribute("student",student);
        }
        return "admin/wefamily/stuInfo";
    }

    /**
     * 宿舍楼管理
     *
     * @return
     */
    @RequestMapping(value = "/dormitoryManage")
    public String dormitoryManage(@RequestParam(required = false, defaultValue = "1") int page, Model model, HttpServletRequest request,Dormitory dormitory) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        if (null != wechatBinding) {

            dormitory.setBindid(wechatBinding.getUuid());
            dormitory.setOrderby("modifyon desc");

            String userid = UserUtils.getUserId();
            List<Dormitory> dormitoryList = dormitoryService.getAssignedDormitoryForUser();
            String topAccount = "";
            if (dormitoryList == null || dormitoryList.isEmpty()) {
                topAccount = "Y";
            }
            model.addAttribute("topAccount", topAccount);
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);

            PageList<Dormitory> dormitoryPageList = dormitoryService.getDormitoryForUserWithPagination(userid, topAccount, dormitory, pageBounds);
            model.addAttribute("dormitoryPageList",dormitoryPageList);

            model.addAttribute("dormitory",dormitory);

            String saveFlag = request.getParameter("saveFlag");
            if ("1".equals(saveFlag)) {
                model.addAttribute("successMessage", "保存成功");
            }
            String deleteFlag = request.getParameter("deleteFlag");
            if ("1".equals(deleteFlag)) {
                model.addAttribute("successMessage", "删除成功");
            }
        }
        return "admin/wefamily/dormitoryManage";
    }

    /**
     * 经销商管理
     */
    @RequestMapping(value = "/merchantManage")
    public String merchantManage(@RequestParam(required = false, defaultValue = "1") int page, Model model,Merchant merchant){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
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
        model.addAttribute("merchant",merchant);
        PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
        PageList<Merchant> mtxMerchantList = merchantService.selectMerchantForUserWithPagination(userid, topAccount, merchant, pageBounds);
        model.addAttribute("merchantList", mtxMerchantList);

        return "admin/wefamily/merchantManage";
    }


    /**
     * 经销商信息界面
     *
     * @return
     */
    @RequestMapping(value = "/dormitoryInfo", method = RequestMethod.GET)
    public String dormitoryInfo(HttpServletRequest request, Model model) {
        String dormitoryId = request.getParameter("dormitoryId");
        if (StringUtils.isNoneBlank(dormitoryId)) {
            //查询宿舍楼信息
            Dormitory dormitory = new Dormitory();
            dormitory.setUuid(dormitoryId);
            dormitory = dormitoryService.queryForObjectByPk(dormitory);
            model.addAttribute("dormitory", dormitory);
        }
        model.addAttribute("view", request.getParameter("view"));
        return "admin/wefamily/dormitoryInfo";
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "/dormitoryInfo", method = RequestMethod.POST)
    public String dormitoryInfo(Dormitory dormitory, Model model,HttpServletRequest request,RedirectAttributes redirectAttributes) {
        //检查是否重名
        Dormitory dormitoryForRepeat = dormitoryService.getDormitoryForSave(dormitory);

        if (null != dormitoryForRepeat) {
            model.addAttribute("errorMessage", "抱歉，该宿舍楼已存在！");
        } else {


            //修改
            if (StringUtils.isNotBlank(dormitory.getUuid())) {
                Dormitory dormitoryForMod = dormitoryService.queryForObjectByPk(dormitory);
                dormitoryForMod.setName(dormitory.getName());
                String contactno = dormitory.getContactno().replaceAll("，", ",");
                dormitoryForMod.setContactno(contactno);
                dormitoryForMod.setFrequentcontacts(dormitory.getFrequentcontacts());
                dormitoryForMod.setContactsphone(dormitory.getContactsphone());
                dormitoryForMod.setAddress(dormitory.getAddress());
                dormitoryForMod.setVersionno(dormitory.getVersionno());
                try {
                    dormitoryService.updatePartial(dormitoryForMod);
                    redirectAttributes.addFlashAttribute("successMessage", "保存成功！");
                } catch (ServiceException e) {
                    redirectAttributes.addFlashAttribute("errorMessage", "系统忙，稍候再试！");
                }
                dormitory = dormitoryService.queryForObjectByPk(dormitory);
            } else {
                //添加
                WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
                dormitory.setBindid(wechatBinding.getUuid());
                dormitoryService.insert(dormitory);
                redirectAttributes.addFlashAttribute("successMessage", "保存成功！");
            }
            model.addAttribute("dormitory", dormitory);
        }
        return "redirect:/admin/wefamily/dormitoryInfo?dormitoryId="+dormitory.getUuid();
    }

    /**
     * 删除
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteDormitory")
    @ResponseBody
    public Map<String, Object> deleteMerchant(HttpServletRequest request) {
        int deleteFlag = 0;

        String dormitoryId = request.getParameter("dormitoryId");
        Dormitory dormitory = new Dormitory();
        dormitory.setUuid(dormitoryId);
        deleteFlag = dormitoryService.delete(dormitory);

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }


    /**
     * 设置舍长
     * @param request
     * @return
     */
    @RequestMapping(value = "/setDormHead")
    @ResponseBody
    public Map<String, Object> setDormHead(HttpServletRequest request) {
        int setFlag = 0;

        String studentId = request.getParameter("studentId");

        setFlag = studentService.setDormHead(studentId);

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("setFlag", setFlag);
        return resultMap;
    }

    /**
     * 删除
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteStudent")
    @ResponseBody
    public Map<String, Object> deleteStudent(HttpServletRequest request) {
        int deleteFlag = 0;

        String studentId = request.getParameter("studentId");
        Student student = new Student();
        student.setUuid(studentId);
        deleteFlag = studentService.delete(student);

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }

    /**
     * 房间信息管理界面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/addressManage",method = RequestMethod.GET)
    public String addressManage(HttpServletRequest request,Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String dormitoryId = request.getParameter("dormitoryId");
        if(StringUtils.isNoneBlank(dormitoryId)){
            Dormitory dormitory = new Dormitory();
            dormitory.setUuid(dormitoryId);
            dormitory = dormitoryService.queryForObjectByPk(dormitory);
            model.addAttribute("dormitory",dormitory);
        }
        return "admin/wefamily/addressManage";
    }

    /**
     * 房间管理查询
     * @param address
     * @param model
     * @return
     */
    @RequestMapping(value = "/addressManage",method = RequestMethod.POST)
    public String addressManage(@RequestParam(required = false, defaultValue = "1") int page,Model model,Address address,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);

        PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
        PageList<Address> addressPageList = addressService.getAddressListWithPagination(address,pageBounds);
        model.addAttribute("addressPageList",addressPageList);

        Dormitory dormitory = new Dormitory();
        dormitory.setUuid(address.getDormitoryid());
        dormitory = dormitoryService.queryForObjectByPk(dormitory);
        model.addAttribute("dormitory",dormitory);

        String deleteFlag = request.getParameter("deleteFlag");
        if ("1".equals(deleteFlag)) {
            model.addAttribute("successMessage", "删除成功");
        }

        return "admin/wefamily/addressManage";
    }

    /**
     * 房间信息界面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/addressInfo",method = RequestMethod.GET)
    public String addressInfo(HttpServletRequest request,Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String dormitoryId = request.getParameter("dormitoryId");
        if(StringUtils.isNoneBlank(dormitoryId)){
            Dormitory dormitory = new Dormitory();
            dormitory.setUuid(dormitoryId);
            dormitory = dormitoryService.queryForObjectByPk(dormitory);
            model.addAttribute("dormitory",dormitory);
        }
        String addressId = request.getParameter("addressId");
        if(StringUtils.isNotBlank(addressId)){
            Address address = new Address();
            address.setUuid(addressId);
            address = addressService.queryForObjectByPk(address);
            model.addAttribute("address",address);
        }
        return "admin/wefamily/addressInfo";
    }

    /**
     * 房间信息保存
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/addressInfo",method = RequestMethod.POST)
    public String addressInfo(HttpServletRequest request,Model model,Address address){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);


            //检查是否存在
            Address addressForRepeat = addressService.getAddressForSave(address);

            if (null != addressForRepeat) {
                model.addAttribute("errorMessage", "抱歉，该房间已存在！");
            } else {
                //修改
                if (StringUtils.isNotBlank(address.getUuid())) {
                    Address addressForMod = addressService.queryForObjectByPk(address);
                    addressForMod.setLayer(address.getLayer());
                    addressForMod.setRoomno(address.getRoomno());
                    addressForMod.setArea(address.getArea());
                    addressForMod.setVersionno(address.getVersionno());
                    try {
                        addressService.updatePartial(addressForMod);
                        model.addAttribute("successMessage", "保存成功！");
                    } catch (ServiceException e) {
                        model.addAttribute("errorMessage", "系统忙，稍候再试！");
                    }
                    address = addressService.queryForObjectByPk(address);
                } else {
                    //添加
                    addressService.insert(address);
                    model.addAttribute("successMessage", "保存成功！");
                }
                model.addAttribute("address", address);
            }
            Dormitory dormitory = new Dormitory();
            dormitory.setUuid(address.getDormitoryid());
            dormitory = dormitoryService.queryForObjectByPk(dormitory);
            model.addAttribute("dormitory",dormitory);

        return "admin/wefamily/addressInfo";
    }

    /**
     * 删除
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteAddress")
    @ResponseBody
    public Map<String, Object> deleteAddress(HttpServletRequest request) {
        int deleteFlag = 0;

        String addressId = request.getParameter("addressId");
        Address address = new Address();
        address.setUuid(addressId);
        deleteFlag = addressService.delete(address);

        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }

    public  List<String> getModel(){
        List<String> modelList=mxtProductService.getAllModel();
        return modelList;
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
            List<String> modelList=getModel();
            model.addAttribute("modelList",modelList);
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
        if(StringUtils.isNotBlank(mtxProduct.getModel())){
            Boolean flag=validModelIsExist(mtxProduct.getModel(),mtxProduct.getUuid());
            if(flag){
                if (StringUtils.isBlank(mtxProduct.getUuid())) {
                    mtxProduct.setType("PRODUCT");
                    if(StringUtils.isNotBlank(mtxProduct.getWatchornot())){
                        mtxProduct.setWatchornot("Y");
                    }else{
                        mtxProduct.setWatchornot("N");
                    }
                    mxtProductService.insert(mtxProduct);
                    model.addAttribute("mtxProduct", mtxProduct);
                    model.addAttribute("successMessage", "保存成功！");
                } else {
                    try {
                        if(StringUtils.isNotBlank(mtxProduct.getWatchornot())){
                            mtxProduct.setWatchornot("Y");
                        }else{
                            mtxProduct.setWatchornot("N");
                        }
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
            }else{
                model.addAttribute("mtxProduct", mtxProduct);
                model.addAttribute("errorMessage", "此型号已存在，请换一个试试！");
            }
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
        List<String> machineModelList = getModel();
        model.addAttribute("machineModelList",machineModelList);
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
    public String orderManage(@RequestParam(required = false,defaultValue = "1") int page, Order order, Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
        List<String> machineModelList = getModel();
        model.addAttribute("machineModelList",machineModelList);
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

            String[] statusArr = request.getParameterValues("status");
            String statusStr = "";
            if(null != statusArr){
                statusStr = StringUtils.join(statusArr, ",");
            }
            model.addAttribute("statusStr", statusStr);
            if(null != statusArr && statusArr.length == 1 && StringUtils.isBlank(statusArr[0])){
                statusArr = null;
            }
            order.setStatusArr(statusArr);
            String ifHqUser = "";
            List<PlatformRole> platformRoleList = platformRoleService.queryUserRoleListForUser();
            for(PlatformRole pr:platformRoleList){
                if(pr.getRolekey().split("_")[0].equals("HQ") || pr.getRolekey().equals("WP_SUPER")){
                    ifHqUser = "Y";
                }
            }

            order.setBindid(wechatBinding.getUuid());
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<Order> orderList = orderService.queryOrderList(order,ifHqUser, startDateTimeStr, endDateTimeStr, pageBounds);
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
     *首页点击到订单管理
     */
    @RequestMapping(value = "/goOrderManage",method = RequestMethod.GET)
    public String goOrderManage(@RequestParam(required = false,defaultValue = "1") int page,Order order,Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
        List<String> machineModelList = getModel();
        model.addAttribute("machineModelList",machineModelList);
        model.addAttribute("order",order);
        if(null != wechatBinding) {
            String ifHqUser = "";
            List<PlatformRole> platformRoleList = platformRoleService.queryUserRoleListForUser();
            for (PlatformRole pr : platformRoleList) {
                if (pr.getRolekey().split("_")[0].equals("HQ") || pr.getRolekey().equals("WP_SUPER")) {
                    ifHqUser = "Y";
                }
            }
            String startDateTimeStr = "";
            String endDateTimeStr = "";
            String[] statusArr = request.getParameterValues("status");
            order.setStatusArr(statusArr);
            model.addAttribute("statusStr", statusArr[0]);
            order.setBindid(wechatBinding.getUuid());
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<Order> orderList = orderService.queryOrderList(order, ifHqUser, startDateTimeStr, endDateTimeStr, pageBounds);
            model.addAttribute("orderList", orderList);
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

        List<String> machineModelList = getModel();
        model.addAttribute("machineModelList",machineModelList);

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
        String merchantId = order.getMerchantid();
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

            order.setStatus("UNSUBMIT");
            //总部人员添加订单
            List<PlatformRole> platformRoleList = platformRoleService.queryUserRoleListForUser();
            for(PlatformRole pr:platformRoleList){
                if(pr.getRolekey().split("_")[0].equals("HQ") || pr.getRolekey().equals("WP_SUPER")){
                    order.setStatus("NEW");
                }
            }
            //添加
            order.setSnno(sequenceService.getOrderSeqNo());
            orderService.insert(order);
            redirectAttributes.addFlashAttribute("successMessage", "保存成功");
            order = new Order();
        }

        return "redirect:orderInfo?orderId=" + order.getUuid() + "&merchantId=" + merchantId;
    }

    /**
     * 机器添加完成
     * @param request
     * @return
     */
    @RequestMapping("/finishAddMachine")
    @ResponseBody
    public Map<String, Object> finishAddMachine(HttpServletRequest request){
        int finishAddFlag = 0;
        String orderId = request.getParameter("orderId");
        String versionno = request.getParameter("versionno");
        if(StringUtils.isNotBlank(orderId)){
            Order order = new Order();
            order.setUuid(orderId);
            order.setVersionno(Integer.valueOf(versionno));
            finishAddFlag = orderService.finishAddMachine(order);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("finishAddFlag", finishAddFlag);
        return resultMap;
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
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
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
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
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
            machine.setType("MACHINE");
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
        String finishAddFlag = request.getParameter("finishAddFlag");
        if("1".equals(finishAddFlag)){
            model.addAttribute("successMessage", "机器添加完成");
        }else if("0".equals(finishAddFlag)){
            model.addAttribute("errorMessage", "操作失败");
        }

        //订单完成结果
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
    public Map<String,Object> addMachineForOrder(HttpServletRequest request,Machine machine){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        machine.setBindid(UserUtils.getUserBindId());

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
     *订单添加物流价格
     */
    @RequestMapping(value = "/saveFreightForOrder",method= RequestMethod.GET)
    public String saveFreightForOrder(HttpServletRequest request,Order order,RedirectAttributes redirectAttributes){
        orderService.updatePartial(order);
        redirectAttributes.addAttribute("successMessage","保存成功！");
        return "redirect:orderDetail?orderId=" + order.getUuid();
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
     * 删除图片
     */
    @RequestMapping("/deletePic")
    @ResponseBody
    public Map<String, Object> deletePic(HttpServletRequest request){
        int deleteFlag = 0;
        String attachmentId = request.getParameter("attachmentId");
        if(StringUtils.isNotBlank(attachmentId)){
            Attachment attachment = new Attachment();
            attachment.setUuid(attachmentId);
            deleteFlag = attachmentService.delete(attachment);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
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
        String remarks = request.getParameter("remarks");
        if(StringUtils.isNotBlank(orderId)){
            Order order = new Order();
            order.setUuid(orderId);
            if(StringUtils.isNotBlank(remarks)){
                order.setRemarks(remarks);
            }
            order.setVersionno(Integer.valueOf(versionno));
            finishFlag = orderService.finishOrder(order);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("finishFlag", finishFlag);
        return resultMap;
    }

    /**
     * 咨询管理
     */
    @RequestMapping(value = "/mtxReserveManage")
    public String mtxReserveManage(@RequestParam(required = false, defaultValue = "1") int page, MtxReserve mtxReserve, Model model, HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        Boolean identify=false;
        List<PlatformRole> platformRoleList = platformRoleService.queryUserRoleListForUser();
        if(platformRoleList.size()>0){
            for(int i=0;i<platformRoleList.size();i++){
                if("WP_SUPER".equals(platformRoleList.get(i).getRolekey())){
                    identify=true;
                    break;
                }
            }
        }
        if(identify){
            List<Merchant> merchantList=merchantService.selectMerchantForUser();
            model.addAttribute("merchantList",merchantList);
            if(StringUtils.isBlank(mtxReserve.getStatus())){
                mtxReserve.setStatus("N_DEAL");
            }
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<MtxReserve> mtxReserveList = mtxReserveService.queryForListWithPagination(mtxReserve, pageBounds);
            model.addAttribute("mtxReserveList", mtxReserveList);
            model.addAttribute("mtxReserve",mtxReserve);

            return "admin/wefamily/mtxReserveManage";
        }else{
            List<Merchant> merchantList=merchantService.selectMerchantForUser();
            model.addAttribute("merchantList",merchantList);
            List<String> uuidList=new ArrayList<String>();
            if(merchantList.size()>0){
                for(int i=0;i<merchantList.size();i++){
                    uuidList.add(merchantList.get(i).getUuid());
                }
            }
            if(StringUtils.isBlank(mtxReserve.getStatus())){
                mtxReserve.setStatus("CHANGE");
            }
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<MtxReserve> mtxReserveList = mtxReserveService.queryMerchantReserve(mtxReserve, pageBounds,UserUtils.getUserBindId(),uuidList);
            model.addAttribute("mtxReserveList", mtxReserveList);
            model.addAttribute("mtxReserve",mtxReserve);
            return "admin/wefamily/mtxReserveMerchant";
        }

    }

    @RequestMapping(value = "/goMtxReserve",method = RequestMethod.GET)
    public String goMtxReserve(MtxReserve mtxReserve,Model model){
        List<Merchant> merchantList=merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
        mtxReserve=mtxReserveService.queryByPK(mtxReserve);
        model.addAttribute("mtxReserve",mtxReserve);
        return "admin/wefamily/mtxReserveInfo";
    }

    @RequestMapping(value = "/goReserveMerchant",method = RequestMethod.GET)
    public String goReserveMerchant(MtxReserve mtxReserve,Model model){
        List<Merchant> merchantList=merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
        mtxReserve=mtxReserveService.queryByPK(mtxReserve);
        model.addAttribute("mtxReserve",mtxReserve);
        return "admin/wefamily/mtxReserveMerchantInfo";
    }

    @RequestMapping(value = "/updateMtxReserve",method = RequestMethod.POST)
    public String updateMtxReserve(MtxReserve mtxReserve, RedirectAttributes redirectAttributes, Model model,String flag){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        List<Merchant> merchantList=merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
        try {
            mtxReserveService.updatePartial(mtxReserve);
            mtxReserve=mtxReserveService.queryByPK(mtxReserve);
            model.addAttribute("mtxReserve",mtxReserve);
        } catch (ServiceException e) {
            logger.error(e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "数据已修改，请重试！");
            if(StringUtils.isNotBlank(flag)){
                return "redirect:/admin/wefamily/goReserveMerchant?uuid=" + mtxReserve.getUuid();
            }else{
                return "redirect:/admin/wefamily/goMtxReserve?uuid=" + mtxReserve.getUuid();
            }
        }
        model.addAttribute("successMessage", "保存成功！");
        if(StringUtils.isNotBlank(flag)){
            return "admin/wefamily/mtxReserveMerchantInfo";
        }else{
            return "admin/wefamily/mtxReserveInfo";
        }
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
    public String goMtxConsultDetail(MtxConsultDetail mtxConsultDetail, Model model, String userid, String consultid, HttpServletRequest request) {
        if(StringUtils.isNotBlank(consultid)){
            mtxConsultDetail.setConsultid(consultid);
            model.addAttribute("uuid",consultid);
        }
        if(StringUtils.isNotBlank(userid))
        {
            WpUser user=new WpUser();
            user.setUuid(userid);
            user=wpUserService.queryForObjectByPk(user);
            model.addAttribute("user",user);
            model.addAttribute("userid",userid);
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
    public String answer(MtxConsultDetail mtxConsultDetail,String userid) {
        String flag=mtxConsultService.answerQuestion(mtxConsultDetail);
        String successMsg=null;
        if("Y".equals(flag)){
            successMsg="1";
        }else{
            successMsg="0";
        }
        return "redirect:goMtxConsultDetail?consultid="+mtxConsultDetail.getConsultid()+"&userid="+userid+"&successMsg="+successMsg;
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
        List<String> machineModelList = getModel();
        model.addAttribute("machineModelList",machineModelList);
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
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
        List<String> machineModelList = getModel();
        model.addAttribute("machineModelList",machineModelList);
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
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
     * 导出培训查询结果
     */
    @RequestMapping(value = "/exportTrainList",method = RequestMethod.POST)
    public void exportTrainList(Train train, HttpServletRequest request, HttpServletResponse response){
        Map<String,List> beanParams = new HashMap<String, List>();

        String startDateStr = request.getParameter("startDateStr");
        String endDateStr = request.getParameter("endDateStr");
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

        List<Train> trainListForExport = trainService.queryTrainListForExport(train,startDateTimeStr,endDateTimeStr);

        beanParams.put("trainListForExport", trainListForExport);

        //导出
        ExportUtil.exportExcel(beanParams, "/tpl/train.xls", response);
    }

    /**
     * 培训信息（界面）
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/trainInfo",method = RequestMethod.GET)
    public String trainInfo(HttpServletRequest request,Model model){

        String merchantId = request.getParameter("merchantId");
        Merchant merchant = new Merchant();
        merchant.setUuid(merchantId);
        merchant = merchantService.queryForObjectByPk(merchant);
        model.addAttribute("merchant",merchant);

        List<String> machineModelList = getModel();
        model.addAttribute("machineModelList",machineModelList);

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
            train.setSnno(sequenceService.getTrainSeqNo());
            trainService.saveTrain(train,trainImgs);
            redirectAttributes.addFlashAttribute("successMessage", "保存成功");
        }

        return "redirect:trainInfo?trainId=" + train.getUuid() + "&merchantId="+ train.getMerchantid();
    }

    //保存培训奖励情况
    @RequestMapping(value = "/saveTrainPraiseInfo")
    public String saveTrainPraiseInfo(Train train,RedirectAttributes redirectAttributes){

        trainService.updatePartial(train);
        redirectAttributes.addFlashAttribute("successMessage", "保存成功");
        return "redirect:trainInfo?trainId=" + train.getUuid() + "&merchantId="+ train.getMerchantid();
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
            finishFlag = trainService.finishTrain(train);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("finishFlag", finishFlag);
        return resultMap;
    }

    @RequestMapping(value = "/finishTrainForPhone",method = RequestMethod.POST)
    public String finishTrainForPhone(Model model,HttpServletRequest request,Train train, RedirectAttributes redirectAttributes){
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
                train.setStatus("FINISH");
                trainService.updateTrain(train,trainImgs);
                redirectAttributes.addFlashAttribute("successMessage", "培训结束");
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "系统忙，稍候再试");
            }
        }else{
            train.setSnno(sequenceService.getTrainSeqNo());
            trainService.saveFinishTrain(train,trainImgs);
            redirectAttributes.addFlashAttribute("successMessage", "培训结束");
        }
        redirectAttributes.addFlashAttribute("scanedFlag",request.getParameter("scanedFlag"));
        return "redirect:trainInfoForPhone?trainId=" + train.getUuid();
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
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        List<Train> trainList = trainService.queryTrainListForPhone(train,merchantList);
        model.addAttribute("trainList",trainList);
        return "admin/wefamily/trainManageForPhone";
    }

    @RequestMapping(value = "/trainInfoForPhone",method = RequestMethod.GET)
    public String trainInfoForPhone(Model model,HttpServletRequest request){

        List<String> machineModelList = getModel();
        model.addAttribute("machineModelList",machineModelList);

        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);

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
            train.setSnno(sequenceService.getTrainSeqNo());
            trainService.saveTrain(train,trainImgs);
            redirectAttributes.addFlashAttribute("successMessage", "保存成功");
        }

        redirectAttributes.addFlashAttribute("scanedFlag",request.getParameter("scanedFlag"));
        return "redirect:trainInfoForPhone?trainId=" + train.getUuid();
    }

    /**
     * 根据机器号查询用户
     */
    @RequestMapping(value = "/queryUserByMachineno", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> queryUserByMachineno(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String machineno = request.getParameter("machineno");
        List<WpUser> wpUserList = wpUserService.queryUserByMachineno(machineno);
       if(null != wpUserList && wpUserList.size() > 0){
           WpUser wpUser = wpUserList.get(0);
           resultMap.put("wpUser", wpUser);
       }
        return resultMap;
    }

    /**
     * 报修管理
     */
    @RequestMapping(value = "/repairManage",method = RequestMethod.GET)
    public String repairManage(Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        model.addAttribute("type","REPAIR");
        List<String> machineModelList = getModel();
        model.addAttribute("machineModelList",machineModelList);
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
        return "admin/wefamily/qualityMgmtManage";
    }

    /**
     * 保养管理
     */
    @RequestMapping(value = "/maintainManage",method = RequestMethod.GET)
    public String maintainManage(Model model){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        model.addAttribute("type","MAINTAIN");
        List<String> machineModelList = getModel();
        model.addAttribute("machineModelList",machineModelList);
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
        return "admin/wefamily/qualityMgmtManage";
    }

    /**
     * 获取处理人列表
     * @return
     */
    @RequestMapping(value = "/{merchantId}/dealQualityMgmtPerson", produces = "application/json")
    public @ResponseBody Map<String, Object> finddealQualityMgmtPersonJson(@PathVariable("merchantId") String merchantId,HttpServletRequest request){

        String type = request.getParameter("type");
        List<PlatformUser> workerList = platformUserService.queryWorkersByMerchantIdAndServiveType(merchantId,type);

        Map<String, Object> responseMap = new HashMap<String, Object>();
        responseMap.put("workerList",workerList);
        return responseMap;
    }

    //检查机器是否存在
    @RequestMapping(value = "/checkMachineIfexist")
    @ResponseBody
    public Map<String, Object> checkMachineIfexist(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String machinemodel = request.getParameter("machinemodel");
        String machineno = request.getParameter("machineno");
        String engineno = request.getParameter("engineno");
        Machine machine = new Machine();
        machine.setMachinemodel(machinemodel);
        machine.setMachineno(machineno);
        machine.setEngineno(engineno);
        List<Machine> machineList = machineService.queryForList(machine);
        if(machineList.size()==0){
            resultMap.put("existFlag", "N");
        }
        return resultMap;
    }

    /**
     *指派工人
     */
    @RequestMapping(value = "/addWorkerForQualityMgmt",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> addWorkerForQualityMgmt(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        String qualityMgmtId = request.getParameter("qualityMgmtId");
        String versionno = request.getParameter("versionno");
        String workerId = request.getParameter("workerId");
        QualityMgmt qualityMgmt = new QualityMgmt();
        qualityMgmt.setUuid(qualityMgmtId);
        qualityMgmt.setVersionno(Integer.valueOf(versionno));
        qualityMgmt.setWorkerid(workerId);

        try {
            qualityMgmtService.chooseWorker(qualityMgmt);
            resultMap.put("successMessage", "指派成功");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            resultMap.put("errorMessage", "系统忙，稍候再试");
        }


        return resultMap;
    }

    /**
     * 报修管理
     * @param qualityMgmt
     * @param model
     * @return
     */
    @RequestMapping(value = "/qualityMgmtManage")
    public String qualityMgmtManage(@RequestParam(required = false,defaultValue = "1") int page, QualityMgmt qualityMgmt, Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        model.addAttribute("qualityMgmt",qualityMgmt);
        List<String> machineModelList = getModel();
        model.addAttribute("machineModelList",machineModelList);
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
        String type = request.getParameter("type");
        model.addAttribute("type",type);
        qualityMgmt.setType(type);
        //首页点击查询未分配任务
        String unDistributed = request.getParameter("unDistributed");
        if("Y".equals(unDistributed)){
            qualityMgmt.setMerchantid(unDistributed);
            model.addAttribute("unDistributed",unDistributed);
        }
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

            String[] statusArr = request.getParameterValues("status");
            String statusStr = "";
            if(null != statusArr){
                statusStr = StringUtils.join(statusArr, ",");
            }
            model.addAttribute("statusStr", statusStr);
            if(null != statusArr && statusArr.length == 1 && StringUtils.isBlank(statusArr[0])){
                statusArr = null;
            }
            qualityMgmt.setStatusArr(statusArr);

            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<QualityMgmt> qualityMgmtList = qualityMgmtService.queryQualityMgmtPageList(qualityMgmt, startDateTimeStr, endDateTimeStr, pageBounds);
            model.addAttribute("qualityMgmtList", qualityMgmtList);

            //删除结果
            String deleteFlag = request.getParameter("deleteFlag");
            if("1".equals(deleteFlag)){
                model.addAttribute("successMessage", "删除成功");
            }else if("0".equals(deleteFlag)){
                model.addAttribute("errorMessage", "删除失败");
            }
        }

        return "admin/wefamily/qualityMgmtManage";
    }

    /**
     * 导出报修、保养查询结果
     */
    @RequestMapping(value = "/exportQualityMgmtList",method = RequestMethod.POST)
    public void exportQualityMgmtList(QualityMgmt qualityMgmt, HttpServletRequest request, HttpServletResponse response){
        Map<String,List> beanParams = new HashMap<String, List>();

        String type = request.getParameter("type");
        qualityMgmt.setType(type);

        String startDateStr = request.getParameter("startDateStr");
        String endDateStr = request.getParameter("endDateStr");
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

        String[] statusArr = request.getParameterValues("status");
        String statusStr = "";
        if(null != statusArr){
            statusStr = StringUtils.join(statusArr, ",");
        }
        if(null != statusArr && statusArr.length == 1 && StringUtils.isBlank(statusArr[0])){
            statusArr = null;
        }
        qualityMgmt.setStatusArr(statusArr);
        String unDistributed = request.getParameter("unDistributed");
        if("Y".equals(unDistributed)){
            qualityMgmt.setMerchantid(unDistributed);
        }

        List<QualityMgmt> qualityMgmtListForExport = qualityMgmtService.queryQualityMgmtListForExport(qualityMgmt,startDateStr,endDateStr);
        beanParams.put("qualityMgmtListForExport", qualityMgmtListForExport);


        //导出
        if("REPAIR".equals(type)){
            ExportUtil.exportExcel(beanParams, "/tpl/repair.xls", response);
        }else{
            ExportUtil.exportExcel(beanParams, "/tpl/maintain.xls", response);
        }

    }

    /**
     * 删除订单
     * @param request
     * @return
     */
    @RequestMapping("/deleteQualityMgmt")
    @ResponseBody
    public Map<String, Object> deleteQualityMgmt(HttpServletRequest request){
        int deleteFlag = 0;
        String qualityMgmtId = request.getParameter("qualityMgmtId");
        if(StringUtils.isNotBlank(qualityMgmtId)){
            QualityMgmt qualityMgmt = new QualityMgmt();
            qualityMgmt.setUuid(qualityMgmtId);
            deleteFlag = qualityMgmtService.delete(qualityMgmt);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }

    /**
     * 报修信息
     */
    @RequestMapping(value = "/qualityMgmtInfo",method = RequestMethod.GET)
    public String qualityMgmtInfo(HttpServletRequest request,Model model){
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);

        List<String> machineModelList = getModel();
        model.addAttribute("machineModelList",machineModelList);

        String qualityMgmtId= request.getParameter("qualityMgmtId");
        String type = request.getParameter("type");
        model.addAttribute("type",type);
        if(StringUtils.isNotBlank(qualityMgmtId)){
            QualityMgmt qualityMgmt = new QualityMgmt();
            qualityMgmt.setUuid(qualityMgmtId);
            qualityMgmt = qualityMgmtService.queryForObjectByPk(qualityMgmt);


            if(StringUtils.isNotBlank(qualityMgmt.getMerchantid())){
                List<PlatformUser> workerUserList = platformUserService.queryWorkersByMerchantIdAndServiveType(qualityMgmt.getMerchantid(),qualityMgmt.getType());
                model.addAttribute("workerUserList",workerUserList);
            }else{
                Machine machine = new Machine();
                machine.setMachinemodel(qualityMgmt.getMachinemodel());
                machine.setMachineno(qualityMgmt.getMachineno());
                machine.setEngineno(qualityMgmt.getEngineno());
                Merchant merchant = merchantService.queryMerchantByMachineInfo(machine);
                if(null != merchant){
                    qualityMgmt.setMerchantid(merchant.getUuid());
                    qualityMgmtService.updatePartial(qualityMgmt);
                    /*qualityMgmt.setVersionno(qualityMgmt.getVersionno()+1);*/
                }
            }
            model.addAttribute("qualityMgmt",qualityMgmt);

            Worker worker = new Worker();
            worker.setRefid(qualityMgmtId);
            List<Worker> tempWorkerList = workerService.queryForList(worker);
            if(null != tempWorkerList && tempWorkerList.size() > 0 ){
                model.addAttribute("worker",tempWorkerList.get(0));
            }


            Attachment reporterAttachment = new Attachment();
            reporterAttachment.setRefid(qualityMgmtId);
            reporterAttachment.setType("reporter");
            List<Attachment> reporterAttachmentList = attachmentService.queryForList(reporterAttachment);
            model.addAttribute("reporterAttachmentList",reporterAttachmentList);

            Attachment workerAttachment = new Attachment();
            workerAttachment.setRefid(qualityMgmtId);
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

        return "admin/wefamily/qualityMgmtInfo";
    }

    /**
     * 根据id查询经销商
     */
    @RequestMapping(value = "/queryMerchantById", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> queryMerchantById(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String merchantId = request.getParameter("merchantId");
        Merchant merchant = new Merchant();
        merchant.setUuid(merchantId);
        merchant = merchantService.queryForObjectByPk(merchant);
        resultMap.put("merchant", merchant);
        return resultMap;
    }

    /**
     *保存用户、机器、经销商信息
     */
    @RequestMapping(value = "/saveReportQualityMgmtInfo",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> saveReportQualityMgmtInfo(QualityMgmt qualityMgmt, HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String type = request.getParameter("type");
        qualityMgmt.setType(type);
        String returnMsg = qualityMgmtService.saveReportQualityMgmtInfo(qualityMgmt);
        if(StringUtils.isNotBlank(returnMsg)){
            resultMap.put("returnMsg",returnMsg);
        }else{
            resultMap.put("successMessage", "保存成功");
            resultMap.put("qualityMgmtId",qualityMgmt.getUuid());
        }
        return resultMap;
    }

    /**
     * 开始维修
     */
    @RequestMapping("/startQualityMgmt")
    @ResponseBody
    public Map<String, Object> startQualityMgmt(HttpServletRequest request){
        int startFlag = 0;
        String qualityMgmtId = request.getParameter("qualityMgmtId");
        String versionno = request.getParameter("versionno");
        if(StringUtils.isNotBlank(qualityMgmtId)){
            QualityMgmt qualityMgmt = new QualityMgmt();
            qualityMgmt.setUuid(qualityMgmtId);
            qualityMgmt.setVersionno(Integer.valueOf(versionno));
            startFlag = qualityMgmtService.startQualityMgmt(qualityMgmt);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("startFlag", startFlag);
        return resultMap;
    }

    /**
     *保存维修信息
     */
    @RequestMapping(value = "/saveQualityMgmtInfo",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> saveQualityMgmtInfo(QualityMgmt qualityMgmt,Worker worker, HttpServletRequest request, Model model){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        String qualityMgmtId = request.getParameter("qualityMgmtId");
        String versionno = request.getParameter("qualityMgmtVersionno");
        qualityMgmt.setUuid(qualityMgmtId);
        qualityMgmt.setVersionno(Integer.valueOf(versionno));

        String workerId = request.getParameter("workerId");
        PlatformUser platformUser = platformUserService.getPlatformUserById(workerId);
        worker.setRefid(qualityMgmtId);
        List<Worker> workerList = workerService.queryForList(worker);
        if(null != workerList && workerList.size() > 0){
            worker = workerList.get(0);
        }
        worker.setUserid(workerId);
        worker.setName(platformUser.getName());
        worker.setPhone(platformUser.getCellphone());

        String[] qualityMgmtImgs = request.getParameterValues("qualityMgmtImg");

        qualityMgmtService.saveQualityMgmtInfo(qualityMgmt,worker,qualityMgmtImgs);

        String saveType = request.getParameter("saveType");
        if("FINISH".equals(saveType)){
            QualityMgmt tempQualityMgmt = new QualityMgmt();
            tempQualityMgmt.setUuid(qualityMgmtId);
            tempQualityMgmt = qualityMgmtService.queryForObjectByPk(tempQualityMgmt);
            qualityMgmtService.finishQualityMgmt(tempQualityMgmt);
        }
        resultMap.put("successMessage", "保存成功");
        return resultMap;
    }

    //保存保养、维修奖励情况
    @RequestMapping(value = "/saveQualityMgmtPraiseInfo")
    public String saveQualityMgmtPraiseInfo(QualityMgmt qualityMgmt,RedirectAttributes redirectAttributes,HttpServletRequest request){

        String type = request.getParameter("type");
        qualityMgmtService.updatePartial(qualityMgmt);
        redirectAttributes.addFlashAttribute("saveSuccessMessage", "保存成功");
        return "redirect:qualityMgmtInfo?qualityMgmtId=" + qualityMgmt.getUuid() + "&type="+ type;
    }

    /**
     * 维修结束
     */
    @RequestMapping("/finishQualityMgmt")
    @ResponseBody
    public Map<String, Object> finishQualityMgmt(HttpServletRequest request){
        int finishFlag = 0;
        String qualityMgmtId = request.getParameter("qualityMgmtId");
        String versionno = request.getParameter("versionno");
        String remarks = request.getParameter("remarks");
        if(StringUtils.isNotBlank(qualityMgmtId)){
            QualityMgmt qualityMgmt = new QualityMgmt();
            qualityMgmt.setUuid(qualityMgmtId);
            qualityMgmt.setVersionno(Integer.valueOf(versionno));
            qualityMgmt.setRemarks(remarks);
            finishFlag = qualityMgmtService.finishQualityMgmt(qualityMgmt);
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
        QualityMgmt qualityMgmt = new QualityMgmt();
        qualityMgmt.setType("REPAIR");
        qualityMgmt.setWorkerid(UserUtils.getUserId());
        model.addAttribute("type","REPAIR");
        List<QualityMgmt> qualityMgmtList = qualityMgmtService.queryQualityMgmtListForPhone(qualityMgmt);
        model.addAttribute("qualityMgmtList",qualityMgmtList);
        return "admin/wefamily/qualityMgmtManageForPhone";
    }

    /**
     * 保养列表
     * @param model
     * @return
     */
    @RequestMapping(value = "/maintainManageForPhone")
    public String maintainManageForPhone(Model model) {
        QualityMgmt qualityMgmt = new QualityMgmt();
        qualityMgmt.setType("MAINTAIN");
        qualityMgmt.setWorkerid(UserUtils.getUserId());
        model.addAttribute("type","MAINTAIN");
        List<QualityMgmt> qualityMgmtList = qualityMgmtService.queryQualityMgmtListForPhone(qualityMgmt);
        model.addAttribute("qualityMgmtList",qualityMgmtList);
        return "admin/wefamily/qualityMgmtManageForPhone";
    }

    @RequestMapping(value = "/qualityMgmtInfoForPhone",method = RequestMethod.GET)
    public String qualityMgmtInfoForPhone(Model model,HttpServletRequest request){

        List<String> machineModelList = getModel();
        model.addAttribute("machineModelList",machineModelList);

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

            Attachment reporterAttachment = new Attachment();
            reporterAttachment.setRefid(qualityMgmtId);
            reporterAttachment.setType("reporter");
            List<Attachment> reporterAttachmentList = attachmentService.queryForList(reporterAttachment);
            model.addAttribute("reporterAttachmentList",reporterAttachmentList);

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


        return "admin/wefamily/qualityMgmtInfoForPhone";
    }

    @RequestMapping(value = "/qualityMgmtInfoForPhone",method = RequestMethod.POST)
    public String qualityMgmtInfoForPhone(Model model, HttpServletRequest request, QualityMgmt qualityMgmt, Worker worker, RedirectAttributes redirectAttributes){

        String workerId = request.getParameter("workerid");
        String workerVersionno = request.getParameter("workerversionno");

        if(StringUtils.isNotBlank(workerId)){
            worker.setUuid(workerId);
            worker.setVersionno(Integer.valueOf(workerVersionno));
        }


        String[] qualityMgmtImgs = request.getParameterValues("qualityMgmtImg");

        //修改
        if(StringUtils.isNotBlank(qualityMgmt.getUuid())){
            try {
                qualityMgmtService.saveQualityMgmtInfo(qualityMgmt,worker,qualityMgmtImgs);
                redirectAttributes.addFlashAttribute("successMessage", "保存成功");
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "系统忙，稍候再试");
            }
        }
        redirectAttributes.addFlashAttribute("scanedFlag",request.getParameter("scanedFlag"));
        return "redirect:qualityMgmtInfoForPhone?qualityMgmtId=" + qualityMgmt.getUuid();
    }

    @RequestMapping(value = "/finishQualityMgmtForPhone",method = RequestMethod.POST)
    public String finishQualityMgmtForPhone(Model model, HttpServletRequest request, QualityMgmt qualityMgmt, Worker worker, RedirectAttributes redirectAttributes){

        String workerId = request.getParameter("workerid");
        String workerVersionno = request.getParameter("workerversionno");

        if(StringUtils.isNotBlank(workerId)){
            worker.setUuid(workerId);
            worker.setVersionno(Integer.valueOf(workerVersionno));
        }


        String[] qualityMgmtImgs = request.getParameterValues("qualityMgmtImg");

        //修改
        if(StringUtils.isNotBlank(qualityMgmt.getUuid())){
            try {
                qualityMgmt.setStatus("FINISH");
                qualityMgmtService.saveQualityMgmtInfo(qualityMgmt,worker,qualityMgmtImgs);
                redirectAttributes.addFlashAttribute("successMessage", "服务结束！");
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "系统忙，稍候再试");
            }
        }
        redirectAttributes.addFlashAttribute("scanedFlag",request.getParameter("scanedFlag"));
        return "redirect:qualityMgmtInfoForPhone?qualityMgmtId=" + qualityMgmt.getUuid();
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
            List<String> modelList=getModel();
            model.addAttribute("modelList",modelList);
            model.addAttribute("mtxVideoList", mtxVideoList);
            model.addAttribute("mtxVideo",mtxVideo);
        }
        String successFlag=request.getParameter("deleteFlag");
        if("1".equals(successFlag)){
            model.addAttribute("successFlag","删除成功");
        }
        return "admin/wefamily/mtxVideoManage";
    }

    @RequestMapping(value = "/goMtxVideo", method = RequestMethod.GET)
    public String goMtxVideo(Model model,MtxVideo mtxVideo){
        List<String> modelList=getModel();
        model.addAttribute("modelList",modelList);
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
        List<String> modelList=getModel();
        model.addAttribute("modelList",modelList);
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
            List<String> modelList=getModel();
            model.addAttribute("modelList",modelList);
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
    public String goMtxPartsCenter(Model model,Machine machine,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        Machine machineTemp=machineService.queryForObjectByPk(machine);
        model.addAttribute("machine",machineTemp);
        List<Attachment> attachmentList=new ArrayList<Attachment>();
        if(StringUtils.isNotBlank(machine.getUuid())){
            attachmentList=getAttachmentByRefid(machine.getUuid());
        }
        List<String> modelList=getModel();
        model.addAttribute("modelList",modelList);
        model.addAttribute("attachmentList",attachmentList);
        String deleteFlag = request.getParameter("deleteFlag");
        if("1".equals(deleteFlag)){
            model.addAttribute("successMessage", "删除成功");
        }else if("0".equals(deleteFlag)){
            model.addAttribute("errorMessage", "删除失败");
        }

        return "admin/wefamily/mtxPartsCenterInfo";
    }

    @RequestMapping(value = "/updateMtxPartsCenter",method = RequestMethod.POST)
    public String updateMtxPartsCenter(Machine machine, RedirectAttributes redirectAttributes, Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        List<String> modelList=getModel();
        model.addAttribute("modelList",modelList);
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

    /**
     * 兑换记录商品
     */
    @RequestMapping(value = "/mtxExchangeRecordManage")
    public String mtxExchangeRecordManage(@RequestParam(required = false, defaultValue = "1") int page, MtxExchangeRecord mtxExchangeRecord, Model model,HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        String flag=request.getParameter("flag");
        if (null != wechatBinding) {
            if(StringUtils.isBlank(mtxExchangeRecord.getStatus())){
                if(StringUtils.isNotBlank(flag)&&"1".equals(flag)){
                    mtxExchangeRecord.setStatus("C_DEAL");
                }else{
                    mtxExchangeRecord.setStatus("N_DEAL");
                }
            }
            model.addAttribute("status",mtxExchangeRecord.getStatus());
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<MtxExchangeRecord> mtxExchangeRecordList = mtxExchangeRecordService.queryForListWithPagination(mtxExchangeRecord, pageBounds);
            model.addAttribute("mtxExchangeRecordList", mtxExchangeRecordList);
            model.addAttribute("mtxExchangeRecord",mtxExchangeRecord);
        }
        return "admin/wefamily/mtxExchangeRecordManage";
    }

    @RequestMapping(value = "/updateExchangeRecord",method = RequestMethod.POST)
    public String updateExchangeRecord(MtxExchangeRecord mtxExchangeRecord, RedirectAttributes redirectAttributes,String flag) {
        String remarks=mtxExchangeRecord.getRemarks();
        mtxExchangeRecord=mtxExchangeRecordService.queryForObjectByPk(mtxExchangeRecord);
        if(mtxExchangeRecord!=null){
            mtxExchangeRecord.setRemarks(remarks);
            mtxExchangeRecord.setStatus("C_DEAL");
            mtxExchangeRecordService.updatePartial(mtxExchangeRecord);
            redirectAttributes.addFlashAttribute("successMessage","确认成功！");
        }else{
            redirectAttributes.addFlashAttribute("errorMessage","确认失败！");
        }
        return "redirect:/admin/wefamily/mtxExchangeRecordManage?flag="+flag;
    }

    /**
     * 活动管理
     */
    @RequestMapping(value = "/mtxActivityManage")
    public String mtxActivityManage(@RequestParam(required = false, defaultValue = "1") int page, MtxActivity activity, Model model, HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
        if (null != wechatBinding) {
            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            activity.setBindid(UserUtils.getUserBindId());
            PageList<MtxActivity> activityList = mtxActivityService.queryForListWithPagination(activity, pageBounds);
            model.addAttribute("activityList", activityList);
            model.addAttribute("activity",activity);
        }
        String successFlag=request.getParameter("deleteFlag");
        if("1".equals(successFlag)){
            model.addAttribute("successFlag","删除成功");
        }
        String stopFlag=request.getParameter("stopFlag");
        if("1".equals(stopFlag)){
            model.addAttribute("successFlag","结束成功");
        }
        String beginFlag=request.getParameter("successFlag");
        if("1".equals(beginFlag)){
            model.addAttribute("successFlag","活动开始！");
        }
        return "admin/wefamily/mtxActivityManage";
    }

    @RequestMapping(value = "/goMtxActivity", method = RequestMethod.GET)
    public String goMtxGood(Model model,MtxActivity activity,HttpServletRequest request){
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        Attachment attachment=new Attachment();
        if(StringUtils.isNotBlank(activity.getUuid())){
            attachment.setRefid(activity.getUuid());
            List<Attachment> attachmentList=attachmentService.queryForList(attachment);
            model.addAttribute("attachmentList",attachmentList);
        }
        MtxActivity activityTemp=mtxActivityService.queryForObjectByPk(activity);
        model.addAttribute("activity",activityTemp);
        MtxActivityParticipant participant=new MtxActivityParticipant();
        List<MtxActivityParticipant>  participantList=new ArrayList<MtxActivityParticipant>();
        List<MtxActivityParticipant>  winList=new ArrayList<MtxActivityParticipant>();
        List<MtxLuckyParticipant>  luckyList=new ArrayList<MtxLuckyParticipant>();
        MtxLuckyParticipant luckyParticipant =new MtxLuckyParticipant();

        String participantname=request.getParameter("participantname");
        String participantphone=request.getParameter("participantphone");
        if(StringUtils.isNotBlank(activity.getUuid())){
            participant.setActivityid(activity.getUuid());
            luckyParticipant.setActivityid(activity.getUuid());
            //查询所有参加人数
            List<MtxActivityParticipant> totalList=mtxActivityParticipantService.queryForParticipantList(participant);
            model.addAttribute("totalList",totalList);
            if(StringUtils.isNotBlank(participantname)){
                participant.setName(participantname);
                model.addAttribute("participantname",participantname);
            }
            if(StringUtils.isNotBlank(participantphone)){
                participant.setContactno(participantphone);
                model.addAttribute("participantphone",participantphone);
            }
            participantList=mtxActivityParticipantService.queryForParticipantList(participant);
            model.addAttribute("participantList",participantList);
            luckyList=mtxLuckyParticipantService.queryForLuckyParticipantList(luckyParticipant,"");
            participant.setStatus("WIN");
            winList=mtxActivityParticipantService.queryForParticipantList(participant);
            model.addAttribute("luckyList",luckyList);
            model.addAttribute("winList",winList);
        }
        String successFlg=request.getParameter("successFlg");
        if("1".equals(successFlg)){
            model.addAttribute("successMessage","操作成功！");
        }
        return "admin/wefamily/mtxActivityInfo";
    }

    @RequestMapping(value = "/updateMtxActivity",method = RequestMethod.POST)
    public String updateMtxActivity(@RequestParam(value = "imgfile", required = false)MultipartFile multipartFile,MtxActivity activity, RedirectAttributes redirectAttributes, Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        MtxActivityParticipant participant=new MtxActivityParticipant();
        List<MtxActivityParticipant>  participantList=new ArrayList<MtxActivityParticipant>();
        List<MtxActivityParticipant>  winList=new ArrayList<MtxActivityParticipant>();
        List<MtxLuckyParticipant>  luckyList=new ArrayList<MtxLuckyParticipant>();
        MtxLuckyParticipant luckyParticipant =new MtxLuckyParticipant();
        if(StringUtils.isNotBlank(activity.getUuid())){
            participant.setActivityid(activity.getUuid());
            luckyParticipant.setActivityid(activity.getUuid());
            participantList=mtxActivityParticipantService.queryForParticipantList(participant);
            model.addAttribute("participantList",participantList);
            luckyList=mtxLuckyParticipantService.queryForLuckyParticipantList(luckyParticipant,"");
            participant.setStatus("WIN");
            winList=mtxActivityParticipantService.queryForParticipantList(participant);
            model.addAttribute("luckyList",luckyList);
            model.addAttribute("winList",winList);
        }
        if(null != multipartFile && !multipartFile.isEmpty()){
            String foldername = "activity";
            String filename = UploadUtils.uploadFile(multipartFile, foldername);
            activity.setImg(filename);
        }
        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        model.addAttribute("merchantList",merchantList);
        String[] detailImgs = request.getParameterValues("detailImg");
        if (StringUtils.isBlank(activity.getUuid())) {
            activity.setBindid(UserUtils.getUserBindId());
            mtxActivityService.insert(activity);

            //生成活动二维码
            String domainUrl = RequestUtil.getDomainUrl();
            String qrCodeUrl = domainUrl + "/guest/activity_info?activityId="+activity.getUuid();
            String staffqrcode = QRCodeUtil.generateActivityQRCode(qrCodeUrl);
            activity.setQrcode(staffqrcode);
            mtxActivityService.updatePartial(activity);

            activity = mtxActivityService.queryForObjectByPk(activity);
            model.addAttribute("activity", activity);
            if(detailImgs!=null&&detailImgs.length>0){
                for(int i=0;i<detailImgs.length;i++){
                    Attachment attachment=new Attachment();
                    attachment.setRefid(activity.getUuid());
                    attachment.setName(detailImgs[i]);
                    attachmentService.insert(attachment);
                }
            }
            List<Attachment> attachmentList=new ArrayList<Attachment>();
            attachmentList=getAttachmentByRefid(activity.getUuid());
            model.addAttribute("attachmentList",attachmentList);
            model.addAttribute("successMessage", "保存成功！");
        } else {
            try {
                mtxActivityService.updatePartial(activity);
                MtxActivity activityTemp = mtxActivityService.queryForObjectByPk(activity);
                model.addAttribute("activity", activityTemp);
                if(detailImgs!=null&&detailImgs.length>0){
                    for(int i=0;i<detailImgs.length;i++){
                        Attachment attachment=new Attachment();
                        attachment.setRefid(activityTemp.getUuid());
                        attachment.setName(detailImgs[i]);
                        attachmentService.insert(attachment);
                    }
                }
                List<Attachment> attachmentList=new ArrayList<Attachment>();
                attachmentList=getAttachmentByRefid(activityTemp.getUuid());
                model.addAttribute("attachmentList",attachmentList);
            } catch (ServiceException e) {
                logger.error(e.getMessage(), e);
                redirectAttributes.addFlashAttribute("errorMessage", "数据已修改，请重试！");
                return "redirect:/admin/wefamily/goMtxActivity?uuid=" + activity.getUuid();

            }
            model.addAttribute("successMessage", "保存成功！");
        }
        return "admin/wefamily/mtxActivityInfo";
    }

    @RequestMapping(value = "/deleteMtxActivity", method = RequestMethod.POST)
    @ResponseBody
    public Map deleteMtxActivity(MtxActivity activity){
        int deleteFlag=mtxActivityService.delete(activity);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("deleteFlag", deleteFlag);
        return resultMap;
    }

    @RequestMapping(value = "/stopMtxActivity", method = RequestMethod.POST)
    @ResponseBody
    public Map stopMtxActivity(MtxActivity activity){
        activity=mtxActivityService.queryForObjectByPk(activity);
        activity.setStatus("APP");
        mtxActivityService.updatePartial(activity);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("stopFlag", "1");
        return resultMap;
    }

    @RequestMapping(value = "/beginMtxActivity", method = RequestMethod.POST)
    @ResponseBody
    public Map beginMtxActivity(MtxActivity activity){
        activity=mtxActivityService.queryForObjectByPk(activity);
        activity.setStatus("PENDING");
        mtxActivityService.updatePartial(activity);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("successFlag", "1");
        return resultMap;
    }

    @RequestMapping(value = "/addParticipant", method = RequestMethod.POST)
    public String addParticipant(String uuid,HttpServletRequest request,RedirectAttributes redirectAttributes){
        String message="";
        String participantname=request.getParameter("participantname");
        redirectAttributes.addAttribute("participantname",participantname);
        String participantphone=request.getParameter("participantphone");
        redirectAttributes.addAttribute("participantphone",participantphone);
        if(StringUtils.isNotBlank(participantname)||StringUtils.isNotBlank(participantphone)){
            MtxActivityParticipant activityParticipant=new MtxActivityParticipant();
            activityParticipant.setActivityid(uuid);
            activityParticipant.setName(participantname);
            activityParticipant.setContactno(participantphone);

            List<MtxActivityParticipant> activityParticipantList=mtxActivityParticipantService.queryForParticipantList(activityParticipant);
            String participants[] = request.getParameterValues("users");
            String existFlag="N";
            if(null != participants){
                for(int i=0;i<activityParticipantList.size();i++){
                    for(String p:participants){
                        if(activityParticipantList.get(i).getUserid().equals(p)){
                            existFlag="Y";
                            MtxLuckyParticipant luckyParticipant=new MtxLuckyParticipant();
                            luckyParticipant.setActivityid(uuid);
                            luckyParticipant.setUserid(p);
                            List<MtxLuckyParticipant> luckList=mtxLuckyParticipantService.queryForList(luckyParticipant);
                            if(luckList==null||luckList.size()==0){
                                luckyParticipant.setStatus("WAIT_WIN");
                                mtxLuckyParticipantService.insert(luckyParticipant);
                            }
                            break;
                        }

                    }
                    if("N".equals(existFlag)){
                        MtxLuckyParticipant luckyParticipant=new MtxLuckyParticipant();
                        luckyParticipant.setActivityid(uuid);
                        luckyParticipant.setUserid(activityParticipantList.get(i).getUserid());
                        List<MtxLuckyParticipant> luckList=mtxLuckyParticipantService.queryForLuckyParticipantList(luckyParticipant,"");
                        if(luckList.size()>0){
                            luckyParticipant=luckList.get(0);
                            if("WIN".equals(luckyParticipant.getStatus())){
                                message+=luckyParticipant.getName()+"已中奖！";
                            }else{
                                mtxLuckyParticipantService.delete(luckyParticipant);
                            }
                        }
                    }
                }
            }else{
                for(MtxActivityParticipant p:activityParticipantList ){
                    MtxLuckyParticipant luckyParticipant=new MtxLuckyParticipant();
                    luckyParticipant.setActivityid(uuid);
                    luckyParticipant.setUserid(p.getUserid());
                    List<MtxLuckyParticipant> luckList=mtxLuckyParticipantService.queryForLuckyParticipantList(luckyParticipant,"");
                    if(luckList.size()>0){
                        luckyParticipant=luckList.get(0);
                        if("WIN".equals(luckyParticipant.getStatus())){
                            message+=luckyParticipant.getName()+"已中奖！";
                        }else{
                            mtxLuckyParticipantService.delete(luckyParticipant);
                        }
                    }
                }
            }
        }else{
            MtxActivity activity=new MtxActivity();
            activity.setUuid(uuid);
            activity=mtxActivityService.queryForObjectByPk(activity);
            if(null!=activity&&"PENDING".equals(activity.getStatus())){
                MtxLuckyParticipant participantTemp=new MtxLuckyParticipant();
                participantTemp.setActivityid(uuid);
                List<MtxLuckyParticipant> luckyParticipantList = mtxLuckyParticipantService.queryForList(participantTemp);
                if(luckyParticipantList.size()>0){
                    for(int i=0;i<luckyParticipantList.size();i++){
                        mtxLuckyParticipantService.delete(luckyParticipantList.get(i));
                    }
                }
                String activityParticipant[] = request.getParameterValues("users");
                if(StringUtils.isNotBlank(uuid) && null != activityParticipant){
                    MtxActivityParticipant tempActivityParticipant = new MtxActivityParticipant();
                    tempActivityParticipant.setActivityid(uuid);
                    List<MtxActivityParticipant> tempActivityParticipantList = mtxActivityParticipantService.queryForList(tempActivityParticipant);
                    if(null !=  tempActivityParticipantList && tempActivityParticipantList.size() != activityParticipant.length){
                        for(String participantId : activityParticipant){
                            MtxLuckyParticipant luckyParticipant=new MtxLuckyParticipant();
                            luckyParticipant.setUserid(participantId);
                            luckyParticipant.setActivityid(uuid);
                            luckyParticipant.setStatus("WAIT_WIN");
                            mtxLuckyParticipantService.insert(luckyParticipant);
                        }
                    }
                }
            }
        }

        String totalLuckyCount = request.getParameter("totalLuckyCount");
        String everyLuckyCount = request.getParameter("everyLuckyCount");
        String versionno = request.getParameter("versionno");
        MtxActivity mtxActivity = new MtxActivity();
        mtxActivity.setUuid(uuid);
        mtxActivity.setVersionno(Integer.valueOf(versionno));
        mtxActivity.setTotalLuckyCount(Integer.valueOf(totalLuckyCount));
        mtxActivity.setEveryLuckyCount(Integer.valueOf(everyLuckyCount));
        mtxActivityService.updatePartial(mtxActivity);
        String fromPhone  = request.getParameter("fromPhone");
        if(StringUtils.isNotBlank(message)){
            redirectAttributes.addFlashAttribute("message",message);
        }
        if("Y".equals(fromPhone)){
            redirectAttributes.addFlashAttribute("successMessage","保存成功");
            return "redirect:/admin/wefamily/mtxActivityInfoForPhone?activityId="+uuid;
        }
        return "redirect:/admin/wefamily/goMtxActivity?uuid="+uuid+"&successFlg=1";
    }

    /**
     * 手机活动列表
     */
    @RequestMapping(value = "/mtxActivityManageForPhone",method = RequestMethod.GET)
    public String activity_list(Model model) {

        List<Merchant> merchantList = merchantService.selectMerchantForUser();
        List<MtxActivity> mtxActivityList = mtxActivityService.queryActivityListForPhone(merchantList);
        model.addAttribute("mtxActivityList",mtxActivityList);
        return "admin/wefamily/mtxActivityManageForPhone";
    }

    /**
     * 手机活动详情
     */
    @RequestMapping(value = "/mtxActivityInfoForPhone",method = RequestMethod.GET)
    public String mtxActivityInfoForPhone(Model model,HttpServletRequest request) {

        String activityId = request.getParameter("activityId");
        String participantname = request.getParameter("participantname");
        model.addAttribute("participantname",participantname);
        String participantphone = request.getParameter("participantphone");
        model.addAttribute("participantphone",participantphone);
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

                MtxActivityParticipant mtxActivityParticipant = new MtxActivityParticipant();
                mtxActivityParticipant.setActivityid(activityId);
                mtxActivityParticipant.setName(participantname);
                mtxActivityParticipant.setContactno(participantphone);
                List<MtxActivityParticipant> activityParticipantList = mtxActivityParticipantService.queryForParticipantList(mtxActivityParticipant);
                model.addAttribute("activityParticipantList",activityParticipantList);

                MtxLuckyParticipant luckyParticipant = new MtxLuckyParticipant();
                luckyParticipant.setActivityid(activityId);
                List<MtxLuckyParticipant> luckyParticipantList = mtxLuckyParticipantService.queryForLuckyParticipantList(luckyParticipant,"");
                model.addAttribute("luckyParticipantList",luckyParticipantList);


                mtxActivityParticipant.setStatus("WIN");
                List<MtxActivityParticipant> winParticipantList = mtxActivityParticipantService.queryForParticipantList(mtxActivityParticipant);
                model.addAttribute("winParticipantList",winParticipantList);
            }
        }

        return "admin/wefamily/mtxActivityInfoForPhone";
    }

    @RequestMapping(value = "/uploadActivityImg",method = RequestMethod.POST)
    public String uploadActivityImg(HttpServletRequest request,RedirectAttributes redirectAttributes){
        String activityId = request.getParameter("activityId");
        String[] activityImgs = request.getParameterValues("activityImg");
        for(String img : activityImgs){
            Attachment attachment = new Attachment();
            attachment.setRefid(activityId);
            attachment.setName(img);
            attachmentService.insert(attachment);
        }
        redirectAttributes.addFlashAttribute("successMessage","上传成功！");
        return "redirect:/admin/wefamily/mtxActivityInfoForPhone?activityId="+activityId;
    }

    /**
     * 查询首页报修数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/qualityMgmtAsy", method = RequestMethod.GET)
    @ResponseBody
    public int qualityMgmtAsy(HttpServletRequest request,Model model){
        String merchantId = request.getParameter("merchantId");
        String status = request.getParameter("status");
        String type = request.getParameter("type");

        QualityMgmt qualityMgmt = new QualityMgmt();
        qualityMgmt.setMerchantid(merchantId);
        qualityMgmt.setStatus(status);
        qualityMgmt.setType(type);
        String unDistributed = request.getParameter("unDistributed");
        if("Y".equals(unDistributed)){
            qualityMgmt.setMerchantid(unDistributed);
            model.addAttribute("unDistributed",unDistributed);
        }
        List<QualityMgmt> qualityMgmtList = qualityMgmtService.queryQualityMgmtAsy(qualityMgmt);
        int count = qualityMgmtList.size();
        return count;
    }

    /**
     * 查询首页订单数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/orderAsy", method = RequestMethod.GET)
    @ResponseBody
    public int orderAsy(HttpServletRequest request){
        String merchantId = request.getParameter("merchantId");
        String status = request.getParameter("status");

        Order order = new Order();
        order.setMerchantid(merchantId);
        order.setStatus(status);
        List<Order> orderList = orderService.queryOrderListForHomeData(order);
        int count = orderList.size();
        return count;
    }

    @RequestMapping(value = "/downloadMachinePartTpl")
    public void downloadMachinePartTpl(HttpServletRequest request, HttpServletResponse response){
        Map<String,List> beanParams = new HashMap<String, List>();
        Machine machine=new Machine();
        List<Machine> machineList = new ArrayList<>();
        machineList.add(machine);
        beanParams.put("machine", machineList);
        //导出
        ExportUtil.exportExcel(beanParams, "/tpl/partsTpl.xls", response);
    }

    @RequestMapping(value = "/downloadAddressTpl")
    public void downloadAddressTpl(HttpServletRequest request, HttpServletResponse response){
        Map<String,List> beanParams = new HashMap<String, List>();
        String type = request.getParameter("type");
        String dormitoryId = request.getParameter("dormitoryId");

        Address address = new Address();
        address.setDormitoryid(dormitoryId);
        List<Address> addressList = new ArrayList<>();
        addressList.add(address);
        beanParams.put("address", addressList);
        //导出
        if("N".equals(type)){
            ExportUtil.exportExcel(beanParams, "/tpl/normalAddressTpl.xls", response);
        }else{
            ExportUtil.exportExcel(beanParams, "/tpl/flatAddressTpl.xls", response);
        }
    }

    @RequestMapping(value = "/importAddressInfo", method = RequestMethod.POST)
    public String importAddressInfo(@RequestParam(value = "fileUrl", required = false)MultipartFile multipartFile,
                                  Model model,RedirectAttributes redirectAttributes,HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<>();
        if(!multipartFile.isEmpty()){
            try {
                InputStream inputStream = multipartFile.getInputStream();
                addressImportService.importAddressData(inputStream,resultMap);
                if(null != resultMap.get("fileEmptyMsg")||null!=resultMap.get("layerErrorMsg")
                        || null != resultMap.get("roomnoErrorMsg") || null != resultMap.get("uniqueErrorMsg")
                        || null != resultMap.get("areaErrorMsg")){
                    model.addAttribute("fileEmptyMsg", resultMap.get("fileEmptyMsg"));
                    model.addAttribute("layerErrorMsg", resultMap.get("layerErrorMsg"));
                    model.addAttribute("roomnoErrorMsg", resultMap.get("roomnoErrorMsg"));
                    model.addAttribute("areaErrorMsg", resultMap.get("areaErrorMsg"));
                    model.addAttribute("uniqueErrorMsg", resultMap.get("uniqueErrorMsg"));

                    WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
                    model.addAttribute("wechatBinding", wechatBinding);
                    return "admin/wefamily/addressManage";
                }else{
                    redirectAttributes.addFlashAttribute("successMessages", "导入成功");
                }
            } catch (Exception e) {
                model.addAttribute("errorMessage", "导入失败");
                model.addAttribute("uniqueErrorMsg", resultMap.get("uniqueErrorMsg"));
                WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
                model.addAttribute("wechatBinding", wechatBinding);
                return "admin/wefamily/addressManage";
            }
        }
        String dormitoryId = request.getParameter("dormitoryId");
        return "redirect:/admin/wefamily/addressManage?dormitoryId="+dormitoryId;
    }

    @RequestMapping(value = "/importPartsInfo", method = RequestMethod.POST)
    public String importPartsInfo(@RequestParam(value = "fileUrl", required = false)MultipartFile multipartFile,
                                     Model model,RedirectAttributes redirectAttributes){
        Map<String, Object> resultMap = new HashMap<>();
        if(!multipartFile.isEmpty()){
            try {
                InputStream inputStream = multipartFile.getInputStream();
                partsImportService.importPartsData(inputStream,resultMap);
                if(null != resultMap.get("fileEmptyMsg")||null!=resultMap.get("modelErrorMsg")
                        || null != resultMap.get("machinenoErrorMsg") || null != resultMap.get("uniqueErrorMsg")
                        || null != resultMap.get("formatErrorMsg") || null != resultMap.get("nameErrorMsg")
                        || null != resultMap.get("priceErrorMsg") || null != resultMap.get("instructionErrorMsg")
                        || null != resultMap.get("remarksErrorMsg")){
                    model.addAttribute("fileEmptyMsg", resultMap.get("fileEmptyMsg"));
                    model.addAttribute("modelErrorMsg", resultMap.get("modelErrorMsg"));
                    model.addAttribute("machinenoErrorMsg", resultMap.get("machinenoErrorMsg"));
                    model.addAttribute("formatErrorMsg", resultMap.get("formatErrorMsg"));
                    model.addAttribute("nameErrorMsg", resultMap.get("nameErrorMsg"));
                    model.addAttribute("instructionErrorMsg", resultMap.get("instructionErrorMsg"));
                    model.addAttribute("uniqueErrorMsg", resultMap.get("uniqueErrorMsg"));
                    model.addAttribute("priceErrorMsg",resultMap.get("priceErrorMsg"));
                    model.addAttribute("remarksErrorMsg",resultMap.get("remarksErrorMsg"));
                    WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
                    model.addAttribute("wechatBinding", wechatBinding);
                    return "admin/wefamily/mtxPartsCenterManage";
                }else{
                    redirectAttributes.addFlashAttribute("successMessages", "导入成功");
                }
            } catch (Exception e) {
                model.addAttribute("errorMessage", "导入失败");
                model.addAttribute("uniqueErrorMsg", resultMap.get("uniqueErrorMsg"));
                WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
                model.addAttribute("wechatBinding", wechatBinding);
                return "admin/wefamily/mtxPartsCenterManage";
            }
        }
        return "redirect:/admin/wefamily/mtxPartsCenterManage";
    }

    //购机用户
    @RequestMapping(value = "/goBuyUser", method = RequestMethod.GET)
    public String goBuyUser(String uuid,Model model){

        if(StringUtils.isNotBlank(uuid)) {
            MtxLuckyParticipant luck=new MtxLuckyParticipant();;
            luck.setActivityid(uuid);
            List<MtxLuckyParticipant> luckList=mtxLuckyParticipantService.queryForLuckyParticipantList(luck,"");
            model.addAttribute("luckList",luckList);
        }
        return "/admin/wefamily/activity_center_buy";
    }

    //点击抽奖
    @RequestMapping(value = "/clickDrawing", method = RequestMethod.GET)
    public String clickDrawing(String uuid,Model model){
        if(StringUtils.isNotBlank(uuid)){
            MtxActivity activityTemp=new MtxActivity();
            activityTemp.setUuid(uuid);
            activityTemp=mtxActivityService.queryForObjectByPk(activityTemp);
            MtxActivityParticipant activityParticipant=new MtxActivityParticipant();
            MtxActivityParticipant participant=new MtxActivityParticipant();
            activityParticipant.setActivityid(uuid);
            participant.setActivityid(uuid);
            participant.setStatus("WIN");
            //总人数
            List<MtxActivityParticipant> activityParticipantList=mtxActivityParticipantService.queryForWaitDrawingList(activityParticipant);
            //中奖人名单
            List<MtxActivityParticipant> winList=mtxActivityParticipantService.queryForParticipantList(participant);
            MtxActivity activity=new MtxActivity();
            activity.setUuid(uuid);
            activity=mtxActivityService.queryForObjectByPk(activity);
            if(winList.size()!=activityTemp.getTotalLuckyCount()){
                activity.setStatus("DRAWING");
                mtxActivityService.updatePartial(activity);
            }
            //待抽奖人
            List<MtxActivityParticipant> otherWaitPList=mtxActivityParticipantService.queryForWaitDrawingList(participant);
            model.addAttribute("activityParticipantList",activityParticipantList);
            model.addAttribute("winList",winList);
            MtxLuckyParticipant luckyParticipant=new MtxLuckyParticipant();
            luckyParticipant.setActivityid(uuid);
            luckyParticipant.setStatus("WIN");
            List<MtxLuckyParticipant> luckyParticipantList=mtxLuckyParticipantService.queryForLuckyParticipantList(luckyParticipant,"0");
            List<MtxLuckyParticipant> selectLuckyParticipantList=mtxLuckyParticipantService.queryForLuckyParticipantList(luckyParticipant,"1");
            List<MtxLuckyParticipant> totalLuckyParticipantList=mtxLuckyParticipantService.queryForLuckyParticipantList(luckyParticipant,"");
            if(totalLuckyParticipantList.size()>0 &&totalLuckyParticipantList.size()==selectLuckyParticipantList.size()){
                model.addAttribute("stop","stop");
            }
            if(luckyParticipantList.size()>0){
                model.addAttribute("luckyParticipantList",luckyParticipantList);
            }else{
                model.addAttribute("luckyParticipantList",otherWaitPList);
            }
            model.addAttribute("totalLuckyCount",activityTemp.getTotalLuckyCount());
            model.addAttribute("everyLuckyCount",activityTemp.getEveryLuckyCount());
        }
        model.addAttribute("uuid",uuid);
        return "/admin/wefamily/activity_center";
    }

    @RequestMapping(value = "/drawing")
    public void drawing(String uuid,String winnerId,int totalnumber){
        if(StringUtils.isNotBlank(uuid)&&StringUtils.isNotBlank(winnerId)){
            mtxActivityService.updateParticipant(uuid,winnerId,totalnumber);
        }
    }

    @RequestMapping(value = "/getTotalLuckyParticipant", method = RequestMethod.POST)
    @ResponseBody
    public Map getTotalLuckyParticipant(MtxActivity activity){
        activity=mtxActivityService.queryForObjectByPk(activity);
        Map<String, Object> resultMap = new HashMap<String, Object>();

        MtxActivityParticipant participant=new MtxActivityParticipant();
        participant.setActivityid(activity.getUuid());
        participant.setStatus("WIN");
        //待抽奖人
        List<MtxActivityParticipant> otherWaitPList=mtxActivityParticipantService.queryForWaitDrawingList(participant);

        MtxLuckyParticipant luckyParticipant=new MtxLuckyParticipant();
        luckyParticipant.setActivityid(activity.getUuid());
        luckyParticipant.setStatus("WIN");
        List<MtxLuckyParticipant> luckyParticipantList=mtxLuckyParticipantService.queryForLuckyParticipantList(luckyParticipant,"0");


        if(null!=activity){
            resultMap.put("totalLuckyCount", activity.getTotalLuckyCount());
            resultMap.put("everyLuckyCount", activity.getEveryLuckyCount());
            resultMap.put("currentLuckyCount", activity.getCurrentLuckyCount());
            if(luckyParticipantList.size()>0){
                resultMap.put("luckyParticipantList", luckyParticipantList);
            }else{
                resultMap.put("luckyParticipantList", otherWaitPList);
            }
        }
        return resultMap;
    }
}