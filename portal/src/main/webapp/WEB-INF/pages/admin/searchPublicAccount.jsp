<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
                公众号 / <span class="font-bold  text-shallowred">公众号管理</span>
            </header>
            <div class="bg-white closel">
            <div class="col-sm-12 m-b-xs ">
                <c:if test="${empty wechatBinding}">
                    <button class="btn btn-sm btn-success" onclick="toAddPublicAccount()"> 添加公众号</button>
                </c:if>
                <c:if test="${not empty wechatBinding}">
                    <span class="text-success">您已经成功绑定了公众号.</span>
                </c:if>
                <%--<span class="text-success">${successMessage}</span>--%>
            </div>
            <div class="table-responsive">
                <table class="table table-striped b-t b-light b-l b-r b-b">
                    <thead>
                    <tr>
                        <th>公众号名称</th>
                        <th>系统ID</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${not empty wechatBinding}">
                        <tr>
                            <td>${wechatBinding.wechatname}</td>
                            <td>${wechatBinding.uuid}</td>
                            <td>
                                <a href="${ctx}/admin/account/addPublicAccount?pubAccid=${wechatBinding.uuid}" class="btn btn-submit btn-s-md a-noline" style="color: #fff">修改</a>
                                <c:if test="${!(wechatBinding.authorized eq 'Y')}">
                                    <a type="button" class="btn btn-s-xs a-noline" href="${componentAuthLoginUrl}"
                                            style="padding: 0px">
                                        <img src="${ctx}/static/admin/img/wechatLogo.png">
                                    </a>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <p class="warningword"><span><i class="fa fa-warning">：</i></span>复制此处URL和token到腾讯平台绑定</p>
                                <p class="text-info"><span class="font-bold text-black">URL:</span> ${domainUrl}/wechatServlet?bindid=${wechatBinding.uuid}</p>
                                <p class="text-info"><span class="font-bold text-black">token:</span> ${wechatBinding.token}</p>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
                </div>
        </section>
    </section>
</section>

<script type="text/javascript">
    //公众号详情界面
    function toAddPublicAccount(){
        window.location.href = "<%=request.getContextPath()%>/admin/account/addPublicAccount";
    }
</script>

</body>
</html>
