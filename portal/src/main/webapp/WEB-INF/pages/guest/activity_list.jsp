<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes"><!-- 删除默认的苹果工具栏和菜单栏。 -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black"><!-- 控制状态栏显示样式 -->
    <meta name="format-detection" content="telephone=no"><!-- 禁止了把数字转化为拨号链接 -->
    <meta http-equiv="x-dns-prefetch-control" content="on"><!-- 浏览器开启预解析功能 -->
    <title>活动列表</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        ul li{background-color: #fff;margin-top: 1rem;padding:1.25rem }
        li .title{font-size:1.6rem;color: #333;font-weight: bold;margin-bottom: 1.25rem;}
        li .info{display: flex;display: -webkit-flex;justify-content: inherit;align-items: center;}
        li .info>img{width: 7rem;height:7rem;    margin-right: 1rem;}
        .actvity_detail p{margin-bottom: 0.2rem}
        .actvity_detail img{width: 2rem;vertical-align: middle;margin-right: 0.5rem;}
        .actvity_detail span{vertical-align: middle;font-size: 1.2rem;color: #333}
        .actvity_detail .status_now{color: #66cc66;border-radius: 10px;border: 1px solid #66cc66;padding: 2px 8px;float: right;margin-top: 5px;}
        .actvity_detail .status_start{color: #e71f19;border-radius: 10px;border: 1px solid #e71f19;padding: 2px 8px;float: right;margin-top: 5px;}
        .actvity_detail .status_end{color: #999;border-radius: 10px;border: 1px solid #999;padding: 2px 8px;float: right;margin-top: 5px;}
    </style>
</head>
<body>
<div class="head">
    <a class="back" href="${ctx}/guest/member/center"></a>
    <span>活动列表</span>
</div>
<div class="content">
    <ul>
        <c:forEach items="${mtxActivityList}" var="activity">
            <a href="${ctx}/guest/activity_info?activityId=${activity.uuid}">
                <li>
                    <p class="title">${activity.name}</p>
                    <div class="info">
                        <img src="${activity.img}" alt="">
                        <div class="actvity_detail">
                            <p><img src="../../../../static/guest/img/time.png" alt=""><span>${fn:substring(activity.startdate, 0,10 )}—${fn:substring(activity.enddate, 0,10 )}</span></p>
                            <p><img src="../../../../static/guest/img/address.png" alt=""><span>${activity.address}</span></p>
                            <p><img src="../../../../static/guest/img/company.png" alt=""><span>满田星公司</span><span class="status_now">${web:getCodeDesc("ACTIVITY_STATUS",activity.status)}</span></p>
                        </div>
                    </div>
                </li>
            </a>
        </c:forEach>
    </ul>
    <div class="fixsubmit">我要参加</div>
</div>
</body>
</html>