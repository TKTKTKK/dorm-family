package com.dorm.common.utils;

import com.dorm.common.entity.CommonCode;
import com.dorm.common.service.CommonCodeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

/**
 * Code工具类
 */
public class CodeUtils {
    private static Logger logger = LoggerFactory.getLogger(CodeUtils.class);

    private static CommonCodeService commonCodeService = ApplicationContextUtil.getBean(CommonCodeService.class);

    /**
     * 查询code描述
     * @param codetype
     * @param code
     * @return
     */
    public static String getCodeDesc(String codetype, String code){
        String codeDesc = commonCodeService.queryCodeDesc(codetype, code);
        return codeDesc;
    }

    /**
     * 根据type查询code描述列表
     * @param codetype
     * @return
     */
    public static List<CommonCode> queryCommonCodeList(String codetype){
        List<CommonCode> commonCodeList = commonCodeService.queryCodeList(codetype);
        return commonCodeList;
    }
}
