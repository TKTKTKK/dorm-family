package com.dorm.common.service;

import com.dorm.common.base.BaseService;
import com.dorm.common.entity.Attachment;
import com.dorm.common.mapper.AttachmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AttachmentService extends BaseService<AttachmentMapper, Attachment> {
    @Autowired
    public void setMapper(AttachmentMapper mapper) {
        super.setMapper(mapper);
    }

}
