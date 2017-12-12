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
        @media  screen  and (max-width: 520px){
            body{background: url(../../../static/admin/img/background.jpg) no-repeat 0 0;background-size: cover;}
        }
        @media  screen  and (min-width: 520px){
            body{background: url(../../../static/admin/img/backgroundpc.jpg) no-repeat 0 0;background-size: cover;}
        }
        body{max-width: 520px;margin: auto;}
        html {max-width: none}
        /*.logo{text-align: center;position: relative;padding: 7rem 0 7rem 0;}*/
        /*.logo img{width: 9rem}*/
        /*.uid{margin: 0 2.5rem 2.85rem 2.5rem;border-bottom: 1px solid rgba(255,255,255,0.5);padding: 1rem 0;}*/
        /*.uid img{width:2rem;vertical-align: middle;margin-right:0.5rem }*/
        /*input{background: transparent;font-size: 1.5rem;color: #fff;vertical-align: middle;}*/
        /*input::-webkit-input-placeholder {color: #fff;font-size: 1.5rem;}*/
        /*.login{width:85%;background: #5bbc4e;color: #fff;font-size: 1.7rem;padding: 1rem;text-align: center;margin: 0 2.5rem;}*/
        /*.notice a{color: #fff}*/
        input:-webkit-autofill {
            -webkit-box-shadow: 0 0 0px 1000px #fff inset;
            -webkit-text-fill-color: #333;
        }
        #fontErrorId{font-size: 1.2rem;margin-bottom: 1px;margin: 0 2.5rem 2.85rem 2.5rem;color: coral;}
        .form-actions{
            font-size: 1.2rem;margin-bottom: 1px;margin: 0 2.5rem 2rem 2.5rem;
        }
        #test{
            position: relative;float: left;
        }
        .logo{text-align: center;position: relative;padding: 7rem 0 7rem 0;}
        .logo img{width: 8rem}
        .uid{margin: 0 2.5rem 2.85rem 2.5rem;background-color:#fff;padding: 1rem 0;}
        /*.uid:nth-of-type(1){border-radius: 0 0 5px 5px }*/
        .uid:nth-of-type(1){border-radius: 5px 5px 0 0;margin-bottom: 0}
        .uid:nth-of-type(2){border-radius: 0 0 5px 5px;border-top: 1px solid rgba(0,0,0,0.1);}
        .uid img{width:2rem;vertical-align: middle;margin: 0 0.5rem 0 1rem; }
        input{background: transparent;font-size: 1.5rem;color: #333;vertical-align: middle;}
        input::-webkit-input-placeholder {color: #333;font-size: 1.5rem;}
        .login{background: #5bbc4e;color: #fff;font-size: 1.7rem;padding: 1rem;text-align: center;margin: 0 2.5rem;}
        .notice{margin: 1.25rem 2.5rem;display: flex;display: -webkit-flex;justify-content: space-between;font-size: 1.2rem;}
        .notice a{color: #333}
    </style>
</head>
<body>
<div class="logo">
    <img src="../../../static/guest/img/logo.png" alt="">
</div>
<div  id="errorId" style="display: none">
    <span id="fontErrorId"></span>
</div>
<form method="post" action="${ctx}/admin/login" id="searchForm" onsubmit="return submitLogin()">
    <div class="uid" style="margin-bottom:0">
        <img src="../../../static/guest/img/number.png" alt="">
        <input type="text" name="username" id="username" placeholder="请输入用户名">
    </div>
    <div class="uid">
        <img src="../../../static/guest/img/password.png" alt="">
        <input type="password" name="password" id="password" placeholder="请输入密码">
    </div>
    <div class="login_box">
        <div class="form-actions">
            <label class="checkbox">
                <div class="checker"  >
                                <span  id="test">
                                    <input id="ember1149" name="rememberMe" value="Y" class="ember-view ember-checkbox"
                                           type="checkbox" style="margin-left: 0">
                                </span>
                </div>
                <span style="margin-left: 0.5rem;color: #666;">三十天内免登录</span>
            </label>
        </div>
        <div class="login">
        <button style="background: transparent;color: #fff;">登录</button>
        </div>
    </div>
    <%--<div class="login" onclick="submitLogin()">登录</div>--%>

</form>
</body>
<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        var msg='${errorMessage}';
        var fontErrorId = document.getElementById("fontErrorId");
        fontErrorId.innerHTML = "";
        if(msg!=null &&msg!=''){
            fontErrorId.innerHTML=msg;
            $("#errorId").css("display","block");
        }
    });
    function submitLogin(){
        var fontErrorId = document.getElementById("fontErrorId");
        fontErrorId.innerHTML = "";
        var username=$("#username").val();
        var password=$("#password").val();
        if(username.length==0 ||password.length==0 ||username==''||password==''){
            fontErrorId.innerHTML ="用户名或密码不能为空";
            $("#errorId").css("display","block");
            return false;
        }else{
//            var searchForm = document.getElementById("searchForm");
//            searchForm.action = "";
//            searchForm.submit();
            return true;
        }
    }
</script>
</html>