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
        <section class="scrollable padder">
            <header class="panel-heading">
                公众号 》 <span class="font-bold  text-black"> 门店管理</span>
            </header>
            <div class="row">
                <div class="col-sm-12">
                    <c:if test="${not empty wechatBinding}">
                        <div style="margin-bottom: 5px">
                            <span class="text-success">${successMessage}</span>
                            <span class="text-danger">${errorMessage}</span>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-striped b-t b-light b-b">
                                <thead>
                                <tr>
                                    <th width="15%">门店名称</th>
                                    <th width="15%">分店名</th>
                                    <th width="10%">联系电话</th>
                                    <th width="45%">地址</th>
                                    <th width="15%">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${wechatStoreList}" var="wechatStore">
                                    <tr>
                                        <td>
                                            <a href="${ctx}/admin/account/storeInfo?storeId=${wechatStore.uuid}&view=1">${wechatStore.business_name}</a>
                                        </td>
                                        <td>
                                            ${wechatStore.branch_name}
                                        </td>
                                        <td>
                                            ${wechatStore.telephone}
                                        </td>
                                        <td>
                                            ${wechatStore.address}
                                        </td>
                                        <td>
                                            <a href="${ctx}/admin/account/storeInfo?storeId=${wechatStore.uuid}" class="btn btn-default btn-s-md">修改</a>
                                            <a href="javascript:deleteStore('${wechatStore.uuid}')" class="btn btn-default btn-s-md">删除</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="navbar-right">
                            <button class="btn btn-sm btn-success" onclick="showStoreInfo()"> 添加门店</button>
                        </div>
                    </c:if>
                    <c:if test="${empty wechatBinding}">
                        <span>您还没有添加公众号，请先去</span>
                        <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
                    </c:if>
                </div>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<script type="text/javascript">

    //添加关注时自动回复图文
    function addSubscribeArticle(){
        //验证标题最大长度
        var titleValid = validateChineseText(60,
                document.getElementById("title").value, "titleError");
        //验证简介最大长度
        var descriptionValid = validateChineseText(60,
                document.getElementById("title").value, "titleError");
        if(!titleValid && !descriptionValid){
            return false;
        }
        return true;
    }

    //添加门店界面
    function showStoreInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/account/storeInfo";
    }

    //删除门店
    function deleteStore(storeId){
        if(confirm("确认删除？")){
            window.location.href = "<%=request.getContextPath()%>/admin/account/deleteStore?storeId="+storeId;
        }
    }
</script>
</body>
</html>