<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
        <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
    <style type="text/css">
        .permit-list{
            display: none;
            position: absolute;
            top: 0%;
            left: 10%;
            background: sandybrown;
            color: black;
            z-index: 10;
            border-radius: 5px;
            padding: 10px;
        }
        @media (min-width: 768px){
            .hsspan {
                vertical-align: top;
                width: 500px;
                display: inline-block;
                word-wrap: break-word;
            }
        }
        @media (max-width: 767px){
            .hsspan {
                vertical-align: top;
                width: 100px;
                display: inline-block;
                overflow-x: hidden;
                text-overflow: ellipsis;/*超出内容显示为省略号*/
                white-space: nowrap;/*文本不进行换行*/
            }
        }
        .pading{
            padding-top: 0px;
            padding-bottom: 10px;
            border:1px solid transparent;
            height: 30px;
            line-height: 30px;

            padding-left: 12px;
        }
        .pading:hover{
            background-color: #c4e1ff;
            color: #000;
        }
        .feetype-ul{
            display:block;
            height: 150px;
            overflow-x:hidden;
            margin: 0;
            padding: 2px;
            border-radius: 4px;
            border:1px solid #cbd5dd;
        }
        .feetype-ul, li{
            list-style: none;
            margin: 0;
            padding: 0
        }
    </style>
</head>
<body class="">

