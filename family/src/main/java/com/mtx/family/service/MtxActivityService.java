package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.utils.StringUtils;
import com.mtx.common.utils.UserUtils;
import com.mtx.family.entity.*;
import com.mtx.family.mapper.MtxActivityMapper;
import com.mtx.family.mapper.MtxReserveMapper;
import com.mtx.wechat.entity.WpUser;
import com.mtx.wechat.service.WpUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class MtxActivityService extends BaseService<MtxActivityMapper,MtxActivity> {

    @Autowired
    public void setMapper(MtxActivityMapper mapper) {
        super.setMapper(mapper);
    }

    @Autowired
    private WpUserService wpUserService;
    @Autowired
    private MtxActivityParticipantService mtxActivityParticipantService;
    @Autowired
    private MtxLuckyParticipantService mtxLuckyParticipantService;

    public PageList<MtxActivity> queryForListWithPagination(MtxActivity obj, PageBounds pageBounds) {
        return mapper.selectMtxActivityList(obj,pageBounds);
    }

    public void participateActivity(String activityId,WpUser wpUser) {

        wpUserService.updatePartial(wpUser);

        MtxActivityParticipant mtxActivityParticipant = new MtxActivityParticipant();
        mtxActivityParticipant.setUserid(wpUser.getUuid());
        mtxActivityParticipant.setActivityid(activityId);
        mtxActivityParticipantService.insert(mtxActivityParticipant);

    }

    public List<MtxActivity> queryActivityListForPhone(List<Merchant> merchantList) {
        return  mapper.selectActivityListForPhone(merchantList);
    }
    public void updateParticipant(String uuid, String winnerId,int count) {
        MtxActivity mtxActivity=new MtxActivity();
        mtxActivity.setUuid(uuid);
        mtxActivity=this.queryForObjectByPk(mtxActivity);
        if(mtxActivity.getCurrentLuckyCount()==null){
            mtxActivity.setCurrentLuckyCount(1);
        }
        mtxActivity.setCurrentLuckyCount(mtxActivity.getCurrentLuckyCount()+1);
        this.updatePartial(mtxActivity);
        MtxActivityParticipant activityParticipant=new MtxActivityParticipant();
        activityParticipant.setActivityid(uuid);
        activityParticipant.setUserid(winnerId);
        List<MtxActivityParticipant> activityParticipantList=mtxActivityParticipantService.queryForList(activityParticipant);
        if(activityParticipantList.size()>0){
            activityParticipant=activityParticipantList.get(0);
            activityParticipant.setStatus("WIN");
            mtxActivityParticipantService.updatePartial(activityParticipant);
        }
        MtxLuckyParticipant luckyParticipant=new MtxLuckyParticipant();
        luckyParticipant.setActivityid(uuid);
        luckyParticipant.setUserid(winnerId);
        List<MtxLuckyParticipant> luckList=mtxLuckyParticipantService.queryForList(luckyParticipant);
        if(luckList.size()>0){
            luckyParticipant=luckList.get(0);
            luckyParticipant.setStatus("WIN");
            mtxLuckyParticipantService.updatePartial(luckyParticipant);
        }
        if(mtxActivity.getCurrentLuckyCount()==count){
            mtxActivity=this.queryForObjectByPk(mtxActivity);
            mtxActivity.setStatus("APP");
            this.updatePartial(mtxActivity);
        }
    }
}
