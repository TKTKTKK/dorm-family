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
    <title>我的产品</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        .goal_total span:nth-of-type(1){border-left: 4px solid #5bbc4e;padding-left: 1.25rem;}
        .goal_total span:nth-of-type(2){float: right;right: 1.25rem;position: relative;color: #faa83d}
        .list{background-color: #fff;color: #333;}
        .list li{border-bottom: 1px solid rgba(0,0,0,0.1);padding: 1.17rem 2rem;}
        .list li p:nth-of-type(1){font-size: 1.2rem;margin-top: 1rem;margin-bottom: 1rem;display: flex;display: -webkit-flex;justify-content: space-between;}
    </style>
</head>
<body>
<div class="head">
    <a class="back" onclick="goBack()" ></a>
    <span>我的产品</span>
</div>
<ul class="list">
    <c:forEach items="${machineList}" var="machine">
        <li>
            <p><span>${machine.name}</span>
            <span>${fn:substring(machine.createon, 0, 19)}</span>
            </p>
        </li>
    </c:forEach>
</ul>
<input  type="text" name="userid" id="userid" value="${userid}" style="display: none">
<span  class="fixsubmit" onclick="addProduct()" >添加</span>
</body>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script type="text/javascript">
    var userid=$("#userid").val();
    function goBack(){
        window.location.href="${ctx}/guest/member_center?userid="+userid;
    }
    function addProduct(){
        window.location.href="${ctx}/guest/productInfo?userid="+userid;
    }
</script>
</html>