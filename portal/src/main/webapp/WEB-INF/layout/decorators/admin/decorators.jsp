<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <meta charset="utf-8"/>
    <title>宿舍管理系统</title>
    <meta name="description"
          content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache,no-store, must-revalidate">
    <META HTTP-EQUIV="pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="expires" CONTENT="0">
    <%--设定要用IE8标准模式渲染网页，而不用兼容的模式--%>
    <meta http-equiv="X-UA-Compatible" content="IE=EDGE">
    <link rel="shortcut icon" type="image/x-icon" href="/favicon.ico" media="screen"/>
    <link rel="stylesheet" href="${ctx}/static/admin/css/bootstrap.min.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/admin/css/animate.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/admin/css/font-awesome.min.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/admin/css/simple-line-icons.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/admin/css/font.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/admin/css/app.css" type="text/css"/>

    <link rel="stylesheet" href="${ctx}/static/admin/js/datepicker/datepicker.css" type="text/css"/>

    <%--myStyle.css--%>
    <link rel="stylesheet" href="${ctx}/static/admin/css/myStyel.css" type="text/css"/>

    <%--autocomplete--%>
    <link rel="stylesheet" href="${ctx}/static/admin/css/easy-autocomplete.min.css">
    <link rel="stylesheet" href="${ctx}/static/admin/css/easy-autocomplete.themes.min.css">
    <%--star-rating--%>
    <link rel="stylesheet" href="${ctx}/static/admin/css/star-rating/star-rating.css" type="text/css" media="all"/>
    <%--datetime--%>
    <link rel="stylesheet" href="${ctx}/static/admin/css/bootstrap-datetimepicker.min.css" type="text/css">

    <script src="${ctx}/static/admin/js/jquery.min.js"></script>

    <!-- Bootstrap -->
    <script src="${ctx}/static/admin/js/bootstrap.min.js"></script>
    <!-- App -->
    <script src="${ctx}/static/admin/js/app.js"></script>
    <script src="${ctx}/static/admin/js/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="${ctx}/static/admin/js/app.plugin.js"></script>

    <!-- datepicker -->
    <script src="${ctx}/static/admin/js/datepicker/bootstrap-datepicker.js"></script>
    <%--datetime--%>
    <script src="${ctx}/static/admin/js/datepicker/bootstrap-datetimepicker.js"></script>

    <%--My Script--%>
    <script type="text/javascript" src="${ctx}/static/admin/js/myScript.js"></script>

    <%--autocomplete--%>
    <script src="${ctx}/static/admin/js/autocomplete/jquery.easy-autocomplete.min.js"></script>

    <%--star-rating--%>
    <%--<script type="text/javascript" src="${ctx}/static/admin/js/star-rating/star-rating.js"></script>--%>

    <!--[if lt IE 9]>
    <script src="${ctx}/static/admin/js/ie/html5shiv.js"></script>
    <script src="${ctx}/static/admin/js/ie/respond.min.js"></script>
    <script src="${ctx}/static/admin/js/ie/excanvas.js"></script>
    <![endif]-->

    <sitemesh:write property="head"/>
</head>
<style>
    .user > li{
        float: right;
    }

     /*滚动条运行轨道*/
    ::-webkit-scrollbar-track {
        background: #fff;
    }

    /* 滚动条自身 */
    ::-webkit-scrollbar-thumb {
        background: #fff;
    }

    /* 手机端左上角弹出菜单样式 */
    .nav-off-screen {
        display: block !important;
        position: absolute;
        left: 0;
        top: 0px;
        bottom: 0;
        width: 60%;
        visibility: visible;
        overflow-x: hidden;
        overflow-y: auto;
        -webkit-overflow-scrolling: touch;
    }
    @media (max-width: 767px){
        .hidden-nav-xs{
            opacity: 0;
        }
        .currentCommunityid{
            position: relative;
            top: -44px;
            margin-left: 13%;
        }
        .header{
            max-height: 50px;
        }
        .nav-user{
            background-color: #2b3643;
            position: relative;
            top: -46px;
            width: 107%;
        }
    }
    #currentCommunityid{
        width: 75%;
        height: 30px;
        padding: 1px 0 2px 0;
        font-size: 14px;
        line-height: 30px;
        color: #555;
        vertical-align: middle;
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 2px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
        box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
        -webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
        transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    }

    .my-hidden-lg{
        display: none;
    }
    @media (max-width: 767px){
        .my-hidden-lg{
            display: block;
        }
    }

    .nav>li>a:hover, .nav>li>a:focus {
        text-decoration: none;
        background-color: transparent;
    }
