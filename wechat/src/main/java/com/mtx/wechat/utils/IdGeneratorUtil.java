package com.mtx.wechat.utils;

import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * Created by wensheng on 1/28/2015.
 */
@Component
public class IdGeneratorUtil {

    /**
     * 生成会员卡号
     * @return
     */
    public static String generateMemberShipNum(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmssSSS");
        String prefix =  sdf.format(new Date(System.currentTimeMillis()));
        Random rd = new Random();
        return prefix + rd.nextInt(9999);
    }

}
