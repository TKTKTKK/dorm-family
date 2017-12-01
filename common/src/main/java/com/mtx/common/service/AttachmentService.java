package com.mtx.common.service;

import com.mtx.common.base.BaseService;
import com.mtx.common.entity.Attachment;
import com.mtx.common.mapper.AttachmentMapper;
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