</style>
<body class="">
<section class="vbox">
<header class=" header header-md navbar navbar-fixed-top-xs" style="background-color: #2b3643;padding-right: 20px">
<div class="navbar-header aside" style="padding-left:20px;padding-right: 20px">
    <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html">
        <i class="icon-list"></i>
    </a>
    <a href="${ctx}/admin/home" class=" text-lt">
        <%--<i class="icon-earphones"></i>--%>
        <%--<img src="${ctx}/static/admin/img/logo.png" alt="." >--%>
            <span class=" m-l-sm" style="font-size: 16px;line-height: 46px;padding-left: 10px;">
                <span class="text-white">宿舍</span><span style="color: #ff3f3f">管理系统</span></span>
    </a>
    <a class=" btn-link visible-xs" data-toggle="dropdown" data-target=".user" style="  text-align: right;text-decoration: none;
  font-size: 18px;
  float: right;
  position: absolute;
  top: 15px;
  right: 0;">
        <i class="icon-settings" style="padding: 10px"></i>
    </a>

</div>
<ul class="nav navbar-nav hidden-xs" id="toggle">
    <li>
        <a href="#nav,.navbar-header" data-toggle="class:nav-xs,nav-xs" style="padding: 0;line-height: 46px;color: #fff">
            <i class="fa fa-bars text"></i>
            <i class="fa fa-bars text-active"></i>
        </a>
    </li>
</ul>




    <div class="navbar-right col-sm-7 col-md-5 col-xs-12" id="hide">
    <ul class="nav navbar-nav m-n hidden-xs nav-user user text-right">

        <li class="dropdown">
           <%-- <img alt="" class=" dropdown-toggle img-circle" src="/static/guest/property/img/mi.png" style="width: 11%;"
                 data-toggle="dropdown">--%>
            <a href="#" class="dropdown-toggle bg clear" data-toggle="dropdown"
               style="padding: 0;line-height: 46px;display:inline;color: #999c9e" >
                <shiro:principal/>
                <b class="caret"></b>
            </a>
            <ul class="dropdown-menu animated fadeInRight"
                style="  box-shadow: 5px 5px rgba(102,102,102,.1);margin-top: 8px;border-radius: 4px;padding: 0;">
                    <span style="border-left: 10px solid transparent;border-right: 10px solid transparent; border-bottom: 10px solid #fff;position: absolute;top: -8px;right:5px;"></span>
                <li>
                    <i class="icon-key" style="padding-left: 20px"></i>
                    <a href="${ctx}/admin/changePassword" style="display: inline-block">修改密码</a>
                </li>
                <li class="divider" style="margin: 0"></li>
                <li>
                    <i class="icon-lock" style="padding-left: 20px"></i>
                    <a href="#" style="display: inline-block">帮助</a>
                </li>
                <li class="divider" style="margin: 0"></li>
                <li>
                    <i class="icon-envelope-open" style="padding-left: 20px"></i>
                    <a href="${ctx}/admin/logout" data-toggle="ajaxModal" style="display: inline-block">退出</a>
                </li>
            </ul>
        </li>
    </ul>
        <c:if test="${!empty wpCommunityList || !empty suggestion || !empty wpSuggestion}">
            <div class="nav col-sm-4 col-xs-10 text-white text-center currentCommunityid"  style="padding:0 0 0 6%;line-height: 46px">
                <c:if test="${!empty wpCommunityList}">
                    <select  name="currentCommunityid" id="currentCommunityid" onchange="changeCurrentCommunity()">
                        <c:forEach items="${wpCommunityList}" var="community">
                            <c:if test="${currentCommunityid == community.uuid}">
                                <option value="${community.uuid}" selected>${community.name}</option>
                            </c:if>
                            <c:if test="${currentCommunityid != community.uuid}">
                                <option value="${community.uuid}">${community.name}</option>
                            </c:if>
                        </c:forEach>

                    </select>
                </c:if>
                <a href="${ctx}/admin/home" class="btn btn-link my-hidden-lg" style="font-size: 22px;float: right;position: relative;left: -5%;
                <c:if test="${not empty suggestion && not empty wpSuggestion}">
                        margin-left: 20px;
                </c:if>
                        ">
                    <i class="fa fa-home"></i>
                </a>
            </div>
        </c:if>
</div>

