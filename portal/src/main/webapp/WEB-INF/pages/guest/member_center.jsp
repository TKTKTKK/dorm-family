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
    <title>会员中心</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        .center_top{background: url(../../../static/guest/img/membercenter_bg.jpg) no-repeat 0 0;background-size: 100%;}
        .center_top>div{padding:1.5rem;}
        .center_top img{width: 5rem;border-radius: 6rem;border: 2px solid #fff;vertical-align: middle;margin-right: 1rem;}
        .personal_info{vertical-align: middle;display: inline-block;}
        .personal_info .name{color: #fff;font-size: 1.4rem}
        .personal_info .goal{color: #fbf199;font-size: 1.4rem}
        .list{background: #fff;margin-top:1.25rem;}
        .list li{display: flex;display: -webkit-flex;justify-content: space-between;border-bottom: 1px solid rgba(0,0,0,0.1);padding: 1.17rem 2rem;}
        .list:nth-of-type(1) li{border:0;}
        .list li>span{font-size: 1.6rem;color: #333}
        .list li img{width: 1rem;height: 1.6rem;}
    </style>
</head>
<body>
<div class="head">
    <span>会员中心</span>
</div>
<div class="center_top">
    <div>
        <img src="${user.headimgurl}" alt="">
        <div class="personal_info">
            <p class="name">${user.nickname}</p>
            <p class="goal">当前积分：${user.points}</p>
        </div>
    </div>
</div>
<ul class="list">
    <li onclick="goUserInfo()">
        <span>个人信息</span>
        <img src="../../../static/guest/img/list.png" alt="">
    </li>
</ul>
<input type="text" value="${userid}" id="userid" style="display: none">
<ul class="list">
    <li onclick="goMyPointRecord()">
        <span>我的积分</span>
        <img src="../../../static/guest/img/list.png" alt="">
    </li>
    <li onclick="goMyExchangeRecord()">
        <span>我的兑换</span>
        <img src="../../../static/guest/img/list.png" alt="">
    </li>
    <li onclick="goMyProductRecord()">
        <span>我的产品</span>
        <img src="../../../static/guest/img/list.png" alt="">
    </li>
    <li onclick="goMyPartRecord()">
        <span>我的配件</span>
        <img src="../../../static/guest/img/list.png" alt="">
    </li>
    <li onclick="goMyMaintainRecord()">
        <span>我的保养</span>
        <img src="../../../static/guest/img/list.png" alt="">
    </li>
    <li onclick="goMyRepairRecord()">
        <span>我的维修</span>
        <img src="../../../static/guest/img/list.png" alt="">
    </li>
    <li onclick="goMyTrainRecord()">
        <span>我的培训</span>
        <img src="../../../static/guest/img/list.png" alt="">
    </li>
</ul>
</body>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script type="text/javascript">
    var userid=$("#userid").val();
    function goMyPointRecord(){
        window.location.href="${ctx}/guest/member/point_list?userid="+userid;
    }
    function goUserInfo(){
        window.location.href="${ctx}/guest/member/userInfo?userid="+userid;
    }
    function goMyProductRecord(){
        window.location.href="${ctx}/guest/member/product_list?userid="+userid;
    }
    function goMyMaintainRecord(){
        window.location.href="${ctx}/guest/member/maintain_list";
    }
    function goMyRepairRecord(){
        window.location.href="${ctx}/guest/member/repair_list";
    }
    function goMyPartRecord(){
        window.location.href="${ctx}/guest/member/parts_list?userid="+userid;
    }
    function goMyExchangeRecord(){
        window.location.href="${ctx}/guest/member/exchange_list?userid="+userid;
    }
    function goMyTrainRecord(){
        window.location.href="${ctx}/guest/member/train_list";
    }
</script>
</html>