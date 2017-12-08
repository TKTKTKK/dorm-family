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
    <title>留言询价</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        .enquiry_list{display:none;background-color: #fff;padding: 1.5rem;display: flex;display: -webkit-flex;justify-content: space-between;}
        .enquiry_list>span{color: #333;font-size: 1.5rem;display: inline-block;width: 15rem;text-align: center;padding-top: 0.5rem;box-sizing: border-box;}
        .enquiry_list ul li a{display: inline-block;color: #fff}
        .enquiry_list ul li{background-color: #faa83d;color: #fff;border-radius: 2rem;font-size: 1.2rem;padding: 0.4rem 1rem;float: left;margin: 0.5rem;}
        .myquestion{text-align: center;display: flex;display: -webkit-flex;align-items: center;margin: 1.5rem 0;}
        .myquestion img{width: 50px;height: 50px;border-radius: 25px;}
        .myquestion>span{color: #fff;font-size: 1.5rem;}
        .enquiry_words{border-radius: 5px;padding: 5px 12px;font-size: 1.6rem;text-align: left;max-width: 60%;}
        .sanjiaol{width: 0;height: 0;border-top: 8px solid transparent;border-right: 8px solid #fff;border-bottom: 8px solid transparent;margin-left: 5px;}
        .sanjiaor{width: 0;height: 0;border-top: 8px solid transparent;border-right: 8px solid #5bbc4e;border-bottom: 8px solid transparent;margin-left: 5px;}
        .rotatey{transform: rotateY(180deg);-webkit-transform: rotateY(180deg);}
        .myquestion:nth-of-type(1){margin-top:0;}
        .myquestion:nth-of-type(odd) .enquiry_words{background: #fff;color: #333}
        .myquestion:nth-of-type(even) .enquiry_words{background: #5bbc4e;color: #fff}
    </style>
</head>
<body>
<div class="head">
    <a href="" class="back"></a>
    <span>留言板</span>
</div>
<%--<div class="enquiry_list">--%>
    <%--<span>我想咨询：</span>--%>
    <%--<ul>--%>
        <%--<li><a href="">关于价格</a></li>--%>
        <%--<li><a href="">商品详情</a></li>--%>
        <%--<li><a href="">商品质保</a></li>--%>
        <%--<li><a href="">快递物流</a></li>--%>
        <%--<li><a href="">售后服务</a></li>--%>
    <%--</ul>--%>
<%--</div>--%>
<div class="content">
    <div class="myquestion">
        <img src="img/actor.jpg" alt="">
        <div class="sanjiaol"></div>
        <div class="enquiry_words">
            <span>关于价格</span>
        </div>
    </div>
    <div class="myquestion rotatey">
        <img src="img/actor.jpg" alt="" class="rotatey">
        <div class="sanjiaor"></div>
        <div class="enquiry_words rotatey">
            <span>关于价格</span>
        </div>
    </div>
    <div class="myquestion">
        <img src="img/actor.jpg" alt="">
        <div class="sanjiaol"></div>
        <div class="enquiry_words">
            <span>的惧怕手机端破啊打破啊水晶肚皮圣诞节爬山</span>
        </div>
    </div>
    <!-- <div class="myquestion">
        <div class="enquiry_words">
            关于价格

        </div>
        <div class="sanjiaor"></div>
        <img src="img/actor.jpg" alt="">
        <span>我</span>
    </div> -->
</div>
<div class="bottom">
    <span>我要留言</span>
</div>
<div class="choose">
    <select name="" id="identification" onchange="closeTheChose()">
        <option value="请选择你的身份">请选择你的身份</option>
        <option value="合作社">合作社</option>
        <option value="普通用户">普通用户</option>
        <option value="代理商">代理商</option>
    </select>
</div>
</body>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script type="text/javascript">
   function closeTheChose(){
       $(".choose").css("display","none");
   }
</script>
</html>