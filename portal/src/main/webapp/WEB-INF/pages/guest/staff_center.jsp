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
    <title>员工中心</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        body{background-color: #fff}
        .list{background: #fff;}
        .list li{padding: 1.17rem 2rem;}
        .list li hr{border: 0;height: 1px;background-color: rgba(0,0,0,0.1);margin-top: 1.17rem;}
        .list li>p:nth-of-type(1){font-size: 1.6rem;color: #333}
        .list li>input,.list li>span:nth-of-type(2){font-size: 1.4rem;color: #666;text-align: left;margin: 1rem 0 0 0;}
        .list li .address{display: table;margin: 1rem 0 0 0;}
        .list li .address>select{font-size: 1.4rem;color: #666;}
        .head .finish{color: #fff;font-size: 1.4rem;}
        .submit{width: auto;;margin:2rem;}
    </style>
</head>
<body>
<div class="head">
    <span>员工中心</span>
</div>
<form method="post" action="" id="searchForm">
<ul class="list">
    <li>
        <p>姓名</p>
        <input type="text" name="name" id="name" placeholder="请填写真实姓名" >
        <hr>
    </li>
    <li>
        <p>电话</p>
        <input type="text" name="contactno" id="contactno" placeholder="请填写真实号码">
        <hr>
    </li>
</ul>
<div class="submit" onclick="submitForm()">提交</div>
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
    window.onload=function(){
        var success='${success}';
        if(success.length>0){
            errorMessage.innerHTML=success;
            $(".choose").css("display","block");
        }
    }
    function submitForm(){
        var errorMessage = document.getElementById("errorMessage");
        errorMessage.innerHTML = "";
        var name=document.getElementById("name").value;
        var phone=document.getElementById("contactno").value;
        if(name!='' && name!=null && phone!=''&&phone!=null&&isPoneAvailable()){
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/guest/staff/bind";
            searchForm.submit();
        }else{
            errorMessage.innerHTML="信息不完整或输入有误，请确认后重试！";
            $(".choose").css("display","block");
        }
    }
    //去空格
    function trimText(obj){
        if(obj.value.length > 0){
            obj.value = obj.value.replace(/(^\s*)|(\s*$)/g, "");
        }
    }
    function isPoneAvailable() {
        trimText(document.getElementById('contactno'));
        var phone=document.getElementById("contactno").value;
        if(phone.length==0 || phone==undefined ||phone==null){
            return true;
        }else{
            var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
            if (!myreg.test(phone)) {
                return false;
            } else {
                return true;
            }
        }
    }
    function closeModel(){
        $(".choose").css("display","none");
    }
</script>
</html>