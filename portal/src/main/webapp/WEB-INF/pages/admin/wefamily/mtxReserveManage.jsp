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
            咨询留言 / <span class="font-bold  text-shallowred"> 咨询管理</span>
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
                                        <input type="text" class="form-control" name="name" id="name" data-maxlength="90"
                                               onblur="trimText(this)" value="${mtxReserve.name}">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4  my-display-inline-lbl" style="padding-top: 7px">手机号：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <input type="text" class="form-control" name="phone" id="phone" data-maxlength="90"
                                               onblur="trimText(this)" value="${mtxReserve.phone}">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4 my-display-inline-lbl" style="padding-top: 7px"><span class="text-danger"></span> 状态：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <select class="form-control" id="status" name="status">
                                            <c:set var="typeList" value="${web:queryCommonCodeList('DEAL_STATUS')}"></c:set>
                                            <c:forEach items="${typeList}" var="typeCode">
                                                <c:if test="${mtxReserve.status == typeCode.code}">
                                                    <option value="${typeCode.code}" selected>${typeCode.codevalue}</option>
                                                </c:if>
                                                <c:if test="${mtxReserve.status != typeCode.code}">
                                                    <option value="${typeCode.code}">${typeCode.codevalue}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-4" style="margin-top: 20px">
                                    <label class="control-label col-sm-4 my-display-inline-lbl" style="padding-top: 7px"><span class="text-danger"></span> 经销商：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <select class="form-control" id="merchantid" name="merchantid">
                                            <c:if test="${fn:length(merchantList)>1}">
                                                <option value="">全部</option>
                                            </c:if>
                                            <c:forEach items="${merchantList}" var="merchant">
                                                <option value="${merchant.uuid}" <c:if test="${merchant.uuid==mtxReserve.merchantid}"> selected</c:if>>${merchant.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class=" col-sm-4 text-center text-white" style="margin-top: 20px" >
                                    <a type="submit"  class="btn btn-submit btn-s-xs"
                                       onclick="searchMtxReserve()"
                                       id="searchBtn" style="color: #fff">查 询</a>
                                </div>
                            </div>
                        </form>
                        <div style="margin-top: 30px">
                            <span class="text-success">${successMessage}</span>
                            <span class="text-danger">${errorMessage}</span>
                        </div>
                            <div class="table-responsive" >
                                <table class="table table-striped b-t b-light  b-l b-r b-b">
                                    <thead>
                                    <tr>
                                        <th width="10%">姓名</th>
                                        <th width="10%">电话</th>
                                        <c:if test="${mtxReserve.status eq 'CHANGE'||mtxReserve.status eq 'C_DEAL'}">
                                            <th width="10%">所在地区</th>
                                            <th width="10%">详细地址</th>
                                            <th width="10%">详细信息</th>
                                            <th width="10%">经销商</th>
                                        </c:if>
                                        <c:if test="${mtxReserve.status eq 'N_DEAL'}">
                                        <th width="20%">所在地区</th>
                                        <th width="15%">详细地址</th>
                                        <th width="15%">详细信息</th>
                                        </c:if>
                                        <th width="10%">机型</th>
                                        <th width="10%">状态</th>
                                        <th width="10%">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${mtxReserveList}" var="mtxReserve">
                                        <tr>
                                            <td>
                                                    ${mtxReserve.name}
                                            </td>
                                            <td>
                                                    ${mtxReserve.phone}
                                            </td>
                                            <td>
                                                    ${mtxReserve.province}${mtxReserve.city}${mtxReserve.district}
                                            </td>
                                            <td>
                                                    ${mtxReserve.address}
                                            </td>

                                            <td>
                                                    ${mtxReserve.detail}
                                            </td>
                                            <c:if test="${mtxReserve.status eq 'CHANGE'||mtxReserve.status eq 'C_DEAL'}">
                                                <td>
                                                        ${mtxReserve.merchantname}
                                                </td>
                                            </c:if>
                                            <td>
                                                    ${mtxReserve.model}
                                            </td>
                                            <td>
                                                    ${web:getCodeDesc("DEAL_STATUS", mtxReserve.status)}
                                            </td>

                                            <td>
                                                <a href="${ctx}/admin/wefamily/goMtxReserve?uuid=${mtxReserve.uuid}"
                                                   class="btn  btn-infonew btn-sm" style="color: white">
                                                    <c:if test="${mtxReserve.status eq 'N_DEAL'}">
                                                        处理
                                                    </c:if>
                                                    <c:if test="${mtxReserve.status eq 'C_DEAL'||mtxReserve.status eq 'CHANGE'}">
                                                        详情
                                                    </c:if>
                                                </a>
                                            </td>

                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <web:pagination pageList="${mtxReserveList}" postParam="true"/>
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

    function searchMtxReserve(){
        var searchForm = document.getElementById("searchForm");
        searchForm.action = "${ctx}/admin/wefamily/mtxReserveManage";
        searchForm.submit();
    }

     function resubmitSearch(page){
        var searchForm = document.getElementById("searchForm");
        searchForm.action = "${ctx}/admin/wefamily/mtxReserveManage?page="+page;
        searchForm.submit();
    }
</script>
</body>
</html>