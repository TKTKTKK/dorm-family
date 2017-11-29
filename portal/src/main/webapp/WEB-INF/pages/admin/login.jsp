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
<script src="${ctx}/static/admin/js/ie/placeholderfriend.js"></script>
<!-- Bootstrap -->
<script src="${ctx}/static/admin/js/bootstrap.js"></script>
<!-- App -->
<script src="${ctx}/static/admin/js/app.js"></script>
<script src="${ctx}/static/admin/js/app.plugin.js"></script>
<!-- parsley -->
<script src="${ctx}/static/admin/js/parsley/parsley.min.js"></script>
<script src="${ctx}/static/admin/js/parsley/parsley.extend.js"></script>

<!--ie8placehoder-->

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
    <!-- BEGIN LOGIN -->
    <div class="content"><script id="metamorph-3-start" type="text/x-placeholder"></script><div id="ember1126" class="ember-view"><!-- BEGIN LOGIN FORM -->
        <div id="ember1138" class="ember-view form-body">
            <form class="login-form" data-ember-action="43" action="${ctx}/admin/login" method="post" data-validate="parsley">
                <h3 class="form-title text-white" style="color: #fff">登录到您的帐户</h3>
                <%--<div class="alert alert-danger hidden" data-bindattr-44="44">--%>
                    <%--<!--<button class="close" data-close="alert"></button>-->--%>
                    <%--<i class="fa fa-warning"></i>--%>
                    <%--<span><script id="metamorph-47-start" type="text/x-placeholder"></script><script id="metamorph-47-end" type="text/x-placeholder"></script></span>--%>
                <%--</div>--%>
                <c:if test="${not empty errorMessage}">
                <p class="text-danger">${errorMessage}</p>
                </c:if>
                <div id="ember1139" class="ember-view form-group panel" style="background-color: transparent">
                    <label class="control-label visible-ie8 visible-ie9">用户名：</label>
                    <div class="input-icon">
                        <i class="fa fa-user" data-original-title="不可为空" data-bindattr-45="45" data-toggle="tooltip"></i>
                        <input name="username" id="username" class="ember-view ember-text-field form-control placeholder-no-fix" placeholder="用户名" type="text" required="true" >
                    </div>
                </div>
                <div id="ember1141" class="ember-view form-group panel" style="background-color: transparent">
                    <label class="control-label visible-ie8 visible-ie9">密码：</label>
                    <div class="input-icon">
                        <i class="fa fa-lock" data-original-title="不可为空" data-bindattr-46="46" data-toggle="tooltip"></i>
                        <input  id="password" name="password" class="ember-view ember-text-field form-control placeholder-no-fix"  type="password" required="true" placeholder="密码"
                                style="padding-left: 33px !important;height:34px;padding: 6px 12px;-webkit-box-shadow:none;box-shadow:none;width: 100%;line-height: 1.4285;vertical-align: middle;border: 1px solid #ccc">
                    </div>
                </div>
                <c:if test="${isValidateCodeLogin}">
                    <div class="form-group validateCode panel" style="background-color: transparent">
                        <label for="validateCode">验证码：</label>
                        <tags:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
                    </div>
                </c:if>
                <%--<div id="ember1143" class="ember-view hide form-group">--%>
                    <%--<div id="ember1145" class="ember-view input-group"><span id="ember1146" class="ember-view input-group-addon" style="background-color: transparent; cursor: pointer; border-color: #E5E5E5;"><img src="/api/profile/verificationCode" data-bindattr-47="47" style="height: 20px;"></span><div id="ember1147" class="ember-view input-icon right"><input id="ember1148" class="ember-view ember-text-field form-control" placeholder="验证码" type="text" value="ddde">--%>
                        <%--<i class="fa fa-bell-o" data-toggle="tooltip" data-bindattr-48="48"></i></div></div>--%>
                <%--</div>--%>
                <div class="form-actions">
                    <label class="checkbox">
                        <div class="checker"  >
                            <span  id="test">
                                <input id="ember1149" name="rememberMe" value="Y" class="ember-view ember-checkbox"
                                       type="checkbox" style="margin-left: 0">
                            </span>
                        </div>
                        三十天内免登录
                    </label>
                    <button type="submit" class="btn blue pull-right" data-bindattr-49="49"> 登录 <i class="fa fa-arrow-circle-right"></i></button>
                </div>
                <!--<div class="forget-password">-->
                <!--<h4>忘记密码？</h4>-->
                <!--<p>点击 link-to "这儿" "profile.forget-password" 重置您的密码。</p>-->
                <!--</div>-->
                <%--<div class="create-account">--%>
                    <%--<p style="color: #595959">还没有账号？&nbsp; <a id="ember1150" class="ember-view" href="${ctx}/admin/register">创建一个账号</a></p>--%>
                <%--</div>--%>
            </form>
        </div>
        <!-- END LOGIN FORM -->
    </div><script id="metamorph-3-end" type="text/x-placeholder"></script></div>
    <!-- END LOGIN -->
    <%--<div class="content" style="margin-top: 20px;">--%>
        <%--<ul style="list-style-type: none;padding: 0;">--%>
            <%--<li><a href="#" style="font-size: 16px;color: #fff;">友情链接</a></li>--%>
        <%--</ul>--%>
        <%--<div>--%>
            <%--<ul style="list-style-type: none;padding: 0;">--%>
                <%--<li ><a href="http://m.kuaidi100.com" target="_blank" style="color: navajowhite">快递查询</a></li>--%>
            <%--</ul>--%>
        <%--</div>--%>
    <%--</div>--%>
</div>
    <%--<script id="metamorph-1-end" type="text/x-placeholder"></script><script id="metamorph-2-end" type="text/x-placeholder"></script>--%>
    <%--<script id="metamorph-5-start" type="text/x-placeholder"></script><script id="metamorph-0-start" type="text/x-placeholder"></script><script id="metamorph-6-start" type="text/x-placeholder"></script><script id="metamorph-6-end" type="text/x-placeholder"></script><script id="metamorph-7-start" type="text/x-placeholder"></script><script id="metamorph-7-end" type="text/x-placeholder"></script><script id="metamorph-0-end" type="text/x-placeholder"></script><script id="metamorph-5-end" type="text/x-placeholder"></script>--%>
    <%--<div id="toast-container" class="ember-view toast-top-right"></div>--%>
    <%--<script id="metamorph-8-start" type="text/x-placeholder"></script><script id="metamorph-8-end" type="text/x-placeholder"></script></div>--%>

</div>
<div id="idContainer1" style=" width:100%;top: 0px; overflow: hidden; margin: 0 auto; padding: 0px; height: 100%; z-index: -999999; position: fixed;">
    <table id="idSlider" style="width: 100%;text-align: center">
        <tr>
            <td style="vertical-align:middle;">
                <img src="/static/admin/img/login22.jpg" style="width: 100%">
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
<script>
    $(document).ready(function(){
        var st = new SlideTrans("idContainer1", "idSlider", 3, { Vertical:true });
        st.Pause=5000;
        st.Duration=80;
        st.Run();
        $("#test").click( function(){
            if($("#test").hasClass("checked")){
                $("#test").removeClass("checked");
            }else{
                $("#test").addClass("checked");
            }
        });
    })
</script>
</html>