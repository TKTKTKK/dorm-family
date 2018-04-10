package com.dorm.common.lbs;


import java.util.HashMap;
import java.util.Map;

public class RouteMatrixAPIStatusCode {

    public static String SUCCESS = "0";
    public static String INTERNAL_ERROR = "1";
    public static String INVALID_PARAMETER = "2";
    public static String ACL_FAIL = "3";
    public static String QUOTA_FAIL = "4";
    public static String AK_FAIL = "5";
    public static String ORIGIN_DEST_FUZZY = "11";
    public static String ORIGIN_DEST_EXCEED_5 = "12";
    public static String SERVICE_FORBID = "101";
    public static String WHITE_LIST_FAIL = "102";
    public static String NO_ACCESS_RIGHT = "2xx";
    public static String QUOTA_ERROR = "3xx";

    private static Map<String, String> statuses = new HashMap<>();

    static {
        statuses.put(INTERNAL_ERROR, "服务器内部错误");
        statuses.put(INVALID_PARAMETER, "请求参数非法");
        statuses.put(ACL_FAIL, "权限校验失败");
        statuses.put(QUOTA_FAIL, "配额校验失败");
        statuses.put(AK_FAIL, "Ak不存在或者非法");
        statuses.put(ORIGIN_DEST_FUZZY, "起终点信息模糊");
        statuses.put(ORIGIN_DEST_EXCEED_5, "起点或者终点超过5个");
        statuses.put(SERVICE_FORBID, "服务禁用");
        statuses.put(WHITE_LIST_FAIL, "不通过白名单或者安全码不对");
        statuses.put(NO_ACCESS_RIGHT, "无权限");
        statuses.put(QUOTA_ERROR, "配额错误");
    }

    public static String getStatusDesc(String status){
        return statuses.get(status);
    }


}
