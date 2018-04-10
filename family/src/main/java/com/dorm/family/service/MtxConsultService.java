package com.dorm.family.service;

import com.dorm.family.entity.MtxConsult;
import com.dorm.family.mapper.MtxConsultMapper;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseService;
import com.dorm.common.utils.StringUtils;
import com.dorm.family.entity.MtxConsultDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxConsultService extends BaseService<MtxConsultMapper,MtxConsult> {

    @Autowired
    public void setMapper(MtxConsultMapper mapper) {
        super.setMapper(mapper);
    }
    @Autowired
    private MtxConsultDetailService mtxConsultDetailService;

    public PageList<MtxConsult> queryForListWithPagination(MtxConsult obj, PageBounds pageBounds) {
        return mapper.selectMtxConsultList(obj,pageBounds);
    }

    public String answerQuestion(MtxConsultDetail mtxConsultDetail) {
        MtxConsult mtxConsult=new MtxConsult();
        if(StringUtils.isNotBlank(mtxConsultDetail.getConsultid())){
            mtxConsult.setUuid(mtxConsultDetail.getConsultid());
        }
        MtxConsult mtxConsultTemp=this.queryForObjectByPk(mtxConsult);
        if(mtxConsultTemp!=null){
            mtxConsultDetail.setCategory("REPLY");
            mtxConsultDetailService.insert(mtxConsultDetail);
            if(StringUtils.isNotBlank(mtxConsultTemp.getStatus())&& !"ANWSER_RECENT".equals(mtxConsultTemp.getStatus())){
                mtxConsultTemp.setStatus("ANWSER_RECENT");
                this.updatePartial(mtxConsultTemp);
            }
        }
        return "Y";
    }

    public String addMessage(MtxConsult mtxConsult, String content) {
        MtxConsult mtxConsultTemp=new MtxConsult();
        MtxConsultDetail mtxConsultDetailTemp=new MtxConsultDetail();
        mtxConsultDetailTemp.setCategory("QUERY");
        if(StringUtils.isNotBlank(mtxConsult.getUserid())){
            mtxConsultTemp.setUserid(mtxConsult.getUserid());
            List<MtxConsult> mtxConsultTempList=this.queryForList(mtxConsultTemp);
            if(mtxConsultTempList.size()==0){
                mtxConsult.setStatus("NO_ANWSER");
                this.insert(mtxConsult);
                mtxConsultDetailTemp.setConsultid(mtxConsult.getUuid());
                mtxConsultDetailTemp.setContent(content);
                mtxConsultDetailService.insert(mtxConsultDetailTemp);
                return mtxConsult.getUserid();
            }else{
                MtxConsult consult=mtxConsultTempList.get(0);
                mtxConsultDetailTemp.setConsultid(consult.getUuid());
                mtxConsultDetailTemp.setContent(content);
                mtxConsultDetailService.insert(mtxConsultDetailTemp);
                if(StringUtils.isNotBlank(consult.getStatus())&&"ANWSER_RECENT".equals(consult.getStatus())){
                    consult.setStatus("NO_ANWSER");
                    this.updatePartial(consult);
                }
                return consult.getUserid();
            }
        }
        return null;
    }
}
