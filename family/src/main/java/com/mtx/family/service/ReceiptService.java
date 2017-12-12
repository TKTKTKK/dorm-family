package com.mtx.family.service;

import com.mtx.common.base.BaseService;
import com.mtx.common.entity.Attachment;
import com.mtx.common.mapper.AttachmentMapper;
import com.mtx.family.entity.Receipt;
import com.mtx.family.mapper.ReceiptMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class ReceiptService extends BaseService<ReceiptMapper,Receipt> {

    @Autowired
    public void setMapper(ReceiptMapper mapper) {
        super.setMapper(mapper);
    }

    @Autowired
    private AttachmentMapper attachmentMapper;


    public void saveReceipt(Receipt receipt, String[] receiptImg) {

        this.mapper.insert(receipt);

        saveReceiptImg(receipt,receiptImg);
    }



    public void updateReceipt(Receipt receipt, String[] receiptImg) {

        this.mapper.updatePartial(receipt);

        saveReceiptImg(receipt,receiptImg);
    }

    private void saveReceiptImg(Receipt receipt, String[] receiptImg) {

        if(null != receiptImg){
            for(String img : receiptImg){
                Attachment attachment = new Attachment();
                attachment.setRefid(receipt.getOrderid());
                attachment.setName(img);
                attachmentMapper.insert(attachment);
            }
        }
    }
}
