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
public class DormGuestController extends BaseGuestController{
    private Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private WechatBindingService wechatBindingService;

    @Autowired
    private WechatUserInfoService wechatUserInfoService;

    @Autowired
    private WpUserService wpUserService;

    @Autowired
    private SequenceService sequenceService;
    @Autowired
    private AttachmentService attachmentService;
    @Autowired
    private StudentService studentService;
    @Autowired
    private RepairService repairService;
    @Autowired
    private DormitoryService dormitoryService;
    @Autowired
    private PlatformUserService platformUserService;
    @Autowired
    private ConsultService consultService;
    @Autowired
    private HygieneService hygieneService;
    @Autowired
    private EchargeService echargeService;

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
            return "redirect:/guest/consult_list?stuId="+student.getUuid();
        }else if("HYGIENE".equals(type)){
            return "redirect:/guest/hygiene_list?stuId="+student.getUuid();
        }else if("VIOLATION".equals(type)){
            return "redirect:/guest/violation_list?stuno="+stuno;
        }else{
            return "redirect:/guest/echarge_list?stuId="+student.getUuid();
        }

    }


    /**
     * 卫生列表
     */
    @RequestMapping(value = "/hygiene_list",method = RequestMethod.GET)
    public String hygiene_list(HttpServletRequest request,Model model){

        String stuId = request.getParameter("stuId");
        model.addAttribute("stuId",stuId);

        List<Hygiene> hygieneList = hygieneService.queryHygieneListByStuId(stuId);
        model.addAttribute("hygieneList",hygieneList);
        return "guest/hygiene_list";
    }

    /**
     * 电费列表
     */
    @RequestMapping(value = "/echarge_list",method = RequestMethod.GET)
    public String echarge_list(HttpServletRequest request,Model model){

        String stuId = request.getParameter("stuId");
        model.addAttribute("stuId",stuId);

        Echarge echarge = new Echarge();
        echarge.setStuid(stuId);

        List<Echarge> echargeList = echargeService.queryForList(echarge);
        model.addAttribute("echargeList",echargeList);
        return "guest/hygienecharge_liste_list";
    }

    /**
     * 卫生详情
     */
    @RequestMapping(value = "/hygiene_info",method = RequestMethod.GET)
    public String hygiene_info(HttpServletRequest request,Model model){
        String stuId = request.getParameter("stuId");
        model.addAttribute("stuId",stuId);
        String hygieneId = request.getParameter("hygieneId");
        if(StringUtils.isNotBlank(hygieneId)){
            Hygiene hygiene = new Hygiene();
            hygiene.setUuid(hygieneId);
            hygiene = hygieneService.queryForObjectByPk(hygiene);
            model.addAttribute("hygiene", hygiene);
        }
        return "guest/hygiene_info";
    }


    /**
     * 咨询列表
     */
    @RequestMapping(value = "/consult_list",method = RequestMethod.GET)
    public String consult_list(HttpServletRequest request,Model model){

        String stuId = request.getParameter("stuId");
        model.addAttribute("stuId",stuId);

        Consult consult = new Consult();
        consult.setStuid(stuId);
        consult.setOrderby("createon desc");
        List<Consult> consultList = consultService.queryForList(consult);
        model.addAttribute("consultList",consultList);
        return "guest/consult_list";
    }

    /**
     * 报修信息
     */
    @RequestMapping(value = "/consult_add",method = RequestMethod.GET)
    public String consult_add(Model model,HttpServletRequest request){
        String stuId = request.getParameter("stuId");
        Student student = new Student();
        student.setUuid(stuId);
        student = studentService.queryForObjectByPk(student);
        model.addAttribute("student",student);

        Dormitory dormitory = new Dormitory();
        dormitory.setUuid(student.getDormitoryid());
        dormitory = dormitoryService.queryForObjectByPk(dormitory);
        model.addAttribute("dormitory",dormitory);

        return "guest/consult_add";
    }

    /**
     * 报修信息
     */
    @RequestMapping(value = "/consult_add",method = RequestMethod.POST)
    public String consult_add(Consult consult, RedirectAttributes redirectAttributes, HttpServletRequest request){

        //添加
        consult.setStatus("N_REPLY");
        consultService.insert(consult);
        redirectAttributes.addFlashAttribute("successMessage", "保存成功");

        return "redirect:/guest/consult_list?stuId="+consult.getStuid();
    }

    /**
     * 咨询详情
     */
    @RequestMapping(value = "/consult_info",method = RequestMethod.GET)
    public String consult_info(HttpServletRequest request,Model model){
        String consultId = request.getParameter("consultId");
        if(StringUtils.isNotBlank(consultId)){
            Consult consult = new Consult();
            consult.setUuid(consultId);
            consult = consultService.queryForObjectByPk(consult);
            model.addAttribute("consult", consult);
        }
        return "guest/consult_info";
    }

    /**
     * 报修详情
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

        return "redirect:/guest/repair_list?stuId="+repair.getReporter();
    }

}