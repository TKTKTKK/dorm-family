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
    <title>登录</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        body{background: url(../../../static/guest/img/background.jpg) no-repeat 0 0;background-size: cover;}
        .logo{text-align: center;position: relative;padding: 7rem 0 7rem 0;}
        .logo img{width: 9rem}
        .uid{margin: 0 2.5rem 2.85rem 2.5rem;border-bottom: 1px solid rgba(255,255,255,0.5);padding: 1rem 0;}
        .uid img{width:2rem;vertical-align: middle;margin-right:0.5rem }
        input{background: transparent;font-size: 1.5rem;color: #fff;vertical-align: middle;}
        input::-webkit-input-placeholder {color: #fff;font-size: 1.5rem;}
        .login{background: #5bbc4e;color: #fff;font-size: 1.7rem;padding: 1rem;text-align: center;margin: 0 2.5rem;}
        /*.notice{margin: 1.25rem 2.5rem;display: flex;display: -webkit-flex;justify-content: space-between;font-size: 1.2rem;}*/
        .notice a{color: #fff}
        input:-webkit-autofill {
            -webkit-box-shadow: 0 0 0px 1000px #c6d8e4 inset;
            -webkit-text-fill-color: #333;
        }
    </style>
</head>
<body>
<div class="logo">
    <img src="../../../static/guest/img/logo.png" alt="">
</div>
<form method="post" action="" id="searchForm">
<div class="uid" style="margin-bottom:0">
    <img src="../../../static/guest/img/number.png" alt="">
    <input type="text" name="username" id="username" placeholder="请输入手机号码">
</div>
<div class="uid">
    <img src="../../../static/guest/img/password.png" alt="">
    <input type="password" name="password" id="password" placeholder="请输入密码">
</div>
<div class="login" onclick="submitLogin()">登录</div>
</form>
<div class="choose" style="display: none">
    <div class="error">
        <p id="errorMessage"></p >
        <button onclick="closeModel()">我知道了</button>
    </div>
</div>
<%--<div class="notice">--%>
    <%--<a href="">忘记密码</a>--%>
    <%--<a href="">注册帐号</a>--%>
<%--</div>--%>
</body>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        var errorMessage = document.getElementById("errorMessage");
        errorMessage.innerHTML = "";
        var flag='${flag}';
        if(flag=="1"){
            errorMessage.innerHTML="用户名或密码错误";
            $(".choose").css("display","block");
        }
    });
    function submitLogin(){
        var username=$("#username").val();
        var password=$("#password").val();
        if(username.length==0 ||password.length==0 ||username==''||password==''){
            errorMessage.innerHTML="用户名或密码不能为空";
            $(".choose").css("display","block");
        }else{
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/admin/login?flag=1";
            searchForm.submit();
        }
    }
    function closeModel(){
        $(".choose").css("display","none");
    }
</script>
</html>