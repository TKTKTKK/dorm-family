<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en" class="app">
    <head>
        <meta charset="UTF-8">
        <title>爱米社区| 注册</title>
        <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
        <link rel="stylesheet" href="${ctx}/static/admin/css/c32171bd.vendor.min.css">
        <link rel="stylesheet" href="${ctx}/static/admin/css/aa3a9c5b.app.min.css">
        <link href="${ctx}/static/admin/css/darkblue.css" rel="stylesheet" type="text/css" id="style_color"/>
        <link rel="stylesheet" href="${ctx}/static/admin/js/jPlayer/jplayer.flat.css" type="text/css" />
        <link rel="stylesheet" href="${ctx}/static/admin/css/bootstrap.css" type="text/css" />
        <link rel="stylesheet" href="${ctx}/static/admin/css/animate.css" type="text/css" />
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
        .form-group {
            margin-bottom: 30px;
        }
    </style>
    <body>
        <%--<section id="content" class="m-t-lg wrapper-md animated fadeInUp">--%>
            <%--<div class="container aside-xl">--%>
                <%--<a class="navbar-brand block" href="#"><span class="h1 font-bold">微物业</span></a>--%>
                <%--<section class="m-b-lg">--%>
                    <%--<form action="${ctx}/admin/register" method="post" data-validate="parsley" onsubmit="return registUser()">--%>
                        <%--<c:if test="${not empty errorMessage}">--%>
                            <%--<p class="text-danger">${errorMessage}</p>--%>
                        <%--</c:if>--%>
                        <%--<div class="form-group">--%>
                            <%--<input name="username" placeholder="用户名" class="form-control rounded input-lg text-center no-border" required="true" onblur="trimText(this),validateChineseText(30, this.value, 'usernameError')" id="username">--%>
                            <%--<span id="usernameError" class="text-danger"></span>--%>
                        <%--</div>--%>
                        <%--<div class="form-group">--%>
                            <%--<input type="password" name="password" placeholder="密码" class="form-control rounded input-lg text-center no-border" required="true" id="pwd" onblur="checkPassword(this.value)">--%>
                            <%--<span id="passwordError" class="text-danger"></span>--%>
                        <%--</div>--%>
                        <%--<div class="form-group">--%>
                            <%--<input type="password" name="password2"  placeholder="确认密码" class="form-control rounded input-lg text-center no-border" required="true" data-equalto="#pwd">--%>
                        <%--</div>--%>
                        <%--<div class="checkbox i-checks m-b">--%>
                            <%--<label class="m-l">--%>
                                <%--<input type="checkbox" name="trusteeship" value="Y"><i></i> <span class="text-white">托管</span>--%>
                            <%--</label>--%>
                        <%--</div>--%>
                        <%--<button type="submit" class="btn btn-lg btn-warning lt b-white b-2x btn-block btn-rounded"><i class="icon-arrow-right pull-right"></i><span class="m-r-n-lg">注 册</span></button>--%>
                        <%--<div class="line line-dashed"></div>--%>
                        <%--<p class="text-muted text-center"><small>已经有账号?</small></p>--%>
                        <%--<a href="${ctx}/admin/login" class="btn btn-lg btn-info btn-block rounded">登 录</a>--%>
                    <%--</form>--%>
                <%--</section>--%>
            <%--</div>--%>
        <%--</section>--%>


        <div  class="ember-view">
            <%--<script  type="text/x-placeholder"></script>--%>
            <%--<script  type="text/x-placeholder"></script>--%>
            <div class="login">
        <!-- BEGIN LOGO -->
        <div class="logo">
        <a href="/"><img src="/static/guest/property/img/mi2.png" alt="爱米社区" style="width: 150px;height:150px"></a>
        </div>
        <!-- END LOGO -->
        <!-- BEGIN LOGIN -->
        <div class="content"><div  class="ember-view"><div id="ember729" class="ember-view form-body">
        <form class="login-form" data-ember-action="8" action="${ctx}/admin/register" method="post" data-validate="parsley"
              <%--onsubmit="return registUser()"--%>
              id="registFrm">
            <c:if test="${not empty errorMessage}">
            <p class="text-danger">${errorMessage}</p>
            </c:if>
        <h3 class="form-title text-center" style="color: #fff">用户注册</h3>

        <div  class="form-group" style="background-color: transparent;border: 0">
        <label class="control-label">用户名称：</label>
        <div class="input-icon">
        <i class="fa fa-user"></i>
        <input class="form-control" name="username" placeholder="用户名称" type="text" required="true"
               onblur="trimText(this),validateChineseText(30, this.value, 'usernameError')" id="username" >
            <span id="usernameError" class="text-danger"></span>
        </div>
        </div>
        <div  class="form-group" style="background-color: transparent;border: 0">
        <label class="control-label">用户密码：</label>
        <div class="input-icon">
        <i class="fa fa-lock"></i>
        <input name="password" class="form-control placeholder-no-fix" placeholder="用户密码" type="password" required="true" id="pwd"
               onblur="checkPassword(this.value)"
               style="padding-left: 33px !important;height:34px;padding: 6px 12px;-webkit-box-shadow:none;box-shadow:none;width: 100%;line-height: 1.4285;vertical-align: middle;border: 1px solid #ccc">
            <span id="passwordError" class="text-danger" ></span>
        </div>
        </div>
        <div  class="form-group" style="background-color: transparent;border: 0">
        <label class="control-label">确认密码：</label>
        <div class="input-icon">
        <i class="fa fa-lock"></i>
        <input id="cPwd" name="password2"  class="form-control placeholder-no-fix" placeholder="确认密码" type="password" required="true"
               <%--data-equalto="#pwd"--%>
               style="padding-left: 33px !important;height:34px;padding: 6px 12px;-webkit-box-shadow:none;box-shadow:none;width: 100%;line-height: 1.4285;vertical-align: middle;border: 1px solid #ccc"
               <%--onblur="checkTwoPassword(document.getElementsByName('password')[0].value,this.value)"--%>
                >
            <span id="cfrmPasswordError" class="text-danger" ></span>
        </div>
        <%--<script id="metamorph-11-start" type="text/x-placeholder"></script><script id="metamorph-11-end" type="text/x-placeholder"></script>--%>
        </div>

        <div id="brandnameDiv" class="ember-view form-group hidden panel" style="background-color: transparent;border: 0">
            <label class="control-label">社区名称：</label>
            <div class="input-icon">
                <i class="fa fa-user"></i>
                <input class="form-control" name="brand_name" placeholder="社区名称"
                       type="text"  onblur="trimText(this)"
                       maxlength="60" id="brand_name">
                <span id="brand_nameError" class="text-danger"></span>
            </div>
        </div>

        <%--<div  class="ember-view hide form-group panel">--%>
        <%--<div  class="ember-view input-group">--%>
            <%--<span  class="ember-view input-group-addon" style="background-color: transparent; cursor: pointer; border-color: #E5E5E5;">--%>
                <%--<img src="/static/guest/property/img/mi2.png" data-bindattr-9="9" style="height: 20px;"></span>--%>
            <%--<div  class="ember-view input-icon right">--%>
                <%--<input id="ember752" class="ember-view ember-text-field form-control" placeholder="验证码" type="text">--%>
        <%--<i class="fa fa-bell-o" data-toggle="tooltip" data-bindattr-10="10"></i>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--</div>--%>
        <div  class="ember-view form-group panel" style="margin: 0;background-color: transparent">
        <label class="checkbox"
                style="padding-left: 0px"><div class="checker" id="uniform-ember754 "><span id="test" >
            <input class="ember-view ember-checkbox" name="trusteeship" value="Y" type="checkbox"
                   style="margin-left: 0"
                    id="trusteeship"
                    onclick="showOrHideBrandName()"></span></div> 由爱米社区托管</label>
            <p class="text-white" style="text-align: right">　　已经有帐号？</p>
        </div>
        <div class="form-actions">
            <%--<button type="submit" class="ember-view btn  pull-right green"><i class="fa fa-arrow-circle-left"></i>&nbsp;<span>注册</span></button>--%>
            <a class="ember-view btn  pull-right green"
               onclick="submitRegist()"><i class="fa fa-arrow-circle-left"></i>&nbsp;<span>注册</span></a>
            <div  class="ember-view btn  btn-default pull-left button-submit btn-default">
                <a href="${ctx}/admin/login" >登录 <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        </form>
        </div>
        <!-- END LOGIN -->
            <div class="backstretch" style="left: 0px; top: 0px; overflow: hidden; margin: 0px; padding: 0px; height: 100%; width: 1903px; z-index: -999999; position: fixed;">
                <img src="/static/admin/img/login22.jpg" style="width: 100%">
            </div>


        <script src="${ctx}/static/admin/js/jquery.min.js"></script>
        <script src="${ctx}/static/admin/js/ie/placeholderfriend.js"></script>
        <!-- Bootstrap -->
        <script src="${ctx}/static/admin/js/bootstrap.js"></script>
        <!-- App -->
        <script src="${ctx}/static/admin/js/app.js"></script>
        <script src="${ctx}/static/admin/js/slimscroll/jquery.slimscroll.min.js"></script>
        <script src="${ctx}/static/admin/js/app.plugin.js"></script>
        <script type="text/javascript" src="${ctx}/static/admin/js/jPlayer/jquery.jplayer.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/admin/js/jPlayer/add-on/jplayer.playlist.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/admin/js/jPlayer/demo.js"></script>
        <!-- parsley -->
        <script src="${ctx}/static/admin/js/parsley/parsley.min.js"></script>
        <script src="${ctx}/static/admin/js/parsley/parsley.extend.js"></script>
        <%--My Script--%>
        <script type="text/javascript" src="${ctx}/static/admin/js/myScript.js"></script>

        <script type="text/javascript">
            //提交注册信息
            function submitRegist(){
                $("#registFrm").parsley("validate");
                //信息合法
                if( $('#registFrm').parsley().isValid() && registUser()){
                    $('#registFrm').submit();
                }
            }

            //注册
            function registUser(){
                //验证用户名最大长度
                var usernameValid = validateChineseText(30,
                        document.getElementById("username").value, "usernameError");
                //验证密码合法性
//                var pwdValid = checkPassword(document.getElementById("pwd").value);
                var pwdValid = checkPassword(document.getElementsByName('password')[0].value);
                //一致两次密码输入是否一致
                var twoPwdValid = checkTwoPassword(document.getElementsByName('password')[0].value,document.getElementsByName('password2')[0].value);
                if(!usernameValid || !pwdValid || !twoPwdValid){
                    return false;
                }
                //选择托管时
                if(document.getElementById('trusteeship').checked ){
                    document.getElementById('brand_nameError').innerHTML = "";
                    //社区总称必填
                    if(document.getElementById('brand_name').value.length == 0){
                        document.getElementById('brand_nameError').innerHTML = "社区总称为必填项";
                        return false;
                    }
                }
                return true;
            }

            //验证密码合法性
            function checkPassword(userPassword){
                var passwordError = document.getElementById("passwordError");
                passwordError.innerText = "";
                var pwdRes = /^[A-Za-z0-9_#@]{6,16}$/;
                //var pwdRes = /((?!^\\d+$)(?!^[a-zA-Z]+$)(?!^[_#@]+$)){8,}/;
                if(!pwdRes.test(userPassword)){
                    passwordError.innerText = "该项只能输入字母、数字及特殊符号（_#@），且只能输入6-16位";
                    return false;
                }

                return true;
            }
            $("#test").click( function(){
                if($("#test").hasClass("checked")){
                    $("#test").removeClass("checked");
                }else{
                    $("#test").addClass("checked");
                }
            });

            //托管时，显示/隐藏社区名称
            function showOrHideBrandName(){
                if(document.getElementById('trusteeship').checked){
                    //显示
                    $('#brandnameDiv').removeClass('hidden');
                }else{
                    //隐藏
                    $('#brandnameDiv').addClass('hidden');
                }
            }

            //两次密码是否一致
            function checkTwoPassword(userPassword, cPwd){
                var cfrmPasswordError = document.getElementById("cfrmPasswordError");
//                var cPwd = document.getElementById("cPwd");
                cfrmPasswordError.innerText = "";
                //两次密码是否一致
                if(userPassword != cPwd){
                    cfrmPasswordError.innerText = "确认密码应该与密码一致.";
                    return false;
                }
                return true;
            }
        </script>

    </body>
</html>