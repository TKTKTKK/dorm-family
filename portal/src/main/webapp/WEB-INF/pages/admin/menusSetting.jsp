<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
<style>
    .dlStyle{
        padding: 20px 10px;
    }
    .dtStyle{
       padding: 8px 0;
       margin-bottom: 6px;
       text-align: center;
       background-color: #36c6d3  ;
    }
    .dtStyleAdd{
        border: 1px solid #dedede;
        padding: 8px 0;
        font-weight: normal;
        margin-bottom: 6px;
        text-align: center;
    }
    .ddStyle{
        border: 1px solid #fff;
        padding: 5px 0;
        text-align: center;
        background-color: #36c6d3  ;
    }
    .ddStyleAdd{
        border: 1px solid #dedede;
        padding: 5px 0;
        text-align: center;
    }
    .whiteFont{
        color: #fff;
    }
    .choosedMenu{
        background-color: #17a05a;
    }

    #myexample a:hover,#myexample a:focus {
        color: #871F78;
        text-decoration: none;
    }

</style>
</head>
<body class="">

<section id="content">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                公众号 / <span class="font-bold  text-shallowred"> 菜单管理</span>
            </header>
                <div class="bg-white pos wrapper-md" style="padding: 20px">
                    <c:if test="${not empty wechatBinding}">
                        <ul id="myTab" class="nav nav-tabs">
                            <c:choose>
                                <c:when test="${empty queryType || 'url' eq queryType}">
                                    <li class="active" onclick="toggleTab('url')"><a data-toggle="tab">URL转换</a></li>
                                    <li onclick="toggleTab('wechat')"><a data-toggle="tab">公众号页面</a></li>
                                </c:when>
                                <c:when test="${empty queryType || 'wechat' eq queryType}">
                                    <li onclick="toggleTab('url')"><a data-toggle="tab">URL转换</a></li>
                                    <li class="active" onclick="toggleTab('wechat')"><a data-toggle="tab">公众号页面</a></li>
                                </c:when>
                            </c:choose>
                        </ul>

                        <c:if test="${empty queryType || 'url' eq queryType}">
                                    <div>
                                        <span class="text-success">${successMessage}</span>
                                        <span class="text-danger">${errorMessage}</span>
                                    </div>
                                    <section class="panel panel-default" >
                                        <%--<header class="panel-heading">--%>
                                            <%--<strong>URL转换：</strong>--%>
                                        <%--</header>--%>
                                        <form id="frm" action="${ctx}/admin/account/exchangeUrl" method="POST" class="b-l b-r b-b form-horizontal">
                                        <div class="panel-body p-0-15">
                                            <div class="form-group" style="border-bottom: 1px solid #efefef">
                                                <label class="col-sm-3 control-label">原地址：</label>
                                                <div class="col-sm-9 b-l bg-white">
                                                    <input type="text" class="form-control" id="originUrl" name="originUrl"
                                                           value="${originUrl}"/>
                                                    <span class="text-danger" id="errorUrl"></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label">转换后地址：</label>
                                                <div class="col-sm-9 b-l bg-white">
                                                    <textarea class="form-control" rows="8" id="tempUrl">${tempUrl}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                            <div class="panel-footer text-left bg-light lter">
                                                <div class="dropdown">
                                                    <c:if test="${wechatBinding.authorized eq 'Y'}">
                                                    <button class="btn btn-submit btn-s-xs" type="button" onclick="exchangeUrlComp()">
                                                        component转换
                                                    </button>
                                                    </c:if>
                                                    <c:if test="${wechatBinding.authorized ne 'Y'}">
                                                    <button class="btn btn-submit btn-s-xs" type="button" onclick="exchangeUrl()">
                                                        OAuth转换
                                                    </button>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </form>
                                    </section>
                        </c:if>

                        <c:if test="${'wechat' eq queryType}">
                                <div class="col-sm-12 pos no-padder" style="height: 800px;margin-top: 0;">
                                    <div style="margin-bottom: 5px;margin-right: 30px;text-align: right;">
                                        <a id="menusModifyBtn" href="#" style="margin-top: 10px;    background-color: #36c6d3;color:white" onclick="showMenusname()" class="btn btn-s-xs">更改菜单组名称</a>
                                        <a href="#" style="margin-top: 10px;" onclick="deleteWechatMenu()" class="btn btn-dangernew  btn-s-xs">清除微信所有菜单</a>
                                    </div>
                                    <div class="col-sm-2">
                                        <ul  class="nav nav-tabs tabs-left" id="menusUl" style="border-bottom: 0;">
                                            <c:forEach items="${wpMenuNameList}" var="wpMenu" varStatus="status">
                                                <c:if test="${wpMenu.menusname eq menusFlag}">
                                                   <li class="active" onclick="showMenu('${wpMenu.menusname}')"><a data-toggle="tab">${wpMenu.menusname}</a></li>
                                                </c:if>
                                                <c:if test="${wpMenu.menusname ne menusFlag}">
                                                    <li onclick="showMenu('${wpMenu.menusname}')"><a data-toggle="tab">${wpMenu.menusname}</a></li>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${not empty wpMenuNameList}">
                                               <li onclick="addMenu()"><a data-toggle="tab">新增个性化菜单</a></li>
                                            </c:if>
                                            <c:if test="${empty wpMenuNameList}">
                                                <li class="active"><a data-toggle="tab">默认菜单</a></li>
                                            </c:if>
                                        </ul>
                                    </div>
                                    <div class="col-sm-10">
                                        <div style="margin-bottom: 5px">
                                            <span id="successId" class="text-success">${successMessage}</span>
                                            <span id="errorId" class="text-danger">${errorMessage}</span>
                                        </div>
                                        <section  id="menusDetail"style="display:block;"  class="panel panel-default"  style="margin: 0;-webkit-box-shadow:0 1px 1px rgba(0,0,0,0) !important;box-shadow: 0 1px 1px  rgba(0,0,0,0) !important">
                                            <div class="panel-body clearfix" style="padding: 0">
                                                <div class="col-sm-6 pull-left" >
                                                    <form id="menuSetId" class="form-horizontal form-bordered" method="POST">
                                                        <header class="panel-heading mintgreen">
                                                            <i class="fa fa-gift"></i>
                                                            <span class="text-lg">菜单：</span>
                                                        </header>
                                                        <div class="panel-body p-0-15">
                                                            <div class="row" style="height: 402px;">
                                                                <div id="myexample" class="col-sm-12">
                                                                    <c:forEach items="${wpMenuList}" var="wpMenu" varStatus="status">
                                                                        <c:if test="${fn:length(wpMenuList) > 0}">
                                                                            <c:if test="${status.index eq '0' and wpMenu.orderno ne '1'}">
                                                                                <dl class="nav navbar-nav col-sm-4 dlStyle" id="mainMenu1">
                                                                                    <dt class="dtStyleAdd">
                                                                                        <a href="#" onclick="addMainMenu(this,1)" class="dropdown-toggle"><span class="fa fa-plus-circle" style="padding-right: 3px;"></span>添加主菜单</a>
                                                                                    </dt>
                                                                                </dl>
                                                                            </c:if>
                                                                            <c:if test="${status.index eq '0' and wpMenu.orderno ne '1' and wpMenu.orderno ne '2'}">
                                                                                <dl class="nav navbar-nav col-sm-4 dlStyle" id="mainMenu2">
                                                                                    <dt class="dtStyleAdd">
                                                                                        <a href="#" onclick="addMainMenu(this,2)" class="dropdown-toggle"><span class="fa fa-plus-circle" style="padding-right: 3px;"></span>添加主菜单</a>
                                                                                    </dt>
                                                                                </dl>
                                                                            </c:if>
                                                                            <c:if test="${status.index eq '1' and wpMenu.orderno ne '2'}">
                                                                                <dl class="nav navbar-nav col-sm-4 dlStyle" id="mainMenu2">
                                                                                    <dt class="dtStyleAdd">
                                                                                        <a href="#" onclick="addMainMenu(this,2)" class="dropdown-toggle"><span class="fa fa-plus-circle" style="padding-right: 3px;"></span>添加主菜单</a>
                                                                                    </dt>
                                                                                </dl>
                                                                            </c:if>
                                                                            <dl class="nav navbar-nav col-sm-4 dlStyle" id="mainMenu${wpMenu.orderno}">
                                                                                <dt class="dtStyle">
                                                                                    <a href="#" onclick="showDetail(this,${wpMenu.orderno},0)" class="dropdown-toggle whiteFont"></span>${wpMenu.name}</a>
                                                                                </dt>
                                                                                <c:forEach items="${wpMenu.wpChildMenuList}" var="wpMenuChild">
                                                                                    <dd class="ddStyle">
                                                                                        <a href="#" onclick="showDetail(this,${wpMenu.orderno},${wpMenuChild.orderno})" class="dropdown-toggle whiteFont">${wpMenuChild.name}</a>
                                                                                    </dd>
                                                                                </c:forEach>
                                                                                <c:if test="${fn:length(wpMenu.wpChildMenuList) <5 }">
                                                                                    <dd class="ddStyleAdd">
                                                                                        <a href="#" onclick="addChildMenu(this,${wpMenu.orderno})" class="dropdown-toggle"><span class="fa fa-plus-circle" style="padding-right: 3px;"></span>添加子菜单</a>
                                                                                    </dd>
                                                                                </c:if>
                                                                            </dl>
                                                                        </c:if>

                                                                    </c:forEach>
                                                                </div>
                                                            </div>
                                                            <div class="row" style="margin: 10px  0;">
                                                                <div class="col-sm-12">

                                                                </div>
                                                                <div class="col-sm-12" id="btnMenu">
                                                                    <a href="#" style="margin-top: 10px;" onclick="removeLineMenu(1)" class="btn btn-success btn-s-xs">清除第一列设定</a>
                                                                    <a href="#" style="margin-top: 10px;" onclick="removeLineMenu(2)" class="btn btn-success btn-s-xs">清除第二列设定</a>
                                                                    <a href="#" style="margin-top: 10px;" onclick="removeLineMenu(3)" class="btn btn-success btn-s-xs">清除第三列设定</a>
                                                                    <a href="#" style="margin-top: 10px;" onclick="removeMenu()" class="btn btn-success btn-s-xs">清除所有设定</a>
                                                                </div>

                                                            </div>
                                                        </div>

                                                    </form>
                                                </div>
                                                <div class="col-sm-6 pull-right" >
                                                    <div class="form-horizontal form-bordered">
                                                        <header class="panel-heading  mintgreen">
                                                            <i class="fa fa-gift"></i>
                                                            <span class="text-lg">详情：</span>
                                                        </header>
                                                        <div class="panel-body p-0-15">
                                                            <div class="form-group">
                                                                <label class="col-sm-3 control-label">菜单名称：</label>
                                                                <div class="col-sm-9 b-l bg-white">
                                                                    <input type="text" class="form-control" id="menuname" name="menuname" maxlength="10"
                                                                           onblur="trimText(this)"/>
                                                                    <span class="text-danger" id="menunameError"></span>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="col-sm-3 control-label">菜单类型：</label>
                                                                <div class="col-sm-9 b-l bg-white">
                                                                    <input type="radio" value="VIEW"  name="menutype">链接跳转
                                                                    <input type="radio" value="COMPLEX"  name="menutype">按钮
                                                                </div>
                                                            </div>
                                                            <div id="urlSetting" style="display:block;">
                                                                <div class="form-group" style="background-color: #fff">
                                                                    <label class="col-sm-3 control-label">跳转链接：</label>
                                                                    <div class="col-sm-9 b-l bg-white">
                                                                            <textarea  class="form-control" id="menulink" name="menulink" rows="12" maxlength="2000"
                                                                                       onblur="trimText(this)"/></textarea>
                                                                        <span class="text-danger" id="menulinkError"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <input type="hidden" name="dlno" id="dlno">
                                                                <input type="hidden" name="ddno" id="ddno">
                                                            </div>
                                                        </div>
                                                        <div class="footer panel-footer text-left bg-light lter" style="display: none;"  id="subBtn">
                                                            <div class="col-sm-12">
                                                                <button onclick="submitMenuDetail()"  class="btn btn-success btn-s-xs">保 存</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row" style="margin: 10px  0;">
                                                <div class="col-sm-12">
                                                    <a href="#" onclick="applyMenu()" class="btn btn-success btn-s-xs">生成公众号菜单</a>
                                                </div>
                                            </div>
                                        </section>

                                        <section id="menusMain" class="panel panel-default" style="display:none;margin: 0;-webkit-box-shadow:0 1px 1px rgba(0,0,0,0) !important;
                                                 box-shadow: 0 1px 1px  rgba(0,0,0,0) !important">
                                            <div class="b-l b-r b-b form-horizontal" style="padding: 0">
                                                <div class="panel-body p-0-15">
                                                    <div class="form-group" style="border-bottom: 1px solid #efefef">
                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>菜单组名称：</label>
                                                        <div class="col-sm-9 b-l bg-white">
                                                            <input type="text" class="form-control" id="menusname" name="menusname"
                                                                   value="${menusname}"/>
                                                            <span class="text-danger" id="errorMenusname"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="border-bottom: 1px solid #efefef;display: none;">
                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>菜单类型：</label>
                                                        <div class="col-sm-9 b-l bg-white">
                                                            <input type="text" class="form-control" id="menustype" name="menustype"
                                                                   value="${menustype}"/>
                                                            <span class="text-danger" id="errorMenustype"></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group" id="userGroup">
                                                        <label class="col-sm-3 control-label">用户分组ID：</label>
                                                        <div class="col-sm-9 b-l bg-white">
                                                            <select id="groupid" class="form-control" name="groupid" value="${groupid}">
                                                                <c:forEach items="${wechatGroupList}" var="group">
                                                                    <c:if test="${group.id == groupid}">
                                                                        <option value="${group.id}" selected>${group.name}</option>
                                                                    </c:if>
                                                                    <c:if test="${group.id != groupid}">
                                                                        <option value="${group.id}">${group.name}</option>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </select>
                                                            <span class="text-danger" id="errorGroupid"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel-footer text-left bg-light lter">
                                                    <div class="col-sm-12">
                                                        <a href="#" onclick="addNewMenu()" class="btn btn-success btn-s-xs">新增菜单组</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </section>

                                        <section id="modifyName" class="panel panel-default" style="display:none;margin: 0;-webkit-box-shadow:0 1px 1px rgba(0,0,0,0) !important;
                                                 box-shadow: 0 1px 1px  rgba(0,0,0,0) !important">
                                            <div class="b-l b-r b-b form-horizontal" style="padding: 0">
                                                <div class="panel-body p-0-15">
                                                    <div class="form-group" style="border-bottom: 1px solid #efefef">
                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>菜单组名称：</label>
                                                        <div class="col-sm-9 b-l bg-white">
                                                            <input type="text" class="form-control" id="newname" name="newname"/>
                                                            <span class="text-danger" id="errorNewname"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div>
                                                    <input type="hidden" id="oldname" name="oldname">
                                                </div>
                                                <div class="panel-footer text-left bg-light lter">
                                                    <div class="col-sm-12">
                                                        <a href="#" onclick="modifyMenusname()" class="btn btn-success btn-s-xs">确 认</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </section>
                                    </div>
                                </div>
                        </c:if>
                    </c:if>
                    <c:if test="${empty wechatBinding}">
                        <span>您还没有添加公众号，请先去</span>
                        <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
                    </c:if>
                </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<script type="text/javascript">
    window.onload = function(){
        //显示父菜单
        showParentMenu('公众号');

        //公众号页面
        if('wechat' == '${queryType}'){
            var myexample = document.getElementById('myexample');
            var num = myexample.getElementsByTagName("dl").length;

            if(num<3){
                $("#myexample").append("<dl class='nav navbar-nav col-sm-4 dlStyle' id='mainMenu"+(num+1)+"'><dt class='dtStyleAdd'><a href='#' onclick='addMainMenu(this,"+(num+1)+")' class='dropdown-toggle'><span class='fa fa-plus-circle' style='padding-right: 3px;'></span>添加主菜单</a></dt></dl>");
            }
        }

        if('默认菜单' == '${menusFlag}'){
            $("#menusModifyBtn").css('display','none');
        }

        $("input[name='menutype'][value='VIEW']").attr("checked",true);
    }

    function toggleTab(tabId){
        if("wechat"==tabId){
            window.location.href = "<%=request.getContextPath()%>/admin/account/menusSetting?queryType="+tabId+"&menusFlag=默认菜单";
        }
        window.location.href = "<%=request.getContextPath()%>/admin/account/menusSetting?queryType="+tabId;
    }

    function exchangeUrl(){
        var originUrl = document.getElementById("originUrl").value;
        var searchForm = document.getElementById("frm");
        searchForm.action = "${ctx}/admin/account/menusSetting?exchageType=OAuthFilter&queryType=url";
        searchForm.submit();
    }

    function exchangeUrlComp(){
        var originUrl = document.getElementById("originUrl").value;
        var searchForm = document.getElementById("frm");
        searchForm.action = "${ctx}/admin/account/menusSetting?exchageType=ComponentOAuthFilter&queryType=url";
        searchForm.submit();
    }

    function addMainMenu(obj,dlno){
        var myexample = document.getElementById('myexample');
        var num = myexample.getElementsByTagName("dl").length;
        obj.innerHTML="新增主菜单";
        obj.onclick= function(){
            showDetail(obj,dlno,0);
        };
        showDetail(obj,dlno,0);
        $("#mainMenu"+dlno+" dt").removeClass("dtStyleAdd");
        $("#mainMenu"+dlno+" dt").addClass("dtStyle");
        $("#mainMenu"+dlno+" dt a").addClass("whiteFont");
        $("#mainMenu"+dlno).append("<dd class='ddStyleAdd'><a href='#' onclick='addChildMenu(this,"+dlno+")' class='dropdown-toggle'><span class='fa fa-plus-circle' style='padding-right: 3px;'></span>添加子菜单</a></dd>");

        if(num<3){
            $("#myexample").append("<dl class='nav navbar-nav col-sm-4 dlStyle' id='mainMenu"+(num+1)+"'><dt class='dtStyleAdd'><a href='#' onclick='addMainMenu(this,"+(num+1)+")' class='dropdown-toggle'><span class='fa fa-plus-circle' style='padding-right: 3px;'></span>添加主菜单</a></dt></dl>");
        }
    }

    function addChildMenu(obj,dlno){
        var mainMenu = document.getElementById('mainMenu'+dlno);
        var num = mainMenu.getElementsByTagName("dd").length;
        obj.innerHTML="新增子菜单";
        obj.onclick= function(){
            showDetail(obj,dlno,num);
        };
        showDetail(obj,dlno,num);
        $("#mainMenu"+dlno+" dd").removeClass("ddStyleAdd");
        $("#mainMenu"+dlno+" dd").addClass("ddStyle");
        $("#mainMenu"+dlno+" dd a").addClass("whiteFont");
        if(num<5){
            $("#mainMenu"+dlno).append("<dd class='ddStyleAdd'><a href='#' onclick='addChildMenu(this,"+dlno+")' class='dropdown-toggle'><span class='fa fa-plus-circle' style='padding-right: 3px;'></span>添加子菜单</a></dd>");
        }
    }

    function removeMenu(){
        $.post("${ctx}/admin/account/deleteMenu",{menusname:$('#menusname').val()},function(data,status){
            var flag = data.flag;
            if(flag == "1"){
                $('#successId').text("菜单删除成功");
            }else{
                $('#errorId').text("菜单删除失败");
            }
            //重载页面
           toggleTab('wechat');
        });
        $("#myexample dl").remove();
        $("#myexample").append("<dl class='nav navbar-nav col-sm-4 dlStyle' id='mainMenu1'><dt class='dtStyleAdd'><a href='#' onclick='addMainMenu(this,1)' class='dropdown-toggle'><span class='fa fa-plus-circle' style='padding-right: 3px;'></span>添加主菜单</a></dt></dl>");
    }

    function removeLineMenu(dlno){
        $.post("${ctx}/admin/account/deleteMenu",{dlno:dlno,menusname:$('#menusname').val()},function(data,status){
            var flag = data.flag;
            if(flag == "1"){
                $('#successId').text("菜单删除成功");
            }else{
                $('#errorId').text("菜单删除失败");
            }
        });
        $("#mainMenu"+dlno+" dt").remove();
        $("#mainMenu"+dlno+" dd").remove();
        $("#mainMenu"+dlno).append("<dt class='dtStyleAdd'><a href='#' onclick='addMainMenu(this,"+dlno+")' class='dropdown-toggle'><span class='fa fa-plus-circle' style='padding-right: 3px;'></span>添加主菜单</a></dt>");
    }

    function showDetail(obj,dlno,ddno){
        var mainMenu = document.getElementById('mainMenu'+dlno);
        $("#myexample dt").removeClass("choosedMenu");
        $("#myexample dd").removeClass("choosedMenu");
        if(obj.parentNode.tagName=="DT"){
              $('#mainMenu'+dlno+" dt").addClass("choosedMenu");
        }else{
              $('#mainMenu'+dlno+" dd:eq("+(ddno-1)+")").addClass("choosedMenu");
        }
        $('#dlno').val(dlno);
        $('#ddno').val(ddno);
        $("#subBtn").css('display','block');
        $.post("${ctx}/admin/account/queryMenu",{dlno:dlno,ddno:ddno,menusname:$('#menusname').val()},function(data,status){
            var wpMenu = data.wpMenu;
            if(wpMenu!=null){
                $('#menuname').val(wpMenu.name);
                $('#menulink').val(wpMenu.link);
                if("VIEW"==wpMenu.type){
                    $('input').removeAttr('checked');
                    $("input:radio[name='menutype']").eq(1).prop("checked",false);
                    $("input:radio[name='menutype']").eq(0).prop("checked",true);

                    $("#urlSetting").css('display','block');
                }
                if("COMPLEX"==wpMenu.type){
                    $('input').removeAttr('checked');
                    $("input:radio[name='menutype']").eq(0).prop("checked",false);
                    $("input:radio[name='menutype']").eq(1).prop("checked",true);
                    $("#urlSetting").css('display','none');
                }
                if($('#ddno').val()=="0"){
                    $("#mainMenu"+ dlno+" dt a").text(wpMenu.name);
                }else{
                    $("#mainMenu"+ dlno+" dd:eq("+(ddno-1)+") a").text(wpMenu.name);
                }
                return;
            }
            $('input').removeAttr('checked');
            $("input:radio[name='menutype']").eq(1).prop("checked",false);
            $("input:radio[name='menutype']").eq(0).prop("checked",true);

            $("#urlSetting").css('display','block');
        });

    }

    function submitMenuDetail(){
        if(checkRequired()){

            $.post("${ctx}/admin/account/setMenu",{dlno:$('#dlno').val(),ddno:$('#ddno').val(),name:$('#menuname').val(),type:getRadioValue(),link:$('#menulink').val(),menusname:$('#menusname').val(),menustype:$('#menustype').val(),groupid:$('#groupid').val()},function(data,status){
                var wpMenu = data.wpMenu;
                var masterNO = data.masterNO;
                var successTxt = data.successTxt;
                var childNo = data.childNo;
                if(masterNO == "Y"){
                    alert("请先设置第"+$('#dlno').val()+"个主菜单");
                    return;
                }
                if(childNo!=null&&childNo!=''){
                    alert("请先设置第"+$('#dlno').val()+"列，第"+childNo+"个子菜单");
                    return;
                }
                $('#menuname').val(wpMenu.name);
                $('#menulink').val(wpMenu.link);
                if($('#ddno').val()=="0"){
                    $("#mainMenu"+ $('#dlno').val()+" dt a").text(wpMenu.name);
                }else{
                    $("#mainMenu"+ $('#dlno').val()+" dd:eq("+($('#ddno').val()-1)+") a").text(wpMenu.name);
                }

                $('#successId').text(successTxt);
                //清空报错
                $('#menunameError').text("");
                $('#menulinkError').text("");
                //添加新增个性菜单button
                addNewMenuLi();
            });
        }

    }

    function checkRequired(){
        var name = $('#menuname').val();
        var link = $('#menulink').val();
        if(name==null || name ==""){
            $('#menunameError').text("必填");
            return false;
        }
        if((link==null || link =="")&& "block" == $("#urlSetting").css('display')){
            $('#menulinkError').text("必填");
            return false;
        }
        return true;
    }

    function getRadioValue(){
        var chkObjs = document.getElementsByName("menutype");
        for(var i=0;i<chkObjs.length;i++){
            if(chkObjs[i].checked){
                return chkObjs[i].value;
            }
        }
    }

    $("input:radio[name='menutype']").change(function (){
       if("VIEW" == getRadioValue()){
           $('input').removeAttr('checked');
           $("input:radio[name='menutype']").eq(1).prop("checked",false);
           $("input:radio[name='menutype']").eq(0).prop("checked",true);
           $("#urlSetting").css('display','block');
       }else{
           $('input').removeAttr('checked');
           $("input:radio[name='menutype']").eq(0).prop("checked",false);
           $("input:radio[name='menutype']").eq(1).prop("checked",true);
           $("#urlSetting").css('display','none');
       }
    })

    function applyMenu(){
        var searchForm = document.getElementById("menuSetId");
        searchForm.action = "${ctx}/admin/account/applyMenu?name="+$('#menusname').val();
        searchForm.submit();
    }

    function deleteWechatMenu(){
        var searchForm = document.getElementById("menuSetId");
        searchForm.action = "${ctx}/admin/account/deleteWechatMenu";
        searchForm.submit();
    }

    function addMenu(){
        $("#menusname").val("");
        $("#groupid").val("");
        $("#menusMain").css('display','block');
        $("#menusDetail").css('display','none');
        $("#menusModifyBtn").css('display','none');
    }

    function showMenu(menusname){
        window.location.href = "<%=request.getContextPath()%>/admin/account/menusSetting?queryType=${queryType}&menusFlag="+menusname;
    }

    function addNewMenu(){
        if(checkNewMenus()){
            $('#menusUl li:last-child').remove();
            var menusname = $('#menusname').val();
            $('#menusUl').append("<li class='active' onclick='showMenu("+menusname+")'><a data-toggle='tab'>"+menusname+"</a></li>");
//            addNewMenuLi();
            $("#menusModifyBtn").css('display','inline-block');
            $('#menusMain').css('display','none');
            $('#menusDetail').css('display','block');
            $('#myexample dl').remove();
            var myexample = document.getElementById('myexample');
            $('#myexample').append("<dl class='nav navbar-nav col-sm-4 dlStyle' id='mainMenu1'><dt class='dtStyleAdd'><a href='#' onclick='addMainMenu(this,1)' class='dropdown-toggle'><span class='fa fa-plus-circle' style='padding-right: 3px;'></span>添加主菜单</a></dt></dl>");
        }
    }

    function checkNewMenus(){
        if($('#menusname').val()==null || $('#menusname').val()==""){
            $('#errorMenusname').text("用户分组必填");
        }
        if($('#groupid').val()==null || $('#groupid').val()==""){
            $('#errorGroupid').text("用户分组必填");
        }
        $.post("${ctx}/admin/account/queryMenusname",{menusname:$('#menusname').val()},function(data,status){
            var isRepeat = data.isRepeat;
            if(isRepeat == "Y"){
                $('#errorMenusname').text("菜单组名称已存在");
                return false;
            }
        });
        $('#menustype').val("S");
        return true;
    }

    function addNewMenuLi(){
        if($('#menusUl li:last-child a').text() != "新增个性化菜单"){
            $('#menusUl').append("<li onclick='addMenu()'><a data-toggle='tab'>新增个性化菜单</a></li>");
        }
    }


    function showMenusname(){
        $("#menusDetail").css('display','none');
        $('#modifyName').css('display','block');
        $('#oldname').val($('#menusname').val());
    }

    function modifyMenusname(){
        $.post("${ctx}/admin/account/modifyMenusname",{oldname:$('#oldname').val(),newname:$('#newname').val()},function(data,status){
            var flag = data.flag;
            if(flag == "1"){
                $('#errorNewname').text("菜单组名称已存在");
                return;
            }
            if(flag == "2"){
                $('#menusname').val($('#newname').val());
                $("#menusUl li.active").html("<a data-toggle='tab'>"+$('#newname').val()+"</a>");
                $('#modifyName').css('display','none');
                $("#menusDetail").css('display','block');
                return;
            }
            window.location.href = "<%=request.getContextPath()%>/admin/account/menusSetting?queryType=wechat&menusFlag="+$('#newname').val();

        });
    }

</script>
</body>
</html>