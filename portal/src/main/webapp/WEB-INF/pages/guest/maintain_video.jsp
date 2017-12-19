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
    <title>保养小视频</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />

    <style>
        body{background-color: #fff}
        .goal_total{padding-left: 1.25rem;border-bottom: 1px solid rgba(0,0,0,0.1);font-size: 1.6rem;color: #333;background-color: #fff;position: relative;padding: 1.17rem 2rem 1.17rem 1.25rem;margin-top: 1rem;}
        .goal_total:nth-of-type(even) span{border-left: 4px solid #ff9933;padding-left: 1.25rem;}
        .goal_total:nth-of-type(odd) span {border-left: 4px solid #5bbc4e;padding-left: 1.25rem;}
        .goal_total img{float: right;right: 1.25rem;position: absolute;width: 1rem;height: 1.6rem;top:1.2rem;}
        .list{background: #fff;}
        .list li{display: flex;display: -webkit-flex;justify-content: space-between;border-bottom: 1px solid rgba(0,0,0,0.1);padding: 1.17rem 2rem;}
        .list:nth-last-of-type(1){margin-bottom:4rem;}
        .list li span:nth-of-type(1){font-size: 1.6rem;color: #333}
        .list li span:nth-of-type(2){font-size: 1.6rem;color: #666}
        .list li>input{font-size: 1.6rem;color: #666;text-align: right;}
        .list li .address>select{font-size: 1.4rem;color: #666;}
        .list:nth-of-type(3) li span{color: #666}
        .list li select{font-size: 1.4rem;color: #666;}
        .open {text-align: center;}
        .open button{border: 1px solid #66cc66;border-radius: 5px;text-align: center;font-size: 1.4rem;color: #66cc66;padding: 0.5rem 1rem;}
    </style>
</head>
<body>
<div class="head">
    <span>保养小视频</span>
</div>
<div class="goal_total">
    <span>保养小视频</span>
</div>
<ul class="list">
    <li>
        <span>机器型号</span>
        <select name="model" id="model">
            <option value="">全部</option>
            <c:forEach items="${videoList}" var="video">
                <option value="${video.uuid}">${video.model}</option>
            </c:forEach>
        </select>
    </li>
</ul>
<div class="choose" style="display: none">
    <div class="error">
        <p id="errorMessage"></p >
        <button onclick="closeModel()">我知道了</button>
    </div>
</div>
<div class="open" onclick="openVideo()"><button>立即播放</button></div>
</body>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script type="text/javascript">
    var errorMessage = document.getElementById("errorMessage");
    errorMessage.innerHTML = "";
    function openVideo(){
        var uuid=$("select[name='model'] option:selected").val();
        if(uuid!=''&& uuid.length>0){
            $.post("${ctx}/guest/getVideoUrl?uuid="+uuid,function(data){
                if(data.video){
                    window.location.href=data.video.videourl;
                }
            });
        }else{
            errorMessage.innerHTML="请先选择机器型号：";
            $(".choose").css("display","block");
        }
    }
    function closeModel(){
        $(".choose").css("display","none");
    }
</script>
</html>