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
    <title>我的配件</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        .list{background: #fff;}
        .list li{display: flex;display: -webkit-flex;justify-content: space-between;border-bottom: 1px solid rgba(0,0,0,0.1);padding: 1.5rem 2rem;}
        .list li>span:nth-of-type(1){font-size: 1.6rem;color: #333}
        .list li>input,.list li>span:nth-of-type(2){font-size: 1.4rem;color: #666;text-align: right;}
        .list li .address>select{font-size: 1.4rem;color: #666;text-align: right;width:30%}
    </style>
</head>
<body>
<div class="head">
    <a class="back" onclick="goBack()" ></a>
    <span>我的配件</span>
</div>
<form method="post" action="" id="searchForm">
<ul class="list">
    <li>
        <span>配件名称</span>
        <input type="text" id="machinename" name="machinename" value="${machine.machinemodel}" placeholder="请填写配件名称">
    </li>
    <li>
        <span>适应机型</span>
        <input type="text" id="machinemodel" name="machinemodel" value="${machine.machinename}" placeholder="请填写适应机型">
    </li>
    <li>
        <span>物料编码</span>
        <input type="text" id="machineno" name="machineno" value="${machine.machineno}" placeholder="请填写物料编码">
    </li>
</ul>
    <input  type="text" name="userid" id="userid" value="${userid}" style="display: none">
    <input  class="fixsubmit" onclick="submitForm()" value="提交">
</form>
<div class="choose" style="display: none">
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
    window.onload=function(){
        var message='${message}';
        if(message!=null &&message!=''){
            errorMessage.innerHTML=message;
            $(".choose").css("display","block");
        }
    }
    function goBack(){
        var userid=$("#userid").val();
        window.location.href="${ctx}/guest/member/parts_list?userid="+userid;
    }
    function submitForm(){
        var model=document.getElementById("machinemodel").value;
        var name=document.getElementById("machinename").value;
        var machineno=document.getElementById("machineno").value;
        if(model.length>0 &&name.length>0&&machineno.length>0){
            var searchForm=document.getElementById("searchForm");
            searchForm.action="${ctx}/guest/parts_info";
            searchForm.submit();
        }else{
            errorMessage.innerHTML="信息不完整，请确认后重试！";
            $(".choose").css("display","block");
        }
    }
    function closeModel(){
        $(".choose").css("display","none");
    }
</script>
</html>