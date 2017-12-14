<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="x-dns-prefetch-control" content="on">
    <title>个人中心</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        .list{background: #fff;margin-top:0.8rem;}
        .list li{display: flex;display: -webkit-flex;justify-content: space-between;border-bottom: 1px solid rgba(0,0,0,0.1);padding: 2.17rem 2rem;}
        .list li>span:nth-of-type(1){font-size: 1.6rem;color: #333}
        .list li>input,.list li>span:nth-of-type(2){font-size: 1.4rem;color: #666;text-align: right;}
        .list li .address>select{font-size: 1.4rem;color: #666;text-align: right;width:30%}
    </style>
</head>
<body>
<div class="head">
    <a class="back" onclick="goBack()" ></a>
    <span>个人中心</span>
</div>
    <ul class="list">
        <li>
            <span>姓名</span>
            <span>${user.name}</span>
        </li>
        <li>
            <span>电话</span>
            <span>${user.contactno}</span>
        </li>
        <li>
            <span>地区</span>
            <span>${user.address}</span>
        </li>
        <li>
            <span>昵称</span>
            <span>${user.nickname}</span>
        </li>
        <li>
            <span>头像</span>
            <span><img src="${user.headimgurl}" alt="" width="35px" height="35px"/></span>
        </li>
        <li>
            <span>积分</span>
            <span>${user.points}</span>
        </li>
    </ul>
<input type="text" value="${user.uuid}" id="userid" style="display: none">
</body>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script type="text/javascript">
    function goBack(){
        var userid=$("#userid").val();
        window.location.href="${ctx}/guest/member_center?userid="+userid;
    }
</script>
</html>