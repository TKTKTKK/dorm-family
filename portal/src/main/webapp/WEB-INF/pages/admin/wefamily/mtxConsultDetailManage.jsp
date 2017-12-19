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
        .newwords textarea{width: 80%;border: 0;padding-left: 10px;background: #efefef; height: 40px;margin: 0;}
        .newwords button{width: 19%;border: 0;color: #fff;background: #5bbc4e;height: 40px;margin: 0;}
    </style>
</head>
<body class="">
<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading  bg-white text-md b-b">
                咨询留言 /
                <a href="${ctx}/admin/wefamily/mtxConsultManage"> 留言管理</a> /
                <span class="font-bold  text-shallowred"> 留言详情</span>
            </header>
            <div class="col-sm-3"></div>
            <div class="col-sm-6 pos">
                <span class="text-success">${successMessage}</span>
                <span class="text-danger">${errorMessage}</span>
                <form class="form-horizontal form-bordered" data-validate="parsley" id="frm"
                      action="${ctx}/admin/wefamily/answer" method="POST"
                onsubmit="return ValidContent()">
                    <section class="panel panel-default" style="border-top:0;">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">留言详情</span>
                        </header>
                        <div class="panel-body p-15" style="background: #f8f8f8;">
                            <div id="flow_id" class="content" style="height: 600px;overflow-y: scroll;">
                                <c:forEach items="${mtxConsultDetailList}" var="mtxConsultDetail">
                                    <c:choose>
                                        <c:when test="${mtxConsultDetail.createby eq 'guest'}">
                                            <div class="myquestion">
                                                <img src="../../../static/admin/img/qrcode.png" alt="">
                                                <div class="sanjiaol"></div>
                                                <div class="enquiry_words left">
                                                    <p class="time">${fn:substring(mtxConsultDetail.createon, 0, 19)}</p>
                                                    <span>${mtxConsultDetail.content}</span>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="myquestion rotatey">
                                                <img src="../../../static/admin/img/qrcode.png" alt="" class="rotatey">
                                                <div class="sanjiaor"></div>
                                                <div class="enquiry_words rotatey right">
                                                    <p class="time">${fn:substring(mtxConsultDetail.createon, 0, 19)}</p>
                                                    <span>${mtxConsultDetail.content}</span>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                        </div>
                        <input type="text" name="consultid" class="hidden" value="${uuid}">
                        <div class="newwords">
                            <textarea name="content" id="result" placeholder="回复内容......"></textarea>
                            <button>发送</button>
                        </div>
                    </section>
                </form>
            </div>
            <div class="col-sm-3"></div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script src="${ctx}/static/admin/js/jquery.blockui.min.js"></script>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script  type="text/javascript">
    window.onload = function(){
        //显示父菜单
        showParentMenu('咨询留言');
        $('#flow_id').scrollTop( $('#flow_id')[0].scrollHeight );
    }
    function ValidContent(){
        var result=$("#result").val();
        if(result.length>0){
            $("#result").css("border","0");
            return true;
        }else{
            $("#result").css("border","1px solid red");
            return false;
        }
    }
</script>

</body>
</html>