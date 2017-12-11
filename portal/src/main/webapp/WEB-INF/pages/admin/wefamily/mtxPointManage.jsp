<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
</head>
<style>
</style>
<body class="">

<section id="content">
    <section class="vbox">
        <header class="panel-heading bg-white text-lg">
            满田星 / <span class="font-bold  text-shallowred"> 积分管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
                <div class="bg-white closel newclosel">
                    <c:if test="${not empty wechatBinding}">
                        <form method="post" action="" class="form-horizontal bg-white padding20 b-t b-b b-l b-r" data-validate="parsley" id="searchForm">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4 my-display-inline-lbl" style="padding-top: 7px"><span class="text-danger"></span> 姓名：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <input type="text" class="form-control" name="membername" id="membername"
                                               onblur="trimText(this)" value="${mtxPoint.membername}">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4 my-display-inline-lbl" style="padding-top: 7px"><span class="text-danger"></span> 电话：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <input type="text" class="form-control" name="phone" id="phone"
                                               onblur="trimText(this)" value="${mtxPoint.phone}">
                                    </div>
                                </div>
                                <div class="col-sm-4 text-center text-white">
                                    <a type="submit"  class="btn btn-submit btn-s-xs"
                                       onclick="searchMtxPoint()"
                                       id="searchBtn" style="color: #fff">查 询</a>
                                </div>
                            </div>
                        </form>
                            <div style="margin-top: 30px">
                                <span class="text-success">${successMessage}</span>
                                <span class="text-success">${successFlag}</span>
                            </div>
                            <div class="table-responsive" >
                                <table class="table table-striped b-t b-light  b-l b-r b-b">
                                    <thead>
                                    <tr>
                                        <th width="25%">姓名</th>
                                        <th width="25%">手机号</th>
                                        <th width="25%">商品名</th>
                                        <th width="25%">积分</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${mtxPointList}" var="mtxPoint">
                                        <tr>
                                            <td>
                                                    ${mtxPoint.membername}
                                            </td>
                                            <td>
                                                    ${mtxPoint.phone}
                                            </td>
                                            <td>
                                                    ${mtxPoint.productname}
                                            </td>
                                            <td>
                                                    ${mtxPoint.points}
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <web:pagination pageList="${mtxPointList}" postParam="true"/>
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
<script src="${ctx}/static/admin/js/jquery.blockui.min.js"></script>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">

    window.onload = function(){
        //显示父菜单
        showParentMenu('满田星');
    }

    function resubmitSearch(page){
        var searchForm = document.getElementById("searchForm");
        searchForm.action = "${ctx}/admin/wefamily/mtxPointManage?page="+page;
        searchForm.submit();
    }
    function searchMtxPoint(){
        var searchForm = document.getElementById("searchForm");
        searchForm.action = "${ctx}/admin/wefamily/mtxPointManage";
        searchForm.submit();
    }
</script>
</body>
</html>