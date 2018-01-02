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
    <title>培训列表</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        .list{background-color: #fff;color: #333;margin-bottom: 3.67rem;}
        .list li{border-bottom: 1px solid rgba(0,0,0,0.1);padding: 1.08rem;}
        .list li p:nth-of-type(1){font-size: 1.6rem;margin-bottom: 0.5rem;display: flex;display: -webkit-flex;justify-content: space-between;align-items: center;}
        .list li p span:nth-of-type(1){width: 50%;display: inline-block;}
        .list li p:nth-of-type(2){font-size: 1.2rem;color: #999}
        .list li img{width: 5rem;}
        .list a {color: #333}
    </style>
</head>
<body>
<div class="head">
    <a class="back" href="${ctx}/guest/member/center"></a>
    <span>培训列表</span>
</div>
<div class="content">
    <ul class="list">
        <c:forEach items="${trainList}" var="train">
            <a href="${ctx}/guest/member/train_info?trainId=${train.uuid}">
                <li>
                    <p>
                        <span>${train.machinemodel}</span>
                        <span>${web:getCodeDesc("TRAIN_TYPE",train.type)}</span>
                        <c:if test="${train.status == 'NEW'}">
                            <img src="../../../../static/admin/img/new.png" alt="">
                        </c:if>
                        <c:if test="${train.status == 'FINISH'}">
                            <img src="../../../../static/admin/img/finish.png" alt="">
                        </c:if>
                    </p>
                    <p><span class="time">${train.traindt}</span></p>
                </li>
            </a>
        </c:forEach>
        <div class="clearfix"></div>
    </ul>
</div>
</body>
</html>