</header>
<section>
    <section class="hbox stretch">
        <!-- .aside -->
        <aside class="bg-black dk aside hidden-print" id="nav">
            <section class="vbox">
                <%--<section class="w-f-md scrollable" style="bottom: 0px">--%>
                <section class="w-f-md" style="bottom: 0px">
                    <%--<div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="10px" data-railOpacity="0.2">--%>
                    <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0"
                         data-size="10px" data-railOpacity="0.2"
                         style="overflow: auto;height:100%;" id="menuDiv">


                        <nav class="nav-primary hidden-xs">
                            <c:set var="menuList" value="${web:getMenuList()}"/>
                            <ul class="nav" data-ride="collapse" id="bluebg">
                                <%--<li class="hidden-nav-xs padder m-t m-b-sm text-xs text-muted">--%>
                                <%--Interface--%>
                                <%--</li>--%>
                                <c:forEach items="${menuList}" var="parentMenu">
                                    <li style="border-bottom: 1px solid #3d4957;">
                                        <a
                                            <c:if test="${not empty parentMenu.childPermits}">
                                                href="#"
                                            </c:if>
                                            <c:if test="${empty parentMenu.childPermits}">
                                                href="${ctx}/${parentMenu.permitresource}"
                                            </c:if>
                                                class="auto blackbg"
                                                id="${parentMenu.uuid}">
                                            <span class="ss" style="display: table-column;width: 0;height:0"></span>
                                    <span class="pull-right text-muted">
                                      <i class="fa fa-angle-left text"></i>
                                      <i class="fa fa-angle-down text-active"></i>
                                    </span>
                                            <i class="${parentMenu.menuicon} icon">
                                            </i>
                                            <span>${parentMenu.permitname}</span>
                                        </a>
                                        <c:if test="${fn:length(parentMenu.childPermits) > 0}">
                                            <ul class="nav dk text-sm">
                                                <c:forEach items="${parentMenu.childPermits}" var="menu">

                                                    <c:if test="${not empty menu.childPermits}">
                                                        <li>
                                                            <a class="auto">
                                                        <span class="pull-right text-muted">
                                                          <i class="fa fa-angle-left text"></i>
                                                          <i class="fa fa-angle-down text-active"></i>
                                                        </span>
                                                                <i class="fa fa-angle-right text-xs"></i>
                                                                <span>${menu.permitname}</span>
                                                            </a>
                                                            <c:forEach items="${menu.childPermits}" var="mn">
                                                                <ul class="nav dk text-sm">
                                                                    <li>
                                                                        <a href="${ctx}/${mn.permitresource}"
                                                                           class="auto">
                                                                            <i class="fa fa-angle-right text-xs"></i>
                                                                            <span>${mn.permitname}</span>
                                                                        </a>
                                                                    </li>
                                                                </ul>
                                                            </c:forEach>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${empty menu.childPermits}">
                                                        <li>
                                                            <a href="${ctx}/${menu.permitresource}" class="auto">
                                                                <i class="fa fa-angle-right text-xs"></i>
                                                                <span>${menu.permitname}</span>
                                                            </a>
                                                        </li>
                                                    </c:if>

                                                </c:forEach>
                                            </ul>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </ul>

                        </nav>
                    </div>
                </section>

            </section>
        </aside>
        <!-- /.aside -->
        <sitemesh:write property="body"/>
    </section>
</section>
</section>

<!-- file input -->
<script src="${ctx}/static/admin/js/file-input/bootstrap-filestyle.min.js"></script>

<!-- parsley -->
<script src="${ctx}/static/admin/js/parsley/parsley.min.js"></script>
<script src="${ctx}/static/admin/js/parsley/parsley.extend.js"></script>
<script>
    $('#bluebg').children().on('click', function () {
        $('.ss').removeClass('selected-arrows');
        $(this).children('a').children('.ss').addClass('selected-arrows');
        $('.blackbg').css('background', '#3d4957');
        $('#bluebg').children().children('a').find("*").css('color', '#b4bcc8');
        $(this).children('a').css('background', '#36c6d3');
        $(this).children('a').find("*").css('color', '#fff');
    })
    $('#hide').children().on('click',function(){
        $('#hide').removeClass('open');
    })
        $("#toggle").click(function(){
            if(click){
                tab();
            }else{
                tabnone();
            }
        });
    var click=true;
    function tab(){
    $(".navbar-header").css("padding","0");
    $(".navbar-header").find(".m-l-sm").css({"margin":"0","padding":0,"line-height":"1.2"});
    $(".m-l-sm").find("span").css("color","#2b3643");
        click=false;
    }
    function tabnone(){
    $(".navbar-header").css("padding","0 20px");
    $(".navbar-header").find(".m-l-sm").css({"margin-left":"10px","padding-left":"10px","line-height":"46px"});
    $(".m-l-sm").find("span").eq(0).css("color","#fff");
    $(".m-l-sm").find("span").eq(1).css("color","#ff3f3f");
        click=true;
                }

    function changeCurrentCommunity(communityid){
        var newCommunityId = $('#currentCommunityid').val();

        window.location.href = "<%=request.getContextPath()%>/admin/home?newCommunityId=" + newCommunityId;
    }

    //判断是否使用的是ipad
    function isIpad(){
        var ua = navigator.userAgent.toLowerCase();
        if(/ipad/i.test(ua))
        {
            return true;
        }
        else{
            return false;
        }

    }

    //pad下，默认菜单收缩
    if(isIpad()){
        tab();
        $(".navbar-header").addClass('nav-xs');
        $('#nav').addClass('nav-xs');
        if(window.location.href.indexOf('signType=padSign')>0){
            resizeCanvas();
        }
    }
</script>
</body>
</html>