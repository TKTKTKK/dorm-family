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
                                <div style="clear: both"></div>
                                <div class="row col-sm-12 text-center text-white" style="margin-top: 20px">
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
                                        <th width="20%">所在地区</th>
                                        <th width="15%">详细地址</th>
                                        <th width="15%">详细信息</th>
                                        <th width="10%">机型</th>
                                        <th width="10%">状态</th>
                                        <c:if test="${status eq 'N_DEAL'}">
                                            <th width="10%">操作</th>
                                        </c:if>
                                        <c:if test="${status eq 'C_DEAL'}">
                                            <th width="10%">备注</th>
                                        </c:if>
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
                                            <td>
                                                    ${mtxReserve.model}
                                            </td>
                                            <td>
                                                    ${web:getCodeDesc("DEAL_STATUS", mtxReserve.status)}
                                            </td>
                                            <c:if test="${status eq 'N_DEAL'}">
                                            <td>
                                                <a  class="btn btn-sm btn-success a-noline" data-toggle="modal"
                                                    data-target=".bs-example-modal-lg-plan-deal"
                                                    onclick="getUuid('${mtxReserve.uuid}')"
                                                >处理
                                                </a>
                                            </td>
                                            </c:if>
                                            <c:if test="${status eq 'C_DEAL'}">
                                                <td>
                                                        ${mtxReserve.remarks}
                                                </td>
                                            </c:if>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <div id="uuidValue"></div>
                                <div class="modal fade bs-example-modal-lg-plan-deal" tabindex="-1" role="dialog"
                                     aria-labelledby="myPlanStartLargeModalLabel" aria-hidden="false">
                                    <div class="modal-dialog modal-lg" style="margin-top: 15%">
                                        <div class="modal-content">
                                            <form id="planStartFrm" method="post" action=""
                                                  class="form-horizontal" data-validate="parsley"
                                            >
                                                <div class="modal-header mintgreen">
                                                    <button type="button" class="close" data-dismiss="modal" id="planStartModelCloseBtn"><span
                                                            aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                                    <h4 class="modal-title" id="myPlanStartLargeModalLabel">备注说明</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <div class="form-group row" style="border: 2px;background-color: #fff">
                                                                <label class="col-sm-3 col-xs-4 control-label"
                                                                       style="padding-top: 5px;padding-right: 0px"><span class="text-danger">*</span>备注说明：</label>
                                                                <div class="col-sm-9 col-xs-8  bg-white">
                                                                    <textarea  class="form-control" data-required="true" data-maxlength="256" style="width: 350px;height: 150px;" id="remarks" name="remarks"></textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer" style="text-align: center;">
                                                    <a  class="btn btn-submit btn-s-xs"
                                                        onclick="updateReserve(document.getElementById('uuidValue').value)"
                                                    >
                                                        <i class="fa fa-check"></i>&nbsp;保&nbsp;存
                                                    </a>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
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
    function updateReserve(uuid){
        $("#planStartFrm").parsley("validate");
        if($('#planStartFrm').parsley().isValid()){
            var searchForm = document.getElementById("planStartFrm");
            searchForm.action = "${ctx}/admin/wefamily/updateReserve?uuid="+uuid;
            searchForm.submit();
        }
    }
    function getUuid(uuid){
        $("#uuidValue").val(uuid);
    }
</script>
</body>
</html>