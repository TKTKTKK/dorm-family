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
        .enquiry_words{border-radius: 5px;padding: 5px 12px;font-size: 1.4rem;text-align: left;max-width: 60%;}
        .sanjiaol{width: 0;height: 0;border-top: 8px solid transparent;border-right: 8px solid #fff;border-bottom: 8px solid transparent;margin-left: 5px;}
        .sanjiaor{width: 0;height: 0;border-top: 8px solid transparent;border-right: 8px solid #5bbc4e;border-bottom: 8px solid transparent;margin-left: 5px;}
        .rotatey{transform: rotateY(180deg);-webkit-transform: rotateY(180deg);}
        .myquestion:nth-of-type(1){margin-top:0;}
        .myquestion .left{background: #fff;color: #333}
        .myquestion .right{background:#5bbc4e;color: #fff}
        .myquestion .left .time{color: #999;font-size: 0.12rem;margin-bottom: 0px;}
        .myquestion .right .time{color: #fff;font-size: 0.12rem;margin-bottom: 0px;}
        .newwords textarea{width: 76%;border: 0;padding-left: 10px;background: #efefef; height: 40px;margin: 0;vertical-align: middle;font-size: 1.5rem}
        .newwords p{font-size: 1.5rem;text-align:center;width: 20%;border: 0;color: #fff;background: #5bbc4e;height: 40px;margin: 0;vertical-align: middle;float:right;line-height: 40px;}
        .bottom_1{position: absolute;bottom: 0;width: 100%;}
        .choose_alert{position: fixed;background: rgba(0,0,0,0.5);width: 100%;top: 0;bottom: 0;left: 0;text-align: center;}
        .choose select{position: relative;top: 20rem;width: 80%;font-size: 1.4rem;border-radius: 5px;padding: 1rem;color: #333;}
        html,body{height: 100%}
        #searchForm{height: calc(100% - 7.34rem);overflow-y: scroll;}
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
<form method="post" action="" id="searchForm">
<div class="content">
    <c:forEach items="${mtxConsultDetailList}" var="mtxConsultDetail">
        <c:choose>
            <c:when test="${mtxConsultDetail.createby eq 'guest'}">
                <div class="myquestion rotatey">
                    <img src="../../../static/admin/img/qrcode.png" alt="" class="rotatey">
                    <div class="sanjiaor"></div>
                    <div class="enquiry_words rotatey right">
                        <p class="time">${fn:substring(mtxConsultDetail.createon, 0, 19)}</p>
                        <span>${mtxConsultDetail.content}</span>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="myquestion">
                    <img src="../../../static/admin/img/qrcode.png" alt="">
                    <div class="sanjiaol"></div>
                    <div class="enquiry_words left">
                        <p class="time">${fn:substring(mtxConsultDetail.createon, 0, 19)}</p>
                        <span>${mtxConsultDetail.content}</span>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <!-- <div class="myquestion">
        <div class="enquiry_words">
            关于价格
        </div>
        <div class="sanjiaor"></div>
        <img src="img/actor.jpg" alt="">
        <span>我</span>
    </div> -->
</div>
<div class="choose">
    <c:set var="identifyList" value="${web:queryCommonCodeList('IDENTITY_CODE')}"></c:set>
    <select name="identify" id="identification" onchange="closeTheChose()">
        <option value="">请选择你的身份</option>
        <c:forEach items="${identifyList}" var="commonCode">
            <option value="${commonCode.code}"
                    <c:if test="${identify eq commonCode.code}">
                        selected
                    </c:if>
            >${commonCode.codevalue}</option>
        </c:forEach>
    </select>
</div>
    <input type="text" name="userid" id="userid" value="${userid}" style="display: none">
<div class="bottom_1">
    <div class="newwords">
        <textarea name="content" id="result" placeholder="留言内容......"></textarea>
        <p onclick="ValidData()">发送</p>
    </div>
</div>
</form>

<%--<div class="bottom">--%>
    <%--<span onclick="hiddenConsult()">我要留言</span>--%>
<%--</div>--%>
<div class="choose_alert" style="display: none">
    <div class="error">
        <p id="errorMessage"></p >
        <button onclick="closeModel()">我知道了</button>
    </div>
</div>
</body>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script type="text/javascript">

    var errorMessage = document.getElementById("errorMessage");
    errorMessage.innerHTML = "";
    $(document).ready(function(){
        var flag='${flag}';
        if(flag=="1"){
            $(".choose").css("display","none");
        }
        $('#searchForm').scrollTop( $('#searchForm')[0].scrollHeight );
    });
    function closeTheChose(){
       $(".choose").css("display","none");
   }
   function closeModel(){
       $(".choose_alert").css("display","none");
   }
//    function hiddenConsult(){
//        $(".bottom").css("display","none");
//        $(".bottom_1").css("display","block");
//    }
    function ValidData(){
        var result=$("#result").val();
        if(result==''||result==null){
            errorMessage.innerHTML="留言不能为空！";
            $(".choose_alert").css("display","block");
        }else{
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/guest/addMessage";
            searchForm.submit();
        }
    }
</script>
</html>