package com.mtx.common.service;

import com.mtx.common.mapper.SequenceMapper;
import com.mtx.common.utils.DateUtils;
import com.mtx.common.utils.StringUtils;
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
        Integer seq = sequenceMapper.selectNextVal("MTX_REPAIR");
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
}
