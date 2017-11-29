<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <meta charset="UTF-8">
    <title>爱米社区 | 登录</title>
    <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

    <link rel="stylesheet" href="${ctx}/static/admin/css/c32171bd.vendor.min.css">
    <link rel="stylesheet" href="${ctx}/static/admin/css/aa3a9c5b.app.min.css">
    <link href="${ctx}/static/admin/css/darkblue.css" rel="stylesheet" type="text/css" id="style_color"/>
    <link rel="stylesheet" href="${ctx}/static/admin/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="${ctx}/static/admin/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="${ctx}/static/admin/css/simple-line-icons.css" type="text/css" />
    <link rel="stylesheet" href="${ctx}/static/admin/css/font.css" type="text/css" />
    <link rel="stylesheet" href="${ctx}/static/admin/css/app.css" type="text/css" />
    <!--[if lt IE 9]>
    <script src="${ctx}/static/admin/js/ie/html5shiv.js"></script>
    <script src="${ctx}/static/admin/js/ie/respond.min.js"></script>
    <script src="${ctx}/static/admin/js/ie/excanvas.js"></script>
    <![endif]-->
</head>
<style>
    .create-account p>a{
        text-shadow: none;
        color: #428bca;
    }
    .create-account p>a:hover{
        color:#2a6496;
        text-decoration:underline
    }
    .checkbox a{
        text-shadow: none;
        color: #428bca;
    }
    .checkbox a:hover{
        color:#2a6496;
        text-decoration:underline
    }
    .form-group {
        margin-bottom: 30px;
    }
    .backstretch img{
        /*float: left;*/
        margin: auto;
        /*width: 100%;*/
    }
    .backstretch{
        margin: 0 auto;
        text-align: center;
    }
</style>
<body   class="page-header-fixed ember-application ">
<!--[if lt IE 8]>
<p class="browsehappy" style="color: white;font-size:15px;">
    我们的系统不支持<strong>IE8</strong>以下的浏览器版本，建议您<a href="http://ie.microsoft.com/">升级浏览器</a>到最新版本！
</p>
<![endif]-->

<%--<section id="content" class="m-t-lg wrapper-md animated fadeInUp">--%>
<%--<div class="container aside-xl">--%>
<%--<a class="navbar-brand block" href="#"><span class="h1 font-bold">微物业</span></a>--%>
<%--<section class="m-b-lg">--%>
<%--<form action="${ctx}/admin/login" method="post" data-validate="parsley" >--%>
<%--<c:if test="${not empty errorMessage}">--%>
<%--<p class="text-danger">${errorMessage}</p>--%>
<%--</c:if>--%>
<%--<div class="form-group">--%>
<%--<input name="username" placeholder="用户名" class="form-control rounded input-lg text-center no-border" required="true" >--%>
<%--</div>--%>
<%--<div class="form-group">--%>
<%--<input type="password" name="password" placeholder="密码" class="form-control rounded input-lg text-center no-border" required="true">--%>
<%--</div>--%>
<%--<c:if test="${isValidateCodeLogin}">--%>
<%--<div class="form-group validateCode">--%>
<%--<label for="validateCode">验证码：</label>--%>
<%--<tags:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>--%>
<%--</div>--%>
<%--</c:if>--%>
<%--<div class="checkbox i-checks m-b">--%>
<%--<label class="m-l">--%>
<%--<input type="checkbox" name="rememberMe" value="Y"><i></i> <span class="text-white">三十天内免登录</span>--%>
<%--</label>--%>
<%--</div>--%>
<%--<button type="submit" class="btn btn-lg btn-warning lt b-white b-2x btn-block btn-rounded"><i class="icon-arrow-right pull-right"></i><span class="m-r-n-lg">登 录</span></button>--%>
<%--<div class="line line-dashed"></div>--%>
<%--<p class="text-muted text-center"><small>还没有账号?</small></p>--%>
<%--<a href="${ctx}/admin/register" class="btn btn-lg btn-info btn-block rounded">注 册</a>--%>
<%--</form>--%>
<%--</section>--%>
<%--</div>--%>
<%--</section>--%>

<script src="${ctx}/static/admin/js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="${ctx}/static/admin/js/bootstrap.js"></script>
<!-- App -->
<script src="${ctx}/static/admin/js/app.js"></script>
<script src="${ctx}/static/admin/js/app.plugin.js"></script>
<!-- parsley -->
<script src="${ctx}/static/admin/js/parsley/parsley.min.js"></script>
<script src="${ctx}/static/admin/js/parsley/parsley.extend.js"></script>

<script src="${ctx}/static/guest/common/js/sliderTrans.js" type="text/javascript"></script>
<div id="ember493" class="ember-view">
    <script id="metamorph-2-start" type="text/x-placeholder"></script>
    <script id="metamorph-1-start" type="text/x-placeholder"></script>
    <div class="login">
        <!-- BEGIN LOGO -->
        <div class="logo">
            <a href="/"><img src="/static/guest/property/img/mi2.png" alt="爱米社区" style="width: 150px;height:150px"></a>
        </div>
        <!-- END LOGO -->

        <div class="content text-center" style="margin-top: 20px;">
            <a type="button" class="btn btn-s-xs a-noline" href="${componentAuthLoginUrl}"
               style="padding: 0px">
                <img src="${ctx}/static/admin/img/wechatLogo.png">
            </a>
        </div>
    </div>

</div>

<div id="idContainer1" style=" width:100%;top: 0px; overflow: hidden; margin: 0 auto; padding: 0px; height: 100%; z-index: -999999; position: fixed;">
    <table id="idSlider" style="width: 100%;text-align: center">
        <tr>
            <td style="vertical-align:middle;">
                <img src="/static/admin/img/login22.jpg">
            </td>
        </tr>
        <tr>
            <td style="vertical-align:middle;">
                <img src="/static/admin/img/login44.jpg">
            </td>
        </tr>
        <tr>
            <td style="vertical-align:middle;">
                <img src="/static/admin/img/login33.jpg">
            </td>
        </tr>
    </table>
</div>
</body>
</html>