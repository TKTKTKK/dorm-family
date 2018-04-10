package com.dorm.family.service;

import com.dorm.common.base.BaseService;
import com.dorm.common.entity.Attachment;
import com.dorm.common.mapper.AttachmentMapper;
import com.dorm.family.entity.Receipt;
import com.dorm.family.entity.Order;
import com.dorm.family.mapper.OrderMapper;
import com.dorm.family.mapper.ReceiptMapper;
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
    @Autowired
    private OrderMapper orderMapper;


    public void saveReceipt(Receipt receipt, String[] receiptImg) {

        this.mapper.insert(receipt);
        Order tempOrder = new Order();
        tempOrder.setUuid(receipt.getOrderid());
        tempOrder = orderMapper.retrieveByPk(tempOrder);
        tempOrder.setStatus("RECEIVED");
        orderMapper.updatePartial(tempOrder);

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
