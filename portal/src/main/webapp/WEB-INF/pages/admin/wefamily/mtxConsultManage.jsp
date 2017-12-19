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
            咨询留言 / <span class="font-bold  text-shallowred"> 留言管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
                <div class="bg-white closel newclosel">
                    <c:if test="${not empty wechatBinding}">
                        <form method="post" action="" class="form-horizontal bg-white padding20 b-t b-b b-l b-r" data-validate="parsley" id="searchForm">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4 my-display-inline-lbl" style="padding-top: 7px"><span class="text-danger"></span> 身份类型：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <select class="form-control" id="identify" name="identify">
                                            <option value="">--全部--</option>
                                            <c:set var="typeList" value="${web:queryCommonCodeList('IDENTITY_CODE')}"></c:set>
                                            <c:forEach items="${typeList}" var="typeCode">
                                                <c:if test="${mtxConsult.identify == typeCode.code}">
                                                    <option value="${typeCode.code}" selected>${typeCode.codevalue}</option>
                                                </c:if>
                                                <c:if test="${mtxConsult.identify != typeCode.code}">
                                                    <option value="${typeCode.code}">${typeCode.codevalue}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4  my-display-inline-lbl" style="padding-top: 7px">状态：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <select class="form-control" id="status" name="status">
                                            <option value="">--全部--</option>
                                            <c:set var="typeList" value="${web:queryCommonCodeList('ANWSER_OR_NOT')}"></c:set>
                                            <c:forEach items="${typeList}" var="typeCode">
                                                <c:if test="${mtxConsult.status == typeCode.code}">
                                                    <option value="${typeCode.code}" selected>${typeCode.codevalue}</option>
                                                </c:if>
                                                <c:if test="${mtxConsult.status != typeCode.code}">
                                                    <option value="${typeCode.code}">${typeCode.codevalue}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <%--<div style="clear: both"></div>--%>
                                <div class="col-sm-4 text-center text-white">
                                    <a type="submit"  class="btn btn-submit btn-s-xs"
                                       onclick="searchMtxConsult()"
                                       id="searchBtn" style="color: #fff">查 询</a>
                                </div>
                            </div>
                        </form>
                        <div style="margin-top: 30px">
                            <span class="text-success">${successMessage}</span>
                        </div>
                        <div class="table-responsive" >
                            <table class="table table-striped b-t b-light  b-l b-r b-b">
                                <thead>
                                <tr>
                                    <th width="25%">身份类型</th>
                                    <th width="25%">状态</th>
                                    <th width="25%">提交时间</th>
                                    <th width="25%">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${mtxConsultList}" var="mtxConsult">
                                    <tr>
                                        <td>
                                                ${web:getCodeDesc("IDENTITY_CODE", mtxConsult.identify)}
                                        </td>
                                        <td>
                                                ${web:getCodeDesc("ANWSER_OR_NOT",mtxConsult.status)}
                                        </td>
                                        <td>
                                                ${fn:substring(mtxConsult.createon, 0, 19)}
                                        </td>
                                        <td>
                                            <c:if test="${mtxConsult.status eq 'NO_ANWSER'}">
                                            <a href="${ctx}/admin/wefamily/goMtxConsultDetail?uuid=${mtxConsult.uuid}"
                                               class="btn  btn-infonew btn-sm" style="color: white">
                                                查看新消息
                                            </a>
                                            </c:if>
                                            <c:if test="${mtxConsult.status eq 'ANWSER_RECENT'}">
                                                <a href="${ctx}/admin/wefamily/goMtxConsultDetail?uuid=${mtxConsult.uuid}" class="btn  btn-dangernew btn-sm" style="color: white">留言历史</a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <web:pagination pageList="${mtxConsultList}" postParam="true"/>
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
        showParentMenu('咨询留言');
    }
    function searchMtxConsult(){
        var searchForm = document.getElementById("searchForm");
        searchForm.action = "${ctx}/admin/wefamily/mtxConsultManage";
        searchForm.submit();
    }
    function resubmitSearch(page){
        var searchForm = document.getElementById("searchForm");
        searchForm.action = "${ctx}/admin/wefamily/mtxConsultManage?page="+page;
        searchForm.submit();
    }
</script>
</body>
</html>