<section id="content"  class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-md b-b">
                用户 /
                <a href="${ctx}/admin/usermanage/roleDistribute">用户管理</a> /
                <span class="font-bold text-shallowred">创建用户</span>
            </header>
                <div class="col-sm-12 pos">
                    <ul id="myTab" class="nav nav-tabs font-bold text-md">
                        <c:choose>
                            <c:when test="${empty querytype or querytype eq 'user'}">
                                <li class="active" onclick="toggleTab('user')"><a data-toggle="tab">用户信息</a></li>
                                <li onclick="toggleTab('district')"><a data-toggle="tab">所管宿舍楼</a></li>
                            </c:when>
                            <c:when test="${'district' eq querytype}">
                                <li onclick="toggleTab('user')"><a data-toggle="tab">用户信息</a></li>
                                <li class="active" onclick="toggleTab('district')"><a data-toggle="tab">所管宿舍楼</a></li>
                            </c:when>
                        </c:choose>
                    </ul>
                    <c:if test="${empty querytype or querytype eq 'user'}">
                        <div style="margin-bottom: 5px">
                            <span id="successMessage" class="text-success">${successMessage}</span>
                            <span id="errorMessage" class="text-danger">${errorMessage}</span>
                        </div>
                        <form class="form-horizontal  form-bordered" data-validate="parsley" action="${ctx}/admin/usermanage/saveUserInfo" method="POST"
                              onsubmit="return submitUserInfo()" id="frm">
                            <section class="panel panel-default m-n">
                                <header class="panel-heading  mintgreen">
                                    <i class="fa fa-gift"></i>
                                    <span class="text-lg">用户信息：</span>
                                </header>
                                <div class="panel-body p-0-15">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>用户名：</label>

                                        <c:if test="${empty platformUser.uuid}">
                                            <div class="col-sm-9  b-l bg-white">
                                                    <input type="text" class="form-control" data-required="true" name="username" id="username" data-maxlength="30"
                                                           onblur="validateChineseText(30, this, 'usernameError')" value="${platformUser.username}"/>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty platformUser.uuid}">
                                            <div class="col-sm-5  b-l bg-white" style="padding-right: 0px;margin-top: 15px">
                                                    <input type="text" class="form-control" data-required="true" name="username" id="username" data-maxlength="30"
                                                           onblur="validateChineseText(30, this, 'usernameError')" value="${platformUser.username}" readonly/>
                                            </div>
                                            <div class="col-sm-2" style="padding-right: 15px;margin-top: 15px;margin-bottom: 15px;">
                                                <button class="btn btn-yellow btn-sm a-noline form-control glyphicon glyphicon-pencil"
                                                        data-toggle="modal" data-target=".bs-example-modal-lg"
                                                        onclick="saveUuidAndVersionno('${platformUser.uuid}','${platformUser.versionno}')">
                                                    修改用户名
                                                </button>
                                            </div>
                                            <div class="col-sm-2" style="padding-right: 15px;margin-top: 15px;margin-bottom: 15px;">
                                                <button class="btn btn-success btn-s-xs form-control"
                                                        data-toggle="modal" data-target=".bs-example-modal-lg-reset"
                                                ><i class="glyphicon glyphicon-repeat"></i>&nbsp;重置密码
                                                </button>
                                            </div>
                                        </c:if>
                                        <span id="usernameError" class="text-danger"></span>
                                    </div>
                                    <c:if test="${empty platformUser.uuid}">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label"><span class="text-danger">*</span>密码：</label>
                                                <div class="col-sm-9  b-l bg-white">
                                                    <input type="password" class="form-control" data-required="true" name="inputPassword" id="inputPassword"
                                                           data-maxlength="30" onblur="checkInputPassword(this.value)"/>
                                                    <span id="inputPasswordError" class="text-danger"></span>
                                                </div>

                                        </div>
                                    </c:if>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>姓名：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <input type="text" class="form-control" data-required="true" name="name" id="name" data-maxlength="90"
                                                   onblur="validateChineseText(90, this, 'nameError')" value="${platformUser.name}"/>
                                            <span id="nameError" class="text-danger"></span>
                                        </div>
                                    </div>
                                        <input name="wechatUserInfoId" id="wechatUserInfoId" value="${wechatUserInfoId}" type="hidden">

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">职位：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <div class="" style="position: relative">
                                                <input type="text" class="form-control my-feetype-ul"  name="title" id="platformUserTitle"
                                                       onkeyup="autoQueryPlatformUserTitleList(this,undefined,undefined)"
                                                       name="platformUserTitle"
                                                       value="${platformUser.title}"
                                                       placeholder="请输入职位"
                                                >
                                                <a class="btn btn-default btn-sm a-noline my-supplier-ul"
                                                   style="margin-top: 2px;position: absolute;top: 0;right: 2px;border: 0;box-shadow: 0 0 0 rgba(255,255,255,1);"
                                                   onclick="queryPlatformUserTitleList(undefined, undefined)"
                                                ><i class="fa fa-search"></i></a>
                                            </div>
                                            <i class="icon-close hidden" id="platformUserTitleClose" style="cursor:pointer;margin-top: 17px;position: absolute;top: 38px;right: 20px;border: 0;box-shadow: 0 0 0 rgba(255,255,255,1);"></i>
                                            <ul class="feetype-ul hidden" id="platformUserTitleUl" style=" padding-top:20px">
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>手机号码：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <input type="text" data-type="phone" data-required="true" class="form-control"
                                                   name="cellphone" id="cellphone" data-maxlength="20"
                                                   onblur="checkPhone(this.value)" value="${platformUser.cellphone}"/>
                                            <span class="text-danger" id="contactnoError"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">状态：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <c:choose>
                                                <c:when test="${platformUser.uuid == null}">
                                                    <input type="text"  class="form-control"  value="正常" readonly/>
                                                    <input type="hidden"   name="status" id="status"  value="NORMAL"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <select class="form-control" id="status" name="status">
                                                        <c:set var="statusList" value="${web:queryCommonCodeList('USER_STATUS')}"></c:set>
                                                        <c:forEach items="${statusList}" var="statusCode">
                                                            <c:if test="${platformUser.status == statusCode.code}">
                                                                <option value="${statusCode.code}" selected>${statusCode.codevalue}</option>
                                                            </c:if>
                                                            <c:if test="${platformUser.status != statusCode.code}">
                                                                <option value="${statusCode.code}">${statusCode.codevalue}</option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                    </div>
                                    <c:if test="${not empty roleList}">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">角色：</label>
                                            <div class="col-sm-9  b-l bg-white">

                                                <c:forEach items="${roleList}" var="role">
                                                    <div class="checkbox i-checks" style="padding-left: 0px;position: relative">
                                                        <label class="checkbox m-n">
                                                            <c:set var="showFlag" value="0" scope="page"></c:set>
                                                            <c:forEach items="${platformUser.roles}" var="userRole">
                                                                <c:if test="${userRole == role.uuid}">
                                                                    <c:set var="showFlag" value="1" scope="page"></c:set>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${showFlag == 1}">
                                                                <input type="checkbox" name="roles" value="${role.uuid}" checked>
                                                                <i></i>
                                                            <span onmouseover="queryPermitListByRoleId(this, '${role.uuid}')"
                                                                  onmouseout="hidePermitList(this)">${role.rolename}</span>
                                                            </c:if>
                                                            <c:if test="${showFlag == 0}">
                                                                <input type="checkbox" name="roles" value="${role.uuid}" >
                                                                <i></i>
                                                            <span onmouseover="queryPermitListByRoleId(this, '${role.uuid}')"
                                                                  onmouseout="hidePermitList(this)">${role.rolename}</span>
                                                            </c:if>
                                                        </label>
                                                        <div class="permit-list"></div>
                                                    </div>
                                                </c:forEach>
                                                <span id="remarksError" class="text-danger"></span>
                                            </div>
                                        </div>
                                    </c:if>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <input type="hidden" name="uuid" id="hidPlatformUserId" class="form-control" value="${platformUser.uuid}">
                                            <input type="hidden" name="versionno" id="hidVersionno" class="form-control" value="${platformUser.versionno}">
                                        </div>
                                    </div>
                                </div>
                                <footer class="panel-footer text-left bg-light lter">
                                    <c:if test="${empty view}">
                                        <button type="submit" class="btn btn-submit btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                                    </c:if>
                                </footer>
                            </section>
                        </form>
                    </c:if>
                    <c:if test="${'district' eq querytype}">
                        <div style="margin-top: 5px">
                            <span id="successMessage" class="text-success">${successMessage}</span>
                            <span id="errorMessage" class="text-danger">${errorMessage}</span>
                        </div>
                        <div class="table-responsive top-margin">
                            <table class="table table-striped b-t b-light b-b b-l b-r">
                                <thead>
                                <tr>
                                    <th width="30%">宿舍楼</th>
                                    <th width="30%">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${dormitoryUserPageList}" var="dormitoryUser" varStatus="stat">
                                    <tr>
                                        <td>
                                                ${dormitoryUser.dormitoryname}
                                        </td>
                                        <td>
                                            <a onclick="showDormitoryUserInfo('${dormitoryUser.uuid}')" type="button"
                                               class="btn btn-sm btn-dangernew  a-noline" style="color:white"
                                               data-toggle="modal" data-target=".bs-example-modal-tj"
                                            >
                                                修改</a>
                                            <c:if test="${currentUserId != platformUser.uuid}">
                                                <a href="javascript:deleteDormitoryUserInfo('${dormitoryUser.uuid}', '${platformUser.uuid}')" type="button"
                                                   class="btn btn-sm btn-yellow a-noline" style="color:white">
                                                    删除</a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <c:if test="${not empty dormitoryUserPageList}">
                                <web:pagination pageList="${dormitoryUserPageList}"/>
                            </c:if>
                        </div>
                        <div class="navbar-left">
                            <c:if test="${fn:length(partialDormitoryList) > 0}">
                                <a class="btn btn-primary btn-s-xs"
                                   data-toggle="modal" data-target=".bs-example-modal-tj" style="color: #fff"
                                   onclick="showDormitoryUserInfo()"
                                >添 加</a>
                            </c:if>
                        </div>
                        <!-- /.modal添加 -->
                        <div class="modal fade bs-example-modal-tj " tabindex="-1" role="dialog"
                             aria-labelledby="myLargeModalLabelTj" aria-hidden="false">
                            <div class="modal-dialog modal-lg" style="margin-top: 15%">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" id="modelCloseBtnAdd"><span
                                                aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                        <h4 class="modal-title" id="myLargeModalLabelAdd">宿舍楼</h4>
                                    </div>
                                    <form action="${ctx}/admin/usermanage/saveDormitoryUser" method="POST" id="addDormitoryUserFrm">
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="row static-info" id="dormitoryAdd">
                                                        <div class="col-md-3 col-xs-4 name"><span class="text-danger">*</span>宿舍楼:</div>
                                                        <div class="col-md-9 col-xs-12 value">
                                                            <div class="my-display-inline-box">
                                                                <select class="form-control" name="dormitoryid" id="dormitoryid" data-required="true">
                                                                    <c:if test="${fn:length(partialDormitoryList) > 0}">
                                                                        <option value="">请选择宿舍楼</option>
                                                                    </c:if>
                                                                    <c:forEach items="${partialDormitoryList}" var="dormitory">
                                                                        <option value="${dormitory.uuid}">${dormitory.name}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div></div>
                                                    </div>

                                                    <p>

                                                    <div class="row col-sm-12" style="padding-left: 0px">

                                                    </div>

                                                    <div class="hidden">
                                                        <input type="hidden" name="userid" value="${platformUser.uuid}">
                                                        <input type="hidden" name="uuid" id="dormitoryUserId">
                                                        <input name="wechatUserInfoId" id="wechatUserInfoId" value="${wechatUserInfoId}" type="hidden">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer" style="text-align: center;border: 0;margin: 10;padding: 0 20px 20px 20px;">
                                                <a href="javascript:saveDormitoryUserInfo()"
                                                   class="btn btn-submit btn-s-md a-noline" style="color: #fff"
                                                   id="submitAddBtn"
                                                >提交</a>
                                                <a href="javascript:deleteDormitoryUserInfo($('#dormitoryUserId').val(), '${platformUser.uuid}')" type="button"
                                                   class="btn btn-s-md btn-yellow a-noline hidden" style="color:white" id="deleteBtn">
                                                    删除</a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <!-- /.modal-content -->
                            </div>
                            <!-- /.modal-dialog -->
                        </div>
                        <!-- /.modal -->
                    </c:if>
            </div>
        </section>
        <!-- /.modal -->
        <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-lg" style="margin-top: 15%">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" id="modelCloseBtn"><span
                                aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="myLargeModalLabel">修改</h4>
                    </div>
                    <form class="form-horizontal" data-validate="parsley" action=""
                          method="POST" id="newUsernamefrm">
                        <div class="modal-body">
                            <div class="row">
                                <label class="col-sm-3 control-label">用户名：</label>
                                <div class="col-sm-9">
                                    <input type="text" style="margin-top: 12px;" class="form-control" data-required="true" name="newUsername" id="newUsername" data-maxlength="30"
                                           onblur="validateChineseText(30, this, 'newUsernameError')" value="${platformUser.username}"/>
                                    <span id="newUsernameError" class="text-danger"></span>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer" style="text-align: center">
                            <a href="javascript:changeUsername($('#hidPlatformUserId').val(),$('#hidVersionno').val())"
                               class="btn btn-submit btn-s-md a-noline"
                            >保存</a>
                        </div>
                    </form>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->



        <!-- /.modal -->
        <div class="modal fade bs-example-modal-lg-reset" tabindex="-1" role="dialog"
             aria-labelledby="myLargeModalLabelForReset"
             aria-hidden="true"
             id="bs-example-modal-lgid-reset">
            <div class="modal-dialog modal-lg" style="margin-top: 15%">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" id="modelCloseBtnForReset"><span
                                aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="myLargeModalLabelForReset">重置</h4>
                    </div>
                    <form class="form-horizontal" data-validate="parsley" action=""
                          method="POST" id="passwordfrm"
                          onsubmit="return checkFileType()">
                        <div class="modal-body">
                            <div class="row">
                                <label class="col-sm-3 control-label">密码：</label>
                                <div class="col-sm-9">
                                    <input type="password" style="margin-top: 12px;" class="form-control"  name="password" id="password" data-maxlength="30"
                                           value=""/>
                                </div>
                            </div>
                            <div class="row">
                                <label class="col-sm-3 control-label">确认密码：</label>
                                <div class="col-sm-9">
                                    <input type="password" style="margin-top: 12px;" class="form-control"  name="checkpassword" id="checkpassword" data-maxlength="30"
                                           onblur="checkPassword(this.value)" value=""/>
                                    <span id="passwordError" class="text-danger"></span>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer" style="text-align: center">
                            <a href="javascript:resetPassword($('#hidPlatformUserId').val(),$('#hidVersionno').val(),$('#password').val())"
                               class="btn btn-submit btn-s-md a-noline"
                            >保存</a>
                        </div>
                    </form>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<%--<script src="${ctx}/static/admin/js/sweetalert.min.js"></script>--%>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">
        if('district' != '${querytype}'){
            var options = {
                url: function(phrase) {
                    //解决IE get 中文乱码
                    return encodeURI("${ctx}/admin/usermanage/getStaffInfoByName?name=" + phrase);
                },

                getValue: "openid",

                list: {
                    maxNumberOfElements: 10
                },

                template: {
                    type: "description",
                    fields: {
                        description: "name"
                    }
                }
            };
            /*$("#openid").easyAutocomplete(options);*/
        }

    //提交用户信息
    function submitUserInfo(){
        //检查用户名
        var usernameValid = validateChineseText(30, document.getElementById('username'), 'usernameError');
         //检查姓名
        var nameValid = validateChineseText(90, document.getElementById('name'), 'nameError');

        return usernameValid && nameValid;
    }


        function changeUsername(platformUserId,versionno){
            window.location.href = "${ctx}/admin/usermanage/changeUsername?newUsername="+$('#newUsername').val()+"&platformUserId="+platformUserId+"&versionno="+versionno;
        }
        function resetPassword(platformUserId,versionno,password){
            $("#passwordfrm").parsley("validate");

            if($('#passwordfrm').parsley().isValid()){
                if(checkPassword(password)){
                    passwordfrm.action = "${ctx}/admin/usermanage/resetPassword?platformUserId="+platformUserId+"&versionno="+versionno;
                    passwordfrm.submit();
                }
            }
        }
        function changeUserStatus(platformUserId,versionno,querytype){
            if(${allCommunities && platformUser.status == 'FREEZE'}){
                var url = "${ctx}/admin/usermanage/checkIfDormitoryUser?userId="+platformUserId;
                $.get(url,function(data,status){
                    if(data.checkIfDormitoryUserFlag == 'N'){
                        qikoo.dialog.confirm('未添加宿舍楼，确定生效？',function(){
                            //确定
                            window.location.href = "${ctx}/admin/usermanage/changeUserStatus?platformUserId="+platformUserId+"&versionno="+versionno+"&querytype="+querytype;
                        },function(){
                            //取消
                        });
                    }else{
                        window.location.href = "${ctx}/admin/usermanage/changeUserStatus?platformUserId="+platformUserId+"&versionno="+versionno+"&querytype="+querytype;
                    }
                });
            }else{
                window.location.href = "${ctx}/admin/usermanage/changeUserStatus?platformUserId="+platformUserId+"&versionno="+versionno+"&querytype="+querytype;
            }

        }

        function checkInputPassword(userPassword){
            var passwordError = document.getElementById("inputPasswordError");
            passwordError.innerText = "";
            var pwdRes = /^[A-Za-z0-9_#@]{6,16}$/;
            if(!pwdRes.test(userPassword)){
                passwordError.innerText = "该项只能输入字母、数字及特殊符号（_#@），且只能输入6-16位";
                return false;
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
            var password = $('#password').val();
            var checkpassword = $('#checkpassword').val();
            if(password != checkpassword){
                passwordError.innerText = "两次密码输入不一致！";
                return false;
            }



            return true;
        }
        function checkPhone(phone) {
            var contactnoError = document.getElementById('contactnoError');
            contactnoError.innerHTML = "";
            trimText(document.getElementById('cellphone'));
            var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
            if (!myreg.test(phone)) {
                contactnoError.innerHTML = "请输入正确的手机号！";
                return false;
            } else {
                return true;
            }
        }
        //保存uuid和versionno
        function saveUuidAndVersionno(platformUserId, versionno) {
            $('#hidPlatformUserId').val(platformUserId);
            $('#hidVersionno').val(versionno);
        }
        //自动查询职位
        function autoQueryPlatformUserTitleList(obj,inputFlag,callback){
            trimText(obj);
            if($(obj).val().length >= 1){
                queryPlatformUserTitleList(inputFlag, callback);
            }
        }
        //查询已有的职位列表
        function queryPlatformUserTitleList(inputFlag, callback){
            trimText(document.getElementById('platformUserTitle'));
            var url = "${ctx}/admin/usermanage/queryPlatformUserTitleList?platformUserTitle=" + $('#platformUserTitle').val();
            $.get(url
                    ,function(data,status){
                        $('#platformUserTitleUl').html('');
                        if(data.platformUserTitleList.length > 0){
                            $('#platformUserTitleUl').removeClass('hidden');
                            $('#platformUserTitleClose').removeClass('hidden');
                        }else{
                            $('#platformUserTitleUl').addClass('hidden');
                            $('#platformUserTitleClose').addClass('hidden')
                        }

                        for(var i=0; i<data.platformUserTitleList.length; i++){
                            $('#platformUserTitleUl').append('<li class="pading">' + data.platformUserTitleList[i] + '</li>');
                        }

                        $('.pading').on('click', function(){
                            $('#platformUserTitle').val($(this).text());
                            if(undefined != callback){
                                callback();
                            }
                            $('#platformUserTitleUl').addClass('hidden');
                            $('#platformUserTitleClose').addClass('hidden')
                        });
                        $('#platformUserTitleClose').on('click', function(){
                            $('#platformUserTitleUl').addClass('hidden');
                            $('#platformUserTitleClose').addClass('hidden')
                        });
                    });
        }

    window.onload = function(){
        //显示父菜单
        showParentMenu('用户');
    }

    function resubmitSearch(page){
        var frm = document.getElementById('frm');
        frm.action = "${ctx}/admin/usermanage/saveUserInfo?page=" + page;
        frm.submit();
    }

    function sendTestMessage(){
        var openid = document.getElementById("openid").value;
        if(openid==null||openid==""){
            qikoo.dialog.alert("微信openid不能为空");
        }else{
            qikoo.dialog.confirm('确定发送模板？',function(){
                //确定
                $.get("${ctx}/admin/usermanage/sendMessageToOpenid?openid="+openid,function(data,status){

                    if(data.successMessage != undefined || data.errorMessage != undefined){
                        if(data.successMessage != undefined){
                            $("#successMessage").text(data.successMessage);
                        }
                        if(data.errorMessage != undefined){
                            $("#errorMessage").text(data.errorMessage);
                        }
                    }
                });
            },function(){
                //取消
            });
        }
    }

    //检查是否已关注
    function checkIfSubscribe(){
        var openid = document.getElementById("openid").value.trim();
        var subscribeInfo = document.getElementById("subscribeInfo");
        subscribeInfo.innerHTML = "";
        if(openid.length > 0){
            //确定
            $.get("${ctx}/admin/usermanage/checkIfSubscribe?openid="+openid+"&version="+Math.random(),function(data,status){

                if(data.subscribeFlag != undefined && data.subscribeFlag == 1){
                    subscribeInfo.innerHTML = "已关注 - " + data.nickname;
                }else{
                    subscribeInfo.innerHTML = "未关注";
                }
            });
        }
    }
    /*if('district' != '${querytype}'){
        checkIfSubscribe();
    }*/

    //根据角色查询权限
    function queryPermitListByRoleId(obj, roleId){
        $('.permit-list').hide();
        $.get("${ctx}/admin/usermanage/queryPermitListByRoleId?roleId="+roleId,function(data,status){
            var permitList = data.permitList;
            if(undefined != data.permitList.length && data.permitList.length > 0){
                var htmlStr = "";
                for(var i=0; i< permitList.length; i++){
                    var childHtmlStr = "";
                    if(undefined != permitList[i].childPermits){
                        for(var j=0; j<permitList[i].childPermits.length; j++){
                            childHtmlStr += "<span style='margin-left: 10px'>" + permitList[i].childPermits[j].permitname + "</span>";
                        }
                    }
                    htmlStr += "<div class='font-bold'>" + permitList[i].permitname+ "</div><div style='padding-left: 10px'>" + childHtmlStr +"</div>";
                }
                $(obj).parent().parent().find(".permit-list").html(htmlStr);
                $(obj).parent().parent().find(".permit-list").show();
            }
        });
    }

    //隐藏权限列表
    function hidePermitList(obj){
        $(obj).parent().parent().find(".permit-list").hide();
    }

    //切换选项卡
    function toggleTab(tabId){
        var wechatUserInfoId = $('#wechatUserInfoId').val();
        window.location.href = "<%=request.getContextPath()%>/admin/usermanage/userInfo?userId=${platformUser.uuid}&querytype="+tabId+"&wechatUserInfoId="+wechatUserInfoId;
    }

    function saveDormitoryUserInfo(){
        $("#addDormitoryUserFrm").parsley("validate");
        //检查支信息合法性
        if($('#addDormitoryUserFrm').parsley().isValid()){
            $('#addDormitoryUserFrm').submit();
        }
    }

    function showDormitoryUserInfo(dormitoryUserId){
        //修改
        if(undefined != dormitoryUserId){
            $.get("${ctx}/admin/usermanage/queryDormitoryUserInfo?dormitoryUserId="+dormitoryUserId+"&version=" + Math.random(),function(data,status){
                if(undefined != data.dormitoryUser){
                    $('#dormitoryid').append($("<option>").val(data.dormitoryUser.dormitoryid).text(data.dormitoryUser.dormitoryname));
                    $('#dormitoryid').val(data.dormitoryUser.dormitoryid);
                    $('#dormitoryUserId').val(data.dormitoryUser.uuid);
                }
            });
        }else{
            //添加
            $('#dormitoryid').val("");
        }
    }


    function deleteDormitoryUserInfo(dormitoryUserId, userId){
        if(confirm("确定删除?")){
            //确定
            window.location.href = "<%=request.getContextPath()%>/admin/usermanage/deleteDormitoryUser?userId="+userId+"&dormitoryUserId="+dormitoryUserId;
        }
    }
</script>

</body>
</html>