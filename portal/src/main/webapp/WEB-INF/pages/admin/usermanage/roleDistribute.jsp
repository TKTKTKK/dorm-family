<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
        <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
    <style>
        @media (min-width: 768px){
            .hsspan {
                vertical-align: top;
                width: 200px;
                display: inline-block;
                word-wrap: break-word;
            }
        }
        @media (max-width: 767px){
            .hsspan {
                vertical-align: top;
                width: 200px;
                display: inline-block;
                overflow-x: hidden;
                text-overflow: ellipsis;/*超出内容显示为省略号*/
                white-space: nowrap;/*文本不进行换行*/
            }
        }
        .specialTable .table tbody>tr>td{
            border-right: 1px solid #ddd;
        }
    </style>
</head>
<body class="">

<section id="content">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                用户 / <span class="font-bold  text-shallowred"> 用户管理</span>
            </header>
            <div class="bg-white closel">
                <div class="col-sm-12 no-padder">
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <c:if test="${not empty wechatBinding}">
                    <form method="post" action="" class="form-horizontal" data-validate="parsley" id="searchForm" style="margin: 10px 0">
                        <div>
                            <c:choose>
                                <c:when test="${allDormitorys}">
                                    <div class="col-sm-3 col-xs-12 m-b-sm">
                                        <select class="form-control" name="topAccount"  id="topAccount" onchange="showDormitoryid()">
                                                <option value="Y" <c:if test="${'Y' eq topAccount}">selected="selected"</c:if>>顶级用户</option>
                                                <option value="N" <c:if test="${'N' eq topAccount}">selected="selected"</c:if>>非顶级用户</option>
                                        </select>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                        <input type="hidden" name="topAccount" id="topAccount" value="N">
                                </c:otherwise>
                            </c:choose>
                            <div class="col-sm-3 col-xs-12 m-b-sm" id="dormitoryidDiv">
                                <select class="form-control" name="dormitoryid"  id="dormitoryid">
                                    <c:if test="${allDormitorys}">
                                        <option value="">宿舍楼</option>
                                    </c:if>

                                    <c:forEach items="${dormitoryList}" var="dormitory">
                                        <option value="${dormitory.uuid}" <c:if test="${dormitoryid == dormitory.uuid}">selected = "selected"</c:if> >${dormitory.name}</option>
                                    </c:forEach>

                                </select>
                            </div>
                            <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">

                                <input type="text" class="form-control" id="username" name="username"
                                       data-maxlength="11"
                                       value="${username}"
                                       placeholder="用户名"
                                >
                            </div>

                            <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">

                                <input type="text" class="form-control" id="name" name="name"
                                       data-maxlength="11"
                                       value="${name}"
                                       placeholder="姓名"
                                >
                            </div>

                            <div style="clear: both"></div>
                            <div class="row col-sm-12 text-muted text-center" style="padding-right: 5px;">
                                <button type="button" class="btn btn-submit btn-s-xs"
                                        id="submitBtn"
                                        onclick="submitInfo()">查 询
                                </button>
                                <a href="javascript:showUserInfo()" class="btn btn-primary btn-s-xs"  style="color: #fff">新建用户</a>
                                <%--<div class="col-sm-1 text-right" style="float: right">
                                    <c:if test="${not empty staffqrcode}">
                                        <img src="${staffqrcode}" style="width: 100px;height: 100px;margin-top: -56px;"
                                             data-toggle="modal" data-target=".bs-example-modal-lg">
                                    </c:if>
                                </div>
                                <a href="${ctx}/admin/usermanage/wechatUserManage" class="btn btn-primary btn-s-xs"  style="color: #fff;float: right;">用户微信</a>--%>
                            </div>
                        </div>
                       </form>
                        <%--<p>&nbsp;</p>--%>
                        <div class="table-responsive specialTable"
                             style="width: 100%;overflow-x: scroll;overflow-y: hidden;">
                            <table class="table table-striped b-t b-light b-b b-l b-r text-center">
                                <thead>
                                <tr>
                                    <th class="text-center">用户名</th>
                                    <th class="text-center">姓名</th>
                                    <th class="text-center">职位</th>
                                    <c:if test="${topAccount == 'N'}">
                                        <th class="text-center">宿舍楼</th>
                                    </c:if>
                                    <th class="text-center">操作</th>
                                </tr>
                                </thead>
                                <tbody>

                                <c:forEach items="${platformUserList}" var="platformUser" varStatus="status">
                                    <tr>
                                        <c:choose>
                                            <c:when test="${status.index > 0
                                                                && platformUserList[status.index].uuid eq platformUserList[status.index-1].uuid}">
                                                <td style="border-top: 0px">
                                                    &nbsp;
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>
                                                        ${platformUser.username}
                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${status.index > 0
                                                                && platformUserList[status.index].uuid eq platformUserList[status.index-1].uuid}">
                                                <td style="border-top: 0px">
                                                    &nbsp;
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>
                                                        ${platformUser.name}
                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${status.index > 0
                                                                && platformUserList[status.index].uuid eq platformUserList[status.index-1].uuid}">
                                                <td style="border-top: 0px">
                                                    &nbsp;
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>
                                                        ${platformUser.title}
                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${topAccount == 'N'}">
                                            <td>
                                                    ${platformUser.dormitoryname}
                                            </td>
                                        </c:if>
                                        <c:choose>
                                            <c:when test="${status.index > 0
                                                                && platformUserList[status.index].uuid eq platformUserList[status.index-1].uuid}">
                                                <td style="border-top: 0px">
                                                    &nbsp;
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td>
                                                    <a href="javascript:goModifyuserInfo('${platformUser.uuid}','${dormitoryid}')"  type="button"
                                                       class="btn btn-sm btn-dangernew  a-noline" style="color:white">
                                                        修改</a>
                                                    <c:if test="${currentUserId != platformUser.uuid}">
                                                        <a href="javascript:deleteUserInfo('${platformUser.uuid}')" type="button"
                                                           class="btn btn-sm btn-yellow a-noline" style="color:white">
                                                            删除</a>
                                                    </c:if>

                                                </td>
                                            </c:otherwise>
                                        </c:choose>

                                    </tr>
                                </c:forEach>
                                </tbody>

                            </table>
                            <c:if test="${not empty platformUserList}">
                                <web:pagination pageList="${platformUserList}" postParam="true"/>
                            </c:if>
                        </div>

                        <div style="clear: both"></div>
                    </c:if>
                    <c:if test="${empty wechatBinding}">
                        <span>您还没有添加公众号，请先去</span>
                        <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
                    </c:if>
                </div>
            </div>
            <!-- /.modal -->
            <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">

                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" id="modelCloseBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title" id="myLargeModalLabel">扫码提交</h4>
                        </div>
                        <%--<c:if test="${!empty staffqrcode}">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <img src="${staffqrcode}" width="100%" height="100%"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <span>*&nbsp;请用微信扫码或长按识别二维码，提交用户及微信信息</span>
                                    </div>
                                </div>
                            </div>
                        </c:if>--%>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('用户');

        var topAccount = $("#topAccount").find("option:selected").val();
        if(topAccount == 'Y'){
            $("#dormitoryidDiv").addClass("hidden");
        }
        if(topAccount == 'N'){
            $("#dormitoryidDiv").removeClass("hidden");
        }
    }

    function resubmitSearch(page){
        window.location.href = "<%=request.getContextPath()%>/admin/usermanage/roleDistribute?topAccount="+$('#topAccount').val()+"&page="+page+"&dormitoryid="+$('#dormitoryid').val()+"&username="+$('#username').val()+"&name="+$('#name').val();
    }
    function submitInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/usermanage/roleDistribute?topAccount="+$('#topAccount').val()+"&dormitoryid="+$('#dormitoryid').val()+"&username="+$('#username').val()+"&name="+$('#name').val();
    }
    function goModifyuserInfo(userId,dormitoryid){
        window.location.href="${ctx}/admin/usermanage/userInfo?userId="+userId+"&dormitoryid="+dormitoryid+"&username="+$('#username').val()+"&name="+$('#name').val()+"&topAccount="+$('#topAccount').val();
    }

    function showDormitoryid(){
        var topAccount = document.getElementById('topAccount').value;
        if(topAccount == 'Y'){
            $("#dormitoryidDiv").addClass("hidden");
        }
        if(topAccount == 'N'){
            $("#dormitoryidDiv").removeClass("hidden");
        }
    }

    //用户信息界面
    function showUserInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/usermanage/userInfo";
    }

    //删除用户
    function deleteUserInfo(userId){
        qikoo.dialog.confirm('确定删除？',function(){
            //确定
            $.get("${ctx}/admin/usermanage/deleteUser?userId="+userId+"&dormitoryid=${dormitoryid}&version="+Math.random(),function(data,status){
                if(undefined != data.deleteFlag){
                    window.location.href = "<%=request.getContextPath()%>/admin/usermanage/roleDistribute?topAccount="+$('#topAccount').val()+"&dormitoryid="+$('#dormitoryid').val()+"&username="+$('#username').val()+"&name="+$('#name').val()+"&deleteFlag=1";
                }
            });
        },function(){
            //取消
        });
    }

    //重载当前页面
    function reloadPage(){
        resubmitSearch(1);
    }
</script>
</body>
</html>