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
                公众号 / <span class="font-bold  text-shallowred"> 用户分组管理</span>
            </header>
            <div class="bg-white closel">
                <div class="col-sm-12 no-padder">
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <c:if test="${not empty wechatBinding}">
                        <div class="table-responsive">
                            <table class="table table-striped b-t b-light b-b b-l b-r">
                                <thead>
                                <tr>
                                    <th width="15%">ID</th>
                                    <th width="25%">分组名称</th>
                                    <th width="15">用户人数</th>
                                    <th width="25%">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${wechatGroupList}" var="wechatGroup" varStatus="stat">
                                    <tr>
                                        <td>
                                                ${wechatGroup.id}
                                        </td>
                                        <td>
                                                ${wechatGroup.name}
                                        </td>
                                        <td>
                                                ${wechatGroup.count}
                                        </td>
                                        <td>
                                            <a onclick="showGroupInfo('${wechatGroup.id}','${wechatGroup.name}')" type="button" data-toggle="modal" data-target=".bs-example-modal-lg">
                                                <button type="button" class="btn btn-sm btn-dangernew  a-noline">修改</button></a>
                                            <a href="javascript:deleteGroup('${wechatGroup.id}')" type="button"
                                               class="btn btn-sm btn-yellow a-noline" style="color:white;">
                                                删除</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="navbar-left">
                            <button class="btn btn-sm btn-submit" onclick="showGroupInfo('','')" data-toggle="modal" data-target=".bs-example-modal-lg">创建用户分组</button>
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
                            <h4 class="modal-title" id="myLargeModalLabel">创建用户分组</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group" style="border: 0;background-color: #fff;height: 50px;">
                                        <label class="col-sm-3 control-label">分组名称：</label>
                                        <div class="col-sm-7 control-label">
                                            <input type="text" class="form-control" name="wechatGroupName" id="wechatGroupName" data-maxlength="15"
                                                   onblur="trimText(this)">
                                            <span id="titleError" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="col-sm-12 text-center">
                                            <a onclick="createGroup()">
                                                <button type="button" class="btn btn-outline btn-submit" id="wechatBtn">创建分组</button></a>
                                        </div>
                                    </div>
                                    <div>
                                        <input type="hidden" name="wechatGroupId" id="wechatGroupId">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<%--<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>--%>
<%--<script src="${ctx}/static/admin/js/sweetalert.min.js"></script>--%>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">
    //创建用户分组
    function showGroupInfo(id,name){
        $('#wechatGroupId').val(id);
        $('#wechatGroupName').val(name);
        if(id == null || id == ''){
            $('#wechatBtn').text("创建分组");
        }else{
            $('#wechatBtn').text("修改分组");
        }
    }

    //创建用户分组
    function createGroup(){
        window.location.href = "<%=request.getContextPath()%>/admin/account/createGroup?groupId="+$('#wechatGroupId').val()+"&name="+$('#wechatGroupName').val();
    }
    //删除用户分组
    function deleteGroup(groupId){
        <%--swal({--%>
            <%--title: "确定删除?",--%>
            <%--text: "你将删除该分组!",--%>
            <%--type: "warning",--%>
            <%--showCancelButton: true,--%>
            <%--confirmButtonColor: "#DD6B55",--%>
            <%--confirmButtonText: "确定",--%>
            <%--closeOnConfirm: false--%>
        <%--}, function () {--%>
            <%--window.location.href = "<%=request.getContextPath()%>/admin/account/deleteGroup?groupId="+groupId;--%>
        <%--});--%>
        qikoo.dialog.confirm('确定删除？',function(){
            //确定
            window.location.href = "<%=request.getContextPath()%>/admin/account/deleteGroup?groupId="+groupId;
        },function(){
            //取消
        });
    }

</script>
</body>
</html>