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
    private SequenceService sequenceService;
    @Autowired
    private WpUserService wpUserService;
    @Autowired
    private AttachmentService attachmentService;
    @Autowired
    private CommonCodeService commonCodeService;
    @Autowired
    private PlatformUserService platformUserService;
    @Autowired
    private PlatformRoleService platformRoleService;
    @Autowired
    private DormitoryService dormitoryService;
    @Autowired
    private AddressService addressService;
    @Autowired
    private AddressImportService addressImportService;
    @Autowired
    private StudentService studentService;
    @Autowired
    private RepairService repairService;
    @Autowired
    private ConsultService consultService;
    @Autowired
    private HygieneService hygieneService;
    @Autowired
    private EchargeService echargeService;


    /**
     * 电费记录
     */
    @RequestMapping(value = "/echargeManage",method = RequestMethod.GET)
    public String echargeManage(Model model, HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);

        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

        return "admin/wefamily/echargeManage";
    }

    /**
     * 卫生管理
     * @param echarge
     * @param model
     * @return
     */
    @RequestMapping(value = "/echargeManage",method = RequestMethod.POST)
    public String echargeManage(@RequestParam(required = false,defaultValue = "1") int page, Echarge echarge, Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        model.addAttribute("echarge",echarge);

        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

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
            PageList<Echarge> echargePageList = echargeService.getEchargePageList(echarge, startDateTimeStr, endDateTimeStr, pageBounds);
            model.addAttribute("echargePageList", echargePageList);

            //删除结果
            String deleteFlag = request.getParameter("deleteFlag");
            if("1".equals(deleteFlag)){
                model.addAttribute("successMessage", "删除成功");
            }else if("0".equals(deleteFlag)){
                model.addAttribute("errorMessage", "删除失败");
            }
        }

        return "admin/wefamily/echargeManage";
    }


    @RequestMapping(value = "/echargeInfo",method = RequestMethod.GET)
    public String echargeInfo(HttpServletRequest request,Model model){

        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

        String echargeId = request.getParameter("echargeId");
        if(StringUtils.isNotBlank(echargeId)){
            Echarge echarge = new Echarge();
            echarge.setUuid(echargeId);
            echarge = echargeService.queryForObjectByPk(echarge);
            model.addAttribute("echarge",echarge);
            if(null != echarge){
                Dormitory dormitory = new Dormitory();
                dormitory.setUuid(echarge.getDormitoryid());
                dormitory = dormitoryService.queryForObjectByPk(dormitory);
                model.addAttribute("dormitory",dormitory);

                if(StringUtils.isNotBlank(echarge.getStuid())){
                    Student student = new Student();
                    student.setUuid(echarge.getStuid());
                    student = studentService.queryForObjectByPk(student);
                    model.addAttribute("student",student);
                }
            }
        }
        return "admin/wefamily/echargeInfo";
    }

    /**
     *  卫生信息
     * @return
     */
    @RequestMapping(value = "/echargeInfo", method = RequestMethod.POST)
    public String echargeInfo(Echarge echarge, Model model,HttpServletRequest request,RedirectAttributes redirectAttributes) {
        //检查缴费学号 是否存在
        Student student = new Student();
        student.setStuno(echarge.getStuno());
        student = studentService.queryForObjectByUniqueKey(student);

        if (null == student) {
            model.addAttribute("errorMessage", "抱歉，缴费学生学号不正确！");
            model.addAttribute("echarge",echarge);
            List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
            model.addAttribute("dormitoryList",dormitoryList);
            return "admin/wefamily/echargeInfo";
        } else {
            //修改
            if (StringUtils.isNotBlank(echarge.getUuid())) {
                try {
                    echargeService.updatePartial(echarge);
                    redirectAttributes.addFlashAttribute("successMessage", "保存成功！");
                } catch (ServiceException e) {
                    redirectAttributes.addFlashAttribute("errorMessage", "系统忙，稍候再试！");
                }
                echarge = echargeService.queryForObjectByPk(echarge);
            } else {
                //添加
                echarge.setSnno(sequenceService.getEchargeSeqNo());
                echarge.setStuid(student.getUuid());
                echargeService.insert(echarge);
                redirectAttributes.addFlashAttribute("successMessage", "保存成功！");
            }
        }
        return "redirect:/admin/wefamily/echargeInfo?echargeId="+echarge.getUuid();
    }



    /**
     * 卫生管理
     */
    @RequestMapping(value = "/hygieneManage",method = RequestMethod.GET)
    public String hygieneManage(Model model, HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);

        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

        Date now = new Date();
        Calendar c = Calendar.getInstance();
        c.setTime(now);
        c.set(Calendar.DAY_OF_YEAR, 1);
        Date currYearFirst = c.getTime();
        String startDateStr = DateUtils.formatDate(currYearFirst,"yyyy-MM-dd");
        model.addAttribute("startDateStr",startDateStr);

        return "admin/wefamily/hygieneManage";
    }

    /**
     * 卫生管理
     * @param hygiene
     * @param model
     * @return
     */
    @RequestMapping(value = "/hygieneManage",method = RequestMethod.POST)
    public String hygieneManage(@RequestParam(required = false,defaultValue = "1") int page, Hygiene hygiene, Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        model.addAttribute("hygiene",hygiene);

        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

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
            PageList<Hygiene> hygienePageList = hygieneService.getHygienePageList(hygiene, startDateTimeStr, endDateTimeStr, pageBounds);
            model.addAttribute("hygienePageList", hygienePageList);

            //删除结果
            String deleteFlag = request.getParameter("deleteFlag");
            if("1".equals(deleteFlag)){
                model.addAttribute("successMessage", "删除成功");
            }else if("0".equals(deleteFlag)){
                model.addAttribute("errorMessage", "删除失败");
            }
        }

        return "admin/wefamily/hygieneManage";
    }


    @RequestMapping(value = "/hygieneInfo",method = RequestMethod.GET)
    public String hygieneInfo(HttpServletRequest request,Model model){

        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

        String hygieneId = request.getParameter("hygieneId");
        if(StringUtils.isNotBlank(hygieneId)){
            Hygiene hygiene = new Hygiene();
            hygiene.setUuid(hygieneId);
            hygiene = hygieneService.queryForObjectByPk(hygiene);
            model.addAttribute("hygiene",hygiene);
            if(null != hygiene){
                Dormitory dormitory = new Dormitory();
                dormitory.setUuid(hygiene.getDormitoryid());
                dormitory = dormitoryService.queryForObjectByPk(dormitory);
                model.addAttribute("dormitory",dormitory);
            }
        }
        return "admin/wefamily/hygieneInfo";
    }


    /**
     *  卫生信息
     * @return
     */
    @RequestMapping(value = "/hygieneInfo", method = RequestMethod.POST)
    public String hygieneInfo(Hygiene hygiene, Model model,HttpServletRequest request,RedirectAttributes redirectAttributes) {
        //检查是否重复
        Hygiene hygienetForRepeat = hygieneService.getHygieneForSave(hygiene);

        if (null != hygienetForRepeat) {
            model.addAttribute("errorMessage", "抱歉，该时间卫生信息已存在！");
            model.addAttribute("hygiene",hygiene);
            List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
            model.addAttribute("dormitoryList",dormitoryList);
            return "admin/wefamily/hygieneInfo";
        } else {
            //修改
            Integer total = hygiene.getGround() + hygiene.getDesk() + hygiene.getBed() + hygiene.getBalcony() + hygiene.getToilet();
            hygiene.setTotal(total);
            if (StringUtils.isNotBlank(hygiene.getUuid())) {
                try {
                    hygieneService.updatePartial(hygiene);
                    redirectAttributes.addFlashAttribute("successMessage", "保存成功！");
                } catch (ServiceException e) {
                    redirectAttributes.addFlashAttribute("errorMessage", "系统忙，稍候再试！");
                }
                hygiene = hygieneService.queryForObjectByPk(hygiene);
            } else {
                //添加

                hygieneService.insert(hygiene);
                redirectAttributes.addFlashAttribute("successMessage", "保存成功！");
            }
        }
        return "redirect:/admin/wefamily/hygieneInfo?hygieneId="+hygiene.getUuid();
    }


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
     * 宿舍楼界面
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
     * 咨询管理
     */
    @RequestMapping(value = "/consultManage",method = RequestMethod.GET)
    public String mtxReserveManage(Model model, HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);

        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

        String fromHome = request.getParameter("fromHome");
        if("Y".equals(fromHome)){
            String dormitoryid = request.getParameter("dormitoryId");
            String status = request.getParameter("status");

            Consult consult = new Consult();
            consult.setDormitoryid(dormitoryid);
            consult.setStatus(status);

            String startDateStr = request.getParameter("startDateStr");
            model.addAttribute("startDateStr",startDateStr);

            String endDateStr = request.getParameter("endDateStr");
            model.addAttribute("endDateStr",endDateStr);

            PageBounds pageBounds = new PageBounds(1, PortalContants.PAGE_SIZE);
            PageList<Consult> consultPageList = consultService.getConsultPageList(consult,startDateStr,endDateStr,pageBounds);
            model.addAttribute("consultPageList",consultPageList);
            model.addAttribute("consult",consult);
        }

        return "admin/wefamily/consultManage";
    }


    /**
     * 咨询管理
     * @param consult
     * @param model
     * @return
     */
    @RequestMapping(value = "/consultManage",method = RequestMethod.POST)
    public String consultManage(@RequestParam(required = false,defaultValue = "1") int page, Consult consult, Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        model.addAttribute("consult",consult);

        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

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
            PageList<Consult> consultPageList = consultService.getConsultPageList(consult, startDateTimeStr, endDateTimeStr, pageBounds);
            model.addAttribute("consultPageList", consultPageList);

            //删除结果
            String deleteFlag = request.getParameter("deleteFlag");
            if("1".equals(deleteFlag)){
                model.addAttribute("successMessage", "删除成功");
            }else if("0".equals(deleteFlag)){
                model.addAttribute("errorMessage", "删除失败");
            }
        }

        return "admin/wefamily/consultManage";
    }

    @RequestMapping(value = "/consultInfo",method = RequestMethod.GET)
    public String consultInfo(HttpServletRequest request,Model model){
        String consultId = request.getParameter("consultId");
        if(StringUtils.isNotBlank(consultId)){
            Consult consult = new Consult();
            consult.setUuid(consultId);
            consult = consultService.queryForObjectByPk(consult);
            model.addAttribute("consult",consult);
            if(null != consult){
                Student student = new Student();
                student.setUuid(consult.getStuid());
                student = studentService.queryForObjectByPk(student);
                model.addAttribute("student",student);
                if(null != student){
                    Dormitory dormitory = new Dormitory();
                    dormitory.setUuid(student.getDormitoryid());
                    dormitory = dormitoryService.queryForObjectByPk(dormitory);
                    model.addAttribute("dormitory",dormitory);
                }
            }
        }
        return "admin/wefamily/consultInfo";
    }

    @RequestMapping(value = "/consultInfo",method = RequestMethod.POST)
    public String consultInfo(Consult consult,RedirectAttributes redirectAttributes){

        consultService.updatePartial(consult);
        redirectAttributes.addFlashAttribute("successMessage","回复成功！");
        return "redirect:/admin/wefamily/consultInfo?consultId="+consult.getUuid();
    }

    /**
     * 报修管理
     */
    @RequestMapping(value = "/repairManage",method = RequestMethod.GET)
    public String repairManage(Model model,HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

        String fromHome = request.getParameter("fromHome");
        if("Y".equals(fromHome)){
            PageBounds pageBounds = new PageBounds(1, PortalContants.PAGE_SIZE);
            Repair repair = new Repair();
            repair.setDormitoryid(request.getParameter("dormitoryId"));
            //多选状态框 默认选中 所需字符串
            String statusStr = request.getParameter("status");
            model.addAttribute("statusStr",statusStr);
            String[] statusArr = request.getParameterValues("status");
            repair.setStatusArr(statusArr);

            String startDateStr = request.getParameter("startDateStr");
            model.addAttribute("startDateStr",startDateStr);

            String endDateStr = request.getParameter("endDateStr");
            model.addAttribute("endDateStr",endDateStr);

            PageList<Repair> repairPageList = repairService.getRepairPageList(repair, startDateStr, endDateStr, pageBounds);
            model.addAttribute("repairPageList", repairPageList);
            model.addAttribute("repair",repair);
        }

        return "admin/wefamily/repairManage";
    }

    /**
     * 获取处理人列表
     * @return
     */
    @RequestMapping(value = "/{dormitoryId}/dealRepairPerson", produces = "application/json")
    public @ResponseBody Map<String, Object> getdealRepairPersonJson(@PathVariable("dormitoryId") String dormitoryId,HttpServletRequest request){


        List<PlatformUser> workerList = platformUserService.getWorkersByDormitoryId(dormitoryId);

        Map<String, Object> responseMap = new HashMap<String, Object>();
        responseMap.put("workerList",workerList);
        return responseMap;
    }

    /**
     *指派工人
     */
    @RequestMapping(value = "/addWorkerForRepair",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> addWorkerForRepair(HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        String repairId = request.getParameter("repairId");
        String versionno = request.getParameter("versionno");
        String workerId = request.getParameter("workerId");
        Repair repair = new Repair();
        repair.setUuid(repairId);
        repair.setVersionno(Integer.valueOf(versionno));
        repair.setWorker(workerId);
        repair.setStatus("REPAIRING");

        try {
            repairService.updatePartial(repair);
            resultMap.put("successMessage", "指派成功");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            resultMap.put("errorMessage", "系统忙，稍候再试");
        }


        return resultMap;
    }

    /**
     * 报修管理
     * @param repair
     * @param model
     * @return
     */
    @RequestMapping(value = "/repairManage",method = RequestMethod.POST)
    public String repairManage(@RequestParam(required = false,defaultValue = "1") int page, Repair repair, Model model, HttpServletRequest request){
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);
        model.addAttribute("repair",repair);

        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

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
            repair.setStatusArr(statusArr);

            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<Repair> repairPageList = repairService.getRepairPageList(repair, startDateTimeStr, endDateTimeStr, pageBounds);
            model.addAttribute("repairPageList", repairPageList);

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
     * 导出报修查询结果
     */
    @RequestMapping(value = "/exportRepairList",method = RequestMethod.POST)
    public void exportRepairList(Repair repair, HttpServletRequest request, HttpServletResponse response){
        Map<String,List> beanParams = new HashMap<String, List>();

        String startDateStr = request.getParameter("startDateStr");
        String endDateStr = request.getParameter("endDateStr");
        Date startDate = DateUtils.parseDate(startDateStr);
        Date endDate = DateUtils.parseDate(endDateStr);
        startDate = DateUtils.getDateStart(startDate);
        endDate = DateUtils.getDateEnd(endDate);

        String[] statusArr = request.getParameterValues("status");
        String statusStr = "";
        if(null != statusArr){
            statusStr = StringUtils.join(statusArr, ",");
        }
        if(null != statusArr && statusArr.length == 1 && StringUtils.isBlank(statusArr[0])){
            statusArr = null;
        }
        repair.setStatusArr(statusArr);

        List<Repair> repairListForExport = repairService.getRepairListForExport(repair,startDateStr,endDateStr);
        beanParams.put("repairListForExport", repairListForExport);

        //导出
        ExportUtil.exportExcel(beanParams, "/tpl/repair.xls", response);
    }


    /**
     * 报修信息
     */
    @RequestMapping(value = "/repairInfo",method = RequestMethod.GET)
    public String repairInfo(HttpServletRequest request,Model model){
        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

        String repairId= request.getParameter("repairId");

        if(StringUtils.isNotBlank(repairId)){
            Repair repair = new Repair();
            repair.setUuid(repairId);
            repair = repairService.queryForObjectByPk(repair);


            if(StringUtils.isNotBlank(repair.getDormitoryid())){
                List<PlatformUser> workerUserList = platformUserService.getWorkersByDormitoryId(repair.getDormitoryid());
                model.addAttribute("workerUserList",workerUserList);
            }
            model.addAttribute("repair",repair);

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
     *保存报修信息
     */
    @RequestMapping(value = "/saveReportRepairInfo",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> saveReportRepairInfo(Repair repair, HttpServletRequest request){
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String[] repairImgs = request.getParameterValues("repairImg");
        String returnMsg = repairService.saveReportRepairInfo(repair,repairImgs);
        if(StringUtils.isNotBlank(returnMsg)){
            resultMap.put("returnMsg",returnMsg);
        }else{
            resultMap.put("successMessage", "保存成功");
            resultMap.put("repairId",repair.getUuid());
        }
        return resultMap;
    }
    /**
     *保存维修信息
     */
    @RequestMapping(value = "/saveRepairInfo",method= RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> saveRepairInfo(Repair repair, HttpServletRequest request, Model model){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        String workerId = request.getParameter("workerId");
        String repairId = request.getParameter("repairId");
        String versionno = request.getParameter("repairVersionno");
        repair.setUuid(repairId);
        repair.setVersionno(Integer.valueOf(versionno));
        repair.setWorker(workerId);

        String[] workerImgs = request.getParameterValues("workerImg");

        repairService.saveRepairInfo(repair,workerImgs);

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
     * 查询首页报修数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/repairAsy", method = RequestMethod.GET)
    @ResponseBody
    public int qualityMgmtAsy(HttpServletRequest request,Model model){
        String dormitoryId = request.getParameter("dormitoryId");
        String status = request.getParameter("status");


        Repair repair = new Repair();
        repair.setDormitoryid(dormitoryId);
        repair.setStatus(status);
        List<Repair> repairList = repairService.getRepairAsy(repair);
        int count = repairList.size();
        return count;
    }

    /**
     * 查询首页咨询数据
     * @param request
     * @return
     */
    @RequestMapping(value = "/consultAsy", method = RequestMethod.GET)
    @ResponseBody
    public int consultAsy(HttpServletRequest request,Model model){
        String dormitoryId = request.getParameter("dormitoryId");
        String status = request.getParameter("status");

        Consult consult = new Consult();
        consult.setDormitoryid(dormitoryId);
        consult.setStatus(status);
        List<Consult> consultList = consultService.getConsultAsy(consult);
        int count = consultList.size();
        return count;
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
}