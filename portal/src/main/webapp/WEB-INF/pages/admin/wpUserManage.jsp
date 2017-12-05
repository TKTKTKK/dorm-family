<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <%--<link href="${ctx}/static/admin/css/sweetalert.css" rel="stylesheet">--%>
        <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
</head>
<body class="">

<section id="content">
<section class="vbox">
<section class="scrollable">
<header class="panel-heading bg-white text-lg">
    满田星 / 关注用户列表
</header>

<c:if test="${not empty wechatBinding}">

    <div id="propertyStaff" class="bg-white closel">
        <div id="myTabContent" class="tab-content">
            <div style="margin-bottom: 5px">
                <span class="text-success">${successMessage}</span>
                <span class="text-danger">${errorMessage}</span>
            </div>
            <div id="homeStaff" class="tab-pane fade in active">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="table-responsive">
                            <table class="table table-striped  b-light  b-l b-r b-t b-b">
                                <thead>
                                <tr>
                                    <th >Openid</th>
                                    <th>昵称</th>
                                    <th>头像</th>
                                    <th>姓名</th>
                                    <th>联系方式</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${wpUserList}" var="wpUser">
                                    <tr>
                                        <td >
                                                ${wpUser.openid}
                                        </td>
                                        <td>
                                                ${wpUser.nickname}
                                        </td>
                                        <td>
                                            <c:if test="${not empty wpUser.headimgurl}">
                                                <c:if test="${fn:indexOf(wpUser.headimgurl, 'static') == 0}">
                                                    <img src="${wpUser.headimgurl}" width="50" height="50">
                                                </c:if>
                                                <c:if test="${fn:indexOf(wpUser.headimgurl, 'static') != 0}">
                                                    <img src="${wpUser.headimgurl}" width="50" height="50">
                                                </c:if>
                                            </c:if>
                                        </td>
                                        <td>
                                                ${wpUser.name}
                                        </td>
                                        <td>
                                                ${wpUser.contactno}
                                        </td>
                                        <td>

                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <c:if test="${not empty wpUserList}">
                                <web:pagination pageList="${wpUserList}"/>
                            </c:if>
                        </div>
                        <div class="navbar-left">
                            <button class="btn btn-sm btn-submit" onclick="syncWpUserInfo()"> 同步关注用户信息</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${empty wechatBinding}">
    <span style="margin-left: 10px">您还没有添加公众号，请先去</span>
    <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
</c:if>
</section>
</section>
<a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<script src="${ctx}/static/admin/js/jquery.blockui.min.js"></script>
<%--<script src="${ctx}/static/admin/js/sweetalert.min.js"></script>--%>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">
    //同步认证用户信息
    function syncWpUserInfo(){
        <%--swal({--%>
            <%--title: "确定同步?",--%>
            <%--text: "你将同步所有关注的用户信息到该列表中!",--%>
            <%--type: "warning",--%>
            <%--showCancelButton: true,--%>
            <%--confirmButtonColor: "#DD6B55",--%>
            <%--confirmButtonText: "确定",--%>
            <%--closeOnConfirm: false--%>
        <%--}, function () {--%>
            <%--window.location.href = "<%=request.getContextPath()%>/admin/account/synAttentionUserInfo";--%>
        <%--});--%>
        qikoo.dialog.confirm('你将同步所有关注的用户信息到该列表中，确定同步？',function(){
            //确定
            window.location.href = "<%=request.getContextPath()%>/admin/account/synAttentionUserInfo";
        },function(){
            //取消
        });
    }

</script>
</body>
</html>