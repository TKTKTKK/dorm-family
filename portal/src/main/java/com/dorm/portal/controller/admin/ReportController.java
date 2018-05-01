package com.dorm.portal.controller.admin;

import com.dorm.common.entity.Attachment;
import com.dorm.common.entity.PlatformUser;
import com.dorm.common.exception.ServiceException;
import com.dorm.common.service.*;
import com.dorm.common.utils.DateUtils;
import com.dorm.common.utils.StringUtils;
import com.dorm.common.utils.UserUtils;
import com.dorm.family.entity.*;
import com.dorm.family.service.*;
import com.dorm.portal.PortalContants;
import com.dorm.portal.utils.ExportUtil;
import com.dorm.wechat.entity.admin.WechatBinding;
import com.dorm.wechat.service.WechatBindingService;
import com.dorm.wechat.service.WpUserService;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
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


@Controller
@RequestMapping(value = "/admin/report")
public class ReportController extends BaseAdminController {
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
     * 报修报表
     */
    @RequestMapping(value = "/repairReportManage",method = RequestMethod.GET)
    public String echargeManage(Model model, HttpServletRequest request) {
        WechatBinding wechatBinding = wechatBindingService.getWechatBindingByUser();
        model.addAttribute("wechatBinding", wechatBinding);

        List<Dormitory> dormitoryList = dormitoryService.getDormitoryForUser();
        model.addAttribute("dormitoryList",dormitoryList);

        return "admin/wefamily/repairReportManage";
    }

    /**
     * 报修报表查询
     * @param repair
     * @param model
     * @return
     */
    @RequestMapping(value = "/repairReportManage",method = RequestMethod.POST)
    public String repairReportManage(@RequestParam(required = false,defaultValue = "1") int page, Repair repair, Model model, HttpServletRequest request){
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

            PageBounds pageBounds = new PageBounds(page, PortalContants.PAGE_SIZE);
            PageList<Repair> repairReportPageList = repairService.getRepairReportPageList(repair, startDateTimeStr, endDateTimeStr, pageBounds);
            model.addAttribute("repairReportPageList", repairReportPageList);

        }

        return "admin/wefamily/repairReportManage";
    }
}