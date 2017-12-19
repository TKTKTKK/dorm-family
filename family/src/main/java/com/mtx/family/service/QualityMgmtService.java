package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.entity.Attachment;
import com.mtx.common.mapper.AttachmentMapper;
import com.mtx.common.service.SequenceService;
import com.mtx.common.utils.StringUtils;
import com.mtx.family.entity.*;
import com.mtx.family.mapper.QualityMgmtMapper;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.mapper.WpUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class QualityMgmtService extends BaseService<QualityMgmtMapper,QualityMgmt> {

    @Autowired
    public void setMapper(QualityMgmtMapper mapper) {
        super.setMapper(mapper);
    }

    @Autowired
    private AttachmentMapper attachmentMapper;
    @Autowired
    private MerchantService merchantService;
    @Autowired
    private WorkerService workerService;
    @Autowired
    private WpUserMapper wpUserMapper;
    @Autowired
    private SequenceService sequenceService;


    public void saveQualityMgmt(QualityMgmt qualityMgmt, String[] qualityMgmtImgs) {

        this.mapper.insert(qualityMgmt);

        saveQualityMgmtImg(qualityMgmt,qualityMgmtImgs);
    }

    private void saveQualityMgmtImg(QualityMgmt qualityMgmt, String[] qualityMgmtImgs) {
        if(null != qualityMgmtImgs){
            for(String img : qualityMgmtImgs){
                Attachment attachment = new Attachment();
                attachment.setRefid(qualityMgmt.getUuid());
                attachment.setName(img);
                attachment.setType("REPORTER");
                attachmentMapper.insert(attachment);
            }
        }
    }

    public void updateQualityMgmt(QualityMgmt qualityMgmt, String[] qualityMgmtImgs) {
        this.mapper.updatePartial(qualityMgmt);

        saveQualityMgmtImg(qualityMgmt,qualityMgmtImgs);
    }

    public int distributeQualityMgmt(QualityMgmt qualityMgmt) {
        qualityMgmt.setStatus("DISTRIBUTED");
        this.mapper.updatePartial(qualityMgmt);
        return 1;
    }

    public int startQualityMgmt(QualityMgmt qualityMgmt) {
        qualityMgmt.setStatus("REPAIRING");
        this.mapper.updatePartial(qualityMgmt);
        return 1;
    }

    public void saveQualityMgmtInfo(QualityMgmt qualityMgmt, Worker worker, String[] qualityMgmtImgs) {

        this.mapper.updatePartial(qualityMgmt);

        if(StringUtils.isNotBlank(worker.getUuid())){
            workerService.updatePartial(worker);
        }else{
            workerService.insert(worker);
        }

        if(null != qualityMgmtImgs){
            for(String img : qualityMgmtImgs){
                Attachment attachment = new Attachment();
                attachment.setRefid(qualityMgmt.getUuid());
                attachment.setName(img);
                attachment.setType("worker");
                attachmentMapper.insert(attachment);
            }
        }
    }

    public int finishQualityMgmt(QualityMgmt qualityMgmt) {
        qualityMgmt.setStatus("FINISH");
        this.mapper.updatePartial(qualityMgmt);
        return 1;
    }

    public List<QualityMgmt> queryQualityMgmtListForPhone(QualityMgmt qualityMgmt) {
        return this.mapper.selectQualityMgmtListForPhone(qualityMgmt);
    }

    public String saveReportQualityMgmtInfo(QualityMgmt qualityMgmt) {

        String returnMsg = "";

        //根据姓名、号码查询用户
        if(StringUtils.isBlank(qualityMgmt.getReporter())){
            WpUser wpUser =new WpUser();
            wpUser.setName(qualityMgmt.getReportername());
            wpUser.setContactno(qualityMgmt.getReporterphone());
            List<WpUser> wpUserList = wpUserMapper.select(wpUser);
            if(null != wpUserList && wpUserList.size() > 0){
                qualityMgmt.setReporter(wpUserList.get(0).getUuid());
            }
        }

        if(StringUtils.isNotBlank(qualityMgmt.getUuid())){
            this.mapper.updatePartial(qualityMgmt);
        }else{
            qualityMgmt.setStatus("NEW");
            if("REPAIR".equals(qualityMgmt.getType())){
                qualityMgmt.setSnno(sequenceService.getRepairSeqNo());
            }else if("MAINTAIN".equals(qualityMgmt.getType())){
                qualityMgmt.setSnno(sequenceService.getMaintainSeqNo());
            }

            this.mapper.insert(qualityMgmt);
        }
        return returnMsg;
    }

    public PageList<QualityMgmt> queryQualityMgmtPageList(QualityMgmt qualityMgmt, String startDateTimeStr, String endDateTimeStr, PageBounds pageBounds) {
        return this.mapper.selectQualityMgmtPageList(qualityMgmt,startDateTimeStr,endDateTimeStr,pageBounds);
    }
}
