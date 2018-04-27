package com.dorm.common.service;

import com.dorm.common.mapper.SequenceMapper;
import com.dorm.common.utils.DateUtils;
import com.dorm.common.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SequenceService {
    @Autowired
    private SequenceMapper sequenceMapper;


    /**
     * 获取报修编号
     * @return
     */
    public String getRepairSeqNo(){
        Integer seq = sequenceMapper.selectNextVal("DORM_REPAIR");
        String formatSeq = StringUtils.leftPad(seq.toString(),8,"0");
        String prefix = DateUtils.getDate("yyMMdd");
        return prefix + formatSeq;
    }

    /**
     * 获取电费缴费编号
     * @return
     */
    public String getEchargeSeqNo(){
        Integer seq = sequenceMapper.selectNextVal("DORM_ECHARGE");
        String formatSeq = StringUtils.leftPad(seq.toString(),8,"0");
        String prefix = DateUtils.getDate("yyMMdd");
        return prefix + formatSeq;
    }

    public String getOrderSeqNo() {
        Integer seq = sequenceMapper.selectNextVal("MTX_ORDER");
        String formatSeq = StringUtils.leftPad(seq.toString(),8,"0");
        String prefix = DateUtils.getDate("yyMMdd");
        return prefix + formatSeq;
    }

    public String getMaintainSeqNo() {
        Integer seq = sequenceMapper.selectNextVal("MTX_MAINTAIN");
        String formatSeq = StringUtils.leftPad(seq.toString(),8,"0");
        String prefix = DateUtils.getDate("yyMMdd");
        return prefix + formatSeq;
    }

    public String getTrainSeqNo() {
        Integer seq = sequenceMapper.selectNextVal("MTX_TRAIN");
        String formatSeq = StringUtils.leftPad(seq.toString(),8,"0");
        String prefix = DateUtils.getDate("yyMMdd");
        return prefix + formatSeq;
    }
}
