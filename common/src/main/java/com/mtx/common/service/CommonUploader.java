package com.mtx.common.service;


import com.mtx.common.utils.DateUtils;
import com.mtx.common.utils.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.poi.util.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Decoder;

import java.io.*;
import java.util.Date;

public class CommonUploader implements Uploader{
    private static Logger logger = LoggerFactory.getLogger(CommonUploader.class);

    private String uploadPath;
    private String uploadViewPath;

    public String getUploadPath() {
        return uploadPath;
    }

    public void setUploadPath(String path) {
        uploadPath = path;
    }

    public String getUploadViewPath() {
        return uploadViewPath;
    }

    public void setUploadViewPath(String viewPath) {
        uploadViewPath = viewPath;
    }

    /**
     * 上传文件
     * @param multipartFile
     * @return
     */
    public String uploadFile(MultipartFile multipartFile, String type){
        String ext = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().indexOf("."));
        String filename = StringUtils.getUUID();
        File picFolder = createFolder(type);
        String picAbsPath = picFolder.getAbsolutePath() + File.separator  + filename + ext;
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(picAbsPath);
            byte[] bt = new byte[1024];
            int count = 0;
            InputStream inputStream = multipartFile.getInputStream();
            while ((count=inputStream.read(bt)) > 0){
                fileOutputStream.write(bt, 0, count);
            }
            fileOutputStream.flush();
            fileOutputStream.close();
            inputStream.close();
        }  catch (IOException e) {
            logger.error(e.getMessage(),e);
        }

        return
                (type) + filename + ext;
    }


    /**
     *
     * @param stream
     * @param type
     * @param ext
     * @return
     */
    public String uploadFile(ByteArrayOutputStream stream, String type,String ext){
        String filename = StringUtils.getUUID();
        File picFolder = createFolder(type);
        String picAbsPath = picFolder.getAbsolutePath() + File.separator  + filename + ext;
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(picAbsPath);
            fileOutputStream.write(stream.toByteArray());
            fileOutputStream.flush();
            fileOutputStream.close();
        }catch (IOException e) {
            logger.error(e.getMessage(),e);
        }

        return getFolder(type) + filename + ext;
    }

    /**
     *
     * @param stream
     * @param type
     * @param ext
     * @return
     */
    public String uploadFile(ByteArrayInputStream stream, String type,String ext){
        String filename = StringUtils.getUUID();
        File picFolder = createFolder(type);
        String picAbsPath = picFolder.getAbsolutePath() + File.separator  + filename + ext;
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(picAbsPath);
            fileOutputStream.write(IOUtils.toByteArray(stream));
            fileOutputStream.flush();
            fileOutputStream.close();
        }catch (IOException e) {
            logger.error(e.getMessage(),e);
        }

        return getFolder(type) + filename + ext;
    }

    /**
     *
     * @param contentBuffer
     * @param type
     * @param ext
     * @return
     */
    @Override
    public String uploadFile(byte[] contentBuffer, String type, String ext) {
        String filename = StringUtils.getUUID();
        File picFolder = createFolder(type);
        String picAbsPath = picFolder.getAbsolutePath() + File.separator  + filename + ext;
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(picAbsPath);
            fileOutputStream.write(contentBuffer);
            fileOutputStream.flush();
            fileOutputStream.close();
        }catch (IOException e) {
            logger.error(e.getMessage(),e);
        }

        return getFolder(type) + filename + ext;
    }

    public String uploadFile(String base64Data, String ext, String type){
        String filename = StringUtils.getUUID();
        File picFolder = createFolder(type);
        String picAbsPath = picFolder.getAbsolutePath() + File.separator  + filename + ext;
        BASE64Decoder decoder = new BASE64Decoder();
        try {
            // new一个文件对象用来保存图片，默认保存当前工程根目录
            File imageFile = new File(picAbsPath);
            // 创建输出流
            FileOutputStream outputStream = new FileOutputStream(imageFile);
            // 获得一个图片文件流
            byte[] result = decoder.decodeBuffer(base64Data.split(",")[1]);//解码
            for (int i = 0; i < result.length; ++i) {
                if (result[i] < 0) {// 调整异常数据
                    result[i] += 256;
                }
            }
            outputStream.write(result);
        } catch (IOException e) {
            logger.error(e.getMessage(),e);
        }
        return getFolder(type) + filename + ext;
    }

    /**
     * 创建文件夹
     * @return
     */
    public File createFolder(String type) {
        //创建根文件夹
        String uploadFolderRoot = getUploadPath() + type;
        File file = new File(uploadFolderRoot, DateFormatUtils.format(new Date(), "yyyyMMdd"));
        if (!file.exists()) {
            file.mkdirs();
        }
        return file;
    }

    /**
     *
     * @param type
     * @return
     */
    public String getFolder(String type) {
        String folder = DateUtils.getDate("yyyyMMdd");
        return uploadViewPath + type + "/" + folder + "/";
    }

}
