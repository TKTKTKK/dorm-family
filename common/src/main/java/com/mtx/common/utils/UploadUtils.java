package com.mtx.common.utils;

import com.mtx.common.service.Uploader;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.util.Date;

/**
 * 上传工具类
 */
public class UploadUtils {

    private static String uploadPath;
    private static String uploadViewPath;
    private static Uploader uploader;

    public static String getUploadPath() {
        return uploadPath;
    }

    public void setUploadPath(String path) {
        uploadPath = path;
    }

    public static String getUploadViewPath() {
        return uploadViewPath;
    }

    public void setUploadViewPath(String viewPath) {
        uploadViewPath = viewPath;
    }

    public void setUploader(Uploader uploader) {
        UploadUtils.uploader = uploader;
    }

    /**
     * 上传文件
     * @param multipartFile
     * @return
     */
    public static String uploadFile(MultipartFile multipartFile, String type){
        return uploader.uploadFile(multipartFile,type);
    }


    /**
     *
     * @param stream
     * @param type
     * @param ext
     * @return
     */
    public static String uploadFile(ByteArrayOutputStream stream, String type,String ext){
        return uploader.uploadFile(stream,type,ext);
    }


    public static String uploadFile(String base64Data,String ext, String type){
        return uploader.uploadFile(base64Data,ext,type);
    }

    /**
     * 创建文件夹
     * @return
     */
    public static File createFolder(String type) {
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
    public static String getFolder(String type) {
        String folder = DateUtils.getDate("yyyyMMdd");
        return uploadViewPath + type + "/" + folder + "/";
    }

    public static String getViewPath() {
        return RequestUtil.getDomainUrl()+ "/";
    }
}
