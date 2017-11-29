package com.mtx.portal.controller;

import com.mtx.common.service.CommonUploader;
import com.mtx.common.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;


@Controller
@RequestMapping(value = "/common")
public class UploadController {
    private static Logger logger = LoggerFactory.getLogger(UploadController.class);
    @Autowired
    private CommonUploader commonUploader;

    @ResponseBody
    @RequestMapping(value="/compressUploadPicture", method = RequestMethod.POST)
    public Object fileUploadPicture(HttpServletRequest request) {
        String imgdata = request.getParameter("imgdata");
        String ext = request.getParameter("ext");
        String path = request.getParameter("path");
        if(StringUtils.isBlank(path)){
            path = "admin";
        }
        try {
            String imgPath = commonUploader.uploadFile(imgdata,ext,path);
            return new Result(true, imgPath);
        }  catch (Exception e) {
            logger.error("[文件上传（fileUpload）][errors:" + e + "]");
            return new Result(false, "文件上传失败");
        }
    }
}


class Result implements Serializable{
    private static final long serialVersionUID = 1L;
    private boolean success;
    private String message;

    public Result() {
        success = true;
    }

    public Result(boolean success, String message) {
        this.success = success;
        this.message = message;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "Result [success=" + success + ", message=" + message + "]";
    }

}
