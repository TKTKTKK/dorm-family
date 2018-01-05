<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>

</head>
<body class="">
<section id="content">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                用户 / <span class="font-bold  text-shallowred">权限管理</span>
            </header>
            <div class="bg-white closel">
                <div class="col-sm-12 clearfix no-padder">
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <c:if test="${not empty wechatBinding}">
                    <ul id="myTab" class="nav nav-tabs text-md">
                        <c:choose>
                            <c:when test="${'role' eq signType}">
                                <li class="active" onclick="toggleTab('role')"><a data-toggle="tab">角色配置</a></li>
                                <li onclick="toggleTab('permit')"><a data-toggle="tab">资源对应</a></li>
                                <li onclick="toggleTab('rolepermit')"><a data-toggle="tab">权限配置</a></li>
                            </c:when>
                            <c:when test="${'permit' eq signType}">
                                <li onclick="toggleTab('role')"><a data-toggle="tab">角色配置</a></li>
                                <li class="active" onclick="toggleTab('permit')"><a data-toggle="tab">资源对应</a></li>
                                <li onclick="toggleTab('rolepermit')"><a data-toggle="tab">权限配置</a></li>
                            </c:when>
                            <c:when test="${'rolepermit' eq signType}">
                                <li onclick="toggleTab('role')"><a data-toggle="tab">角色配置</a></li>
                                <li onclick="toggleTab('permit')"><a data-toggle="tab">资源对应</a></li>
                                <li class="active" onclick="toggleTab('rolepermit')"><a data-toggle="tab">权限配置</a></li>
                            </c:when>
                        </c:choose>
                    </ul>
                    <c:if test="${'role' eq signType}">
                        <div class="table-responsive">
                            <table class="table table-striped  b-light b-b b-l b-r">
                                <thead>
                                <tr>
                                    <th width="30%">角色ID</th>
                                    <th width="40%">角色名称</th>
                                    <th width="30%">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${roleList}" var="role" varStatus="num">
                                    <tr>
                                        <td>
                                                ${role.rolekey}
                                        </td>
                                        <td>
                                                ${role.rolename}
                                        </td>
                                        <td>
                                            <c:if test="${empty role.bindroleid}">
                                                <a href="javascript:modifyBindRole('C','${role.uuid}')"
                                                   type="button" class="btn btn-sm btn-success a-noline" style="color: #fff">启 &nbsp; 用</a>
                                            </c:if>
                                            <c:if test="${!empty role.bindroleid}">
                                                <a href="javascript:modifyBindRole('D','${role.bindroleid}')"
                                                   type="button" class="btn btn-sm btn-danger a-noline" style="color: #fff">停 &nbsp; 用</a>
                                            </c:if>

                                            <shiro:hasRole name="SYSTEM_ADM">
                                                <c:if test="${'WP_SUPER' ne role.rolekey && 'SYSTEM_ADM' ne role.rolekey && not empty role.bindid}">
                                                    <a href="javascript:modifyRolePermit('${role.uuid}','${signType}','')"
                                                       type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff">修 &nbsp; 改</a>
                                                    <a href="javascript:deleteRole('${role.uuid}')" type="button"
                                                       class="btn btn-sm btn-yellow a-noline" style="color: #fff">删 &nbsp; 除</a>
                                                </c:if>
                                            </shiro:hasRole>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="navbar-left">
                            <button class="btn btn-sm btn-submit" onclick="showRoleInfo()"> 添加角色</button>
                        </div>
                    </c:if>
                    <c:if test="${'permit' eq signType}">
                        <div class="table-responsive">
                            <table class="table table-striped  b-light b-b b-l b-r">
                                <thead>
                                <tr>
                                    <th width="20%">名称</th>
                                    <th width="30%">地址</th>
                                    <th width="20%">状态</th>
                                    <th width="30%">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${permitList}" var="permit" varStatus="num">
                                    <tr>
                                        <td>
                                                ${permit.permitname}
                                        </td>
                                        <td>
                                                ${permit.permitresource}
                                        </td>
                                        <td>
                                                ${web:getCodeDesc("PERMIT_STATUS",permit.status)}
                                        </td>
                                        <td>
                                            <shiro:hasRole name="SYSTEM_ADM">
                                                <a href="javascript:modifyRolePermit('${permit.uuid}','${signType}','')"
                                                   type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff">修 &nbsp; 改</a>
                                                <a href="javascript:deleteRole('${permit.uuid}')" type="button"
                                                   class="btn btn-sm btn-yellow a-noline" style="color: #fff">删 &nbsp; 除</a>
                                            </shiro:hasRole>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <c:if test="${not empty permitList}">
                                <web:pagination pageList="${permitList}" postParam="true"/>
                            </c:if>
                        </div>
                    </c:if>
                    <c:if test="${'rolepermit' eq signType}">
                        <div class="table-responsive">
                            <table class="table table-striped  b-light b-b b-l b-r">
                                <thead>
                                <tr>
                                    <th width="30%">角色</th>
                                    <th width="40%">资源</th>
                                    <th width="30%">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${rolePermitList}" var="rolePermit">
                                    <tr>
                                        <td>
                                                ${rolePermit.rolename}
                                        </td>
                                        <td>
                                                ${rolePermit.permitnames}
                                        </td>
                                        <td>
                                            <shiro:hasRole name="WP_SUPER">
                                                    <a href="javascript:modifyRolePermit('${rolePermit.roleid}','${signType}','${rolePermit.rolename}')"
                                                       type="button" class="btn btn-sm btn-dangernew  a-noline" style="color: #fff">修 &nbsp; 改</a>
                                                    <a href="javascript:deleteRole('${rolePermit.roleid}')"
                                                       type="button" class="btn btn-sm btn-yellow a-noline" style="color: #fff">删 &nbsp; 除</a>
                                            </shiro:hasRole>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
                <form class="hidden" class="form-horizontal" data-validate="parsley"
                      action="${ctx}/admin/usermanage/roleInfo" method="POST"
                      id="frm">
                    <input type="hidden" name="uuid" id="uuid" class="form-control">
                    <input type="hidden" name="signType" id="signType" class="form-control">
                    <input type="hidden" name="name" id="name" class="form-control">
                </form>
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
    function toggleTab(tabId) {
        window.location.href = "<%=request.getContextPath()%>/admin/usermanage/rolePermitManage?signType=" + tabId;
    }
    //删除角色
    function deleteRole(uuid) {
        if (confirm("确认删除？")) {
            window.location.href = "<%=request.getContextPath()%>/admin/usermanage/deleteRole?uuid=" + uuid + "&signType=${signType}";
        }
    }
    //添加角色
    function showRoleInfo() {
        window.location.href = "<%=request.getContextPath()%>/admin/usermanage/roleInfo";
    }
    //添加权限配置
    function showRolePermitInfo() {
        window.location.href = "<%=request.getContextPath()%>/admin/usermanage/rolePermitInfo";
    }

    function resubmitSearch(page) {
        window.location.href = "<%=request.getContextPath()%>/admin/usermanage/rolePermitManage?page=" + page + "&signType=${signType}";
    }

    function modifyRolePermit(uuid, signType, name) {
        document.getElementById("uuid").value = uuid;
        document.getElementById("signType").value = signType;
        document.getElementById("name").value = name;
        var frm = document.getElementById("frm");
        if ("role" == signType) {
            frm.action = "${ctx}/admin/usermanage/roleInfo";
        }
        if ("permit" == signType) {
            frm.action = "${ctx}/admin/usermanage/permitInfo";
        }
        if ("rolepermit" == signType) {
            frm.action = "${ctx}/admin/usermanage/rolePermitInfo";
        }
        frm.submit();
    }

    function modifyBindRole(type, id) {
        var frm = document.getElementById("frm");
        if ("C" == type) {
            frm.action = "${ctx}/admin/usermanage/createBindRole/"+id;
        }
        if ("D" == type) {
            frm.action = "${ctx}/admin/usermanage/deleteBindRole/"+id;
        }
        frm.submit();
    }
</script>
</body>
</html>