package com.dorm.family.service;

import com.dorm.common.base.BaseService;
import com.dorm.common.entity.Attachment;
import com.dorm.common.service.AttachmentService;
import com.dorm.common.service.SequenceService;
import com.dorm.common.utils.StringUtils;
import com.dorm.common.utils.UserUtils;
import com.dorm.family.entity.Address;
import com.dorm.family.entity.Repair;
import com.dorm.family.entity.Student;
import com.dorm.family.mapper.AddressMapper;
import com.dorm.family.mapper.RepairMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class RepairService extends BaseService<RepairMapper,Repair> {

    @Autowired
    public void setMapper(RepairMapper mapper) {
        super.setMapper(mapper);
    }

    @Autowired
    private StudentService studentService;
    @Autowired
    private SequenceService sequenceService;
    @Autowired
    private AttachmentService attachmentService;


    public String saveReportRepairInfo(Repair repair, String[] repairImgs) {
        String returnMsg = "";

        //根据姓名、号码查询用户
        if(StringUtils.isBlank(repair.getReporter())){

            String type = repair.getType();
            if("STUDENT".equals(type)){
                Student student = new Student();
                student.setStuno(repair.getReporterstuno());
                student = studentService.queryForObjectByUniqueKey(student);
                if(null != student){
                    repair.setReporter(student.getUuid());
                }
            }else{
                repair.setReporter(UserUtils.getUserId());
            }
        }

        if(StringUtils.isNotBlank(repair.getUuid())){
            this.mapper.updatePartial(repair);
        }else{
            repair.setBindid(UserUtils.getUserBindId());
            repair.setSnno(sequenceService.getRepairSeqNo());

            repair.setStatus("NEW");
            this.mapper.insert(repair);
        }

        if(null != repairImgs){
            for(String img : repairImgs){
                Attachment attachment = new Attachment();
                attachment.setRefid(repair.getUuid());
                attachment.setName(img);
                attachment.setType("reporter");
                attachmentService.insert(attachment);
            }
        }

        return returnMsg;
    }

    public void saveRepairInfo(Repair repair, String[] workerImgs) {
        this.updatePartial(repair);

        if(null != workerImgs){
            for(String img : workerImgs){
                Attachment attachment = new Attachment();
                attachment.setRefid(repair.getUuid());
                attachment.setName(img);
                attachment.setType("worker");
                attachmentService.insert(attachment);
            }
        }
    }

    public void finishRepair(Repair tempRepair) {
        tempRepair.setStatus("FINISH");
        this.mapper.updatePartial(tempRepair);
    }
}
