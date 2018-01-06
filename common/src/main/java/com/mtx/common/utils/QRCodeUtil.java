package com.mtx.common.utils;

import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;

import java.io.ByteArrayOutputStream;

/**
 * Created by wensheng on 15-6-4.
 */
public class QRCodeUtil {

    public static String generateQRCode(String content){
        ByteArrayOutputStream out = QRCode.from(content).to(ImageType.PNG).withSize(250,250).stream();
        return UploadUtils.uploadFile(out,"qrcode",".png");
    }

    /**
     * 活动二维码
     * @param content
     * @return
     */
    public static String generateActivityQRCode(String content){
        ByteArrayOutputStream out = QRCode.from(content).to(ImageType.PNG).withSize(250,250).stream();
        return UploadUtils.uploadFile(out,"qrcodeForActivity",".png");
    }


    /**
     * 生成快递员支付二维码
     * @param content
     * @return
     */
    public static String generateQRCodeForCourier(String content){
        ByteArrayOutputStream out = QRCode.from(content).to(ImageType.PNG).withSize(250,250).stream();
        return UploadUtils.uploadFile(out,"qrcodeForCourier",".png");
    }

}
