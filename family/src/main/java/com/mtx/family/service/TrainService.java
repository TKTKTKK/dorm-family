package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.entity.Attachment;
import com.mtx.common.mapper.AttachmentMapper;
import com.mtx.family.entity.Logistics;
import com.mtx.family.entity.Merchant;
import com.mtx.family.entity.Train;
import com.mtx.family.mapper.LogisticsMapper;
import com.mtx.family.mapper.TrainMapper;
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

    public PageList<Train> queryTrainList(Train train, String startDateTimeStr, String endDateTimeStr, PageBounds pageBounds) {
        return this.mapper.selectTrainList(train,startDateTimeStr,endDateTimeStr,pageBounds);
    }

    public int finishTrain(Train train) {

        train.setStatus("FINISH");
        this.mapper.updatePartial(train);
        return 1;
    }

    public void saveTrain(Train train, String[] trainImgs) {
        train.setStatus("NEW");
        this.mapper.insert(train);

        saveTrainImg(train,trainImgs);
    }



    public void updateTrain(Train train, String[] trainImgs) {

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
}
