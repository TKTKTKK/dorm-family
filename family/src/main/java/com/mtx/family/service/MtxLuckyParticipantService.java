package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.family.entity.MtxActivityParticipant;
import com.mtx.family.entity.MtxLuckyParticipant;
import com.mtx.family.mapper.MtxActivityParticipantMapper;
import com.mtx.family.mapper.MtxLuckyParticipantMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Random;


@Service
@Transactional
public class MtxLuckyParticipantService extends BaseService<MtxLuckyParticipantMapper,MtxLuckyParticipant> {

    @Autowired
    public void setMapper(MtxLuckyParticipantMapper mapper) {
        super.setMapper(mapper);
    }
    @Autowired
    private MtxActivityParticipantService mtxActivityParticipantService;
    public PageList<MtxLuckyParticipant> queryForListWithPagination(MtxLuckyParticipant obj, PageBounds pageBounds) {
        return mapper.selectMtxLuckyParticipantList(obj,pageBounds);
    }

    public List<MtxLuckyParticipant> queryForLuckyParticipantList(MtxLuckyParticipant luckyParticipant) {
        return mapper.queryForLuckyParticipantList(luckyParticipant);
    }

    public String synchronizationUpdate(List<MtxLuckyParticipant> luckyParticipantList, String uuid) {
        MtxLuckyParticipant luckyParticipant=new MtxLuckyParticipant();
        Random random=new Random();// 定义随机类
        int result=random.nextInt(luckyParticipantList.size());// 返回[0,10)集合中的整数，注意不包括10
        luckyParticipant=luckyParticipantList.get(result);
        luckyParticipant.setStatus("WIN");
        this.updatePartial(luckyParticipant);
        MtxActivityParticipant activityParticipant=new MtxActivityParticipant();
        activityParticipant.setActivityid(uuid);
        activityParticipant.setUserid(luckyParticipantList.get(result).getUserid());
        List<MtxActivityParticipant> activityParticipantList=mtxActivityParticipantService.queryForList(activityParticipant);
        if(activityParticipantList.size()>0){
            activityParticipant=activityParticipantList.get(0);
            activityParticipant.setStatus("WIN");
            mtxActivityParticipantService.updatePartial(activityParticipant);
        }
        return "恭喜"+luckyParticipant.getName()+"中奖！";
    }
}
