package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.utils.UserUtils;
import com.mtx.family.entity.Merchant;
import com.mtx.family.entity.MtxActivity;
import com.mtx.family.entity.MtxActivityParticipant;
import com.mtx.family.entity.MtxReserve;
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

    public PageList<MtxActivity> queryForListWithPagination(MtxActivity obj, PageBounds pageBounds) {
        return mapper.selectMtxActivityList(obj,pageBounds);
    }

    public void participateActivity(String activityId, String name, WpUser wpUser) {

        wpUser.setName(name);
        wpUserService.updatePartial(wpUser);

        MtxActivityParticipant mtxActivityParticipant = new MtxActivityParticipant();
        mtxActivityParticipant.setUserid(wpUser.getUuid());
        mtxActivityParticipant.setStatus("WAIT_WIN");
        mtxActivityParticipant.setActivityid(activityId);
        mtxActivityParticipantService.insert(mtxActivityParticipant);

    }

    public List<MtxActivity> queryActivityListForPhone(List<Merchant> merchantList) {
        return  mapper.selectActivityListForPhone(merchantList);
    }
}
