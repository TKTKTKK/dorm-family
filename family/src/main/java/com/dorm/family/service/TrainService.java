package com.dorm.family.service;

import com.dorm.family.entity.Train;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.dorm.common.base.BaseService;
import com.dorm.common.entity.Attachment;
import com.dorm.common.mapper.AttachmentMapper;
import com.dorm.common.utils.StringUtils;
import com.dorm.family.entity.Merchant;
import com.dorm.family.mapper.TrainMapper;
import com.dorm.wechat.entity.WpUser;
import com.dorm.wechat.mapper.WpUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class TrainService extends BaseService<TrainMapper,Train> {

    @Autowired
    public void setMapper(TrainMapper mapper) {
        super.setMapper(mapper);
    }

    @Autowired
    private AttachmentMapper attachmentMapper;
    @Autowired
    private WpUserMapper wpUserMapper;

    public PageList<Train> queryTrainList(Train train, String startDateTimeStr, String endDateTimeStr, PageBounds pageBounds) {
        return this.mapper.selectTrainList(train,startDateTimeStr,endDateTimeStr,pageBounds);
    }

    public int finishTrain(Train train) {

        train.setStatus("FINISH");
        this.mapper.updatePartial(train);
        return 1;
    }

    public void saveTrain(Train train, String[] trainImgs) {


        WpUser wpUser =new WpUser();
        wpUser.setName(train.getPersonname());
        wpUser.setContactno(train.getPersonphone());
        List<WpUser> wpUserList = wpUserMapper.select(wpUser);
        if(null != wpUserList && wpUserList.size() > 0){
            train.setPerson(wpUserList.get(0).getUuid());
        }
        train.setStatus("NEW");
        this.mapper.insert(train);


        saveTrainImg(train,trainImgs);
    }



    public void updateTrain(Train train, String[] trainImgs) {

        if(StringUtils.isBlank(train.getPerson())){
            WpUser wpUser =new WpUser();
            wpUser.setName(train.getPersonname());
            wpUser.setContactno(train.getPersonphone());
            List<WpUser> wpUserList = wpUserMapper.select(wpUser);
            if(null != wpUserList && wpUserList.size() > 0){
                train.setPerson(wpUserList.get(0).getUuid());
            }
        }
        this.mapper.updatePartial(train);

        saveTrainImg(train,trainImgs);
    }

    private void saveTrainImg(Train train, String[] trainImgs) {
        if(null != trainImgs){
            for(String img : trainImgs){
                Attachment attachment = new Attachment();
                attachment.setRefid(train.getUuid());
                attachment.setName(img);
                attachmentMapper.insert(attachment);
            }
        }
    }

    public List<Train> queryTrainListForPhone(Train train, List<Merchant> merchantList) {
        return this.mapper.selectTrainListForPhone(train,merchantList);
    }

    public void saveFinishTrain(Train train, String[] trainImgs) {
        train.setStatus("FINISH");
        this.mapper.insert(train);
        saveTrainImg(train,trainImgs);
    }

    public List<Train> queryTrainListForExport(Train train, String startDateTimeStr, String endDateTimeStr) {
        return this.mapper.selectTrainListForExport(train,startDateTimeStr,endDateTimeStr);
    }
}
