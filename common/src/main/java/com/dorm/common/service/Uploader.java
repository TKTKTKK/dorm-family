package com.dorm.common.service;

import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

public interface Uploader {

    public String uploadFile(MultipartFile multipartFile, String type);
    public String uploadFile(ByteArrayOutputStream stream, String type, String ext);
    public String uploadFile(ByteArrayInputStream stream, String type, String ext);
    public String uploadFile(byte[] contentBuffer, String type, String ext);
    public String uploadFile(String base64Data,String ext, String type);
}
