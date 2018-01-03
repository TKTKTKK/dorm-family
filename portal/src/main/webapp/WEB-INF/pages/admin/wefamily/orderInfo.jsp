<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>

</head>
<body class="">

<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                满田星 / <a href="${ctx}/admin/wefamily/orderManage">订单管理</a>
                / <span class="font-bold  text-shallowred"> 订单信息</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="${ctx}/admin/wefamily/orderInfo" method="POST"
                      enctype="multipart/form-data" id="frm">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">订单信息：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>经销商：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true"
                                           value="${merchant.name}" readonly>
                                    <input type="hidden" name="merchantid" value="${merchant.uuid}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>机器型号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select class="form-control" name="machinemodel" id="machinemodel"
                                            data-required="true">
                                        <c:if test="${fn:length(machineModelList) > 1}">
                                            <option value="">请选择</option>
                                        </c:if>
                                        <c:forEach items="${machineModelList}" var="machineModel">
                                            <option value="${machineModel}" <c:if test="${order.machinemodel == machineModel}">selected</c:if>>${machineModel}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>订购数量：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input class="form-control" size="1" data-required="true"
                                           data-type="digits" name="quantity" value="${order.quantity}"
                                           data-maxlength="11"
                                           data-min="1"
                                    >
                                    <span id="quantitylError" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>委托运输：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <select  class="form-control" name="entrusttransport" id="entrusttransport"
                                             data-required="true">
                                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('ENTRUST_TRANSPORT')}"></c:set>
                                        <option value="">--请选择--</option>
                                        <c:forEach items="${commonCodeList}" var="commonCode">
                                            <option value="${commonCode.code}" <c:if test="${order.entrusttransport == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>株距要求：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <select  class="form-control" name="rowspace" id="rowspace"
                                             data-required="true">
                                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('ROW_SPACE')}"></c:set>
                                        <option value="">--请选择--</option>
                                        <c:forEach items="${commonCodeList}" var="commonCode">
                                            <option value="${commonCode.code}" <c:if test="${order.rowspace == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>横向送秧次数：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <select  class="form-control" name="transversetime" id="transversetime"
                                             data-required="true">
                                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('TRANSVERSE_TIME')}"></c:set>
                                        <option value="">--请选择--</option>
                                        <c:forEach items="${commonCodeList}" var="commonCode">
                                            <option value="${commonCode.code}" <c:if test="${order.transversetime == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>宽秧针：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <select  class="form-control" name="seedlingneedle" id="seedlingneedle"
                                             data-required="true">
                                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('SEEDLING_NEEDLE')}"></c:set>
                                        <option value="">--请选择--</option>
                                        <c:forEach items="${commonCodeList}" var="commonCode">
                                            <option value="${commonCode.code}" <c:if test="${order.seedlingneedle == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group" >
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>载秧篮：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <select  class="form-control" name="seedlingbasket" id="seedlingbasket"
                                             data-required="true">
                                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('SEEDLING_BASKET')}"></c:set>
                                        <option value="">--请选择--</option>
                                        <c:forEach items="${commonCodeList}" var="commonCode">
                                            <option value="${commonCode.code}" <c:if test="${order.seedlingbasket == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>是否电启动：</label>
                                <div class="col-sm-9  b-l bg-white" >
                                    <div class="radio col-sm-2">
                                        <label>
                                            <input type="radio" name="electricstart" id="electricstart1" value="Y"
                                                   <c:if test="${'Y' eq order.electricstart}">checked</c:if>
                                            >是
                                        </label>
                                    </div>
                                    <div class="radio col-sm-2">
                                        <label>
                                            <input type="radio" name="electricstart" id="electricstart2" value="N"
                                                   <c:if test="${empty order.electricstart || 'N' eq order.electricstart}">checked</c:if>
                                            >否
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>工作服：</label>
                                <div class="col-sm-9  b-l bg-white" >
                                    <div class="radio col-sm-2">
                                        <label>
                                            <input type="radio" name="coverall" id="coverall1" value="Y"
                                                   <c:if test="${'Y' eq order.coverall}">checked</c:if>
                                            >是
                                        </label>
                                    </div>
                                    <div class="radio col-sm-2">
                                        <label>
                                            <input type="radio" name="coverall" id="coverall2" value="N"
                                                   <c:if test="${empty order.coverall || 'N' eq order.coverall}">checked</c:if>
                                            >否
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>塑料罩：</label>
                                <div class="col-sm-9  b-l bg-white" >
                                    <div class="radio col-sm-2">
                                        <label>
                                            <input type="radio" name="plasticcover" id="plasticcover1" value="Y"
                                                   <c:if test="${'Y' eq order.plasticcover}">checked</c:if>
                                            >是
                                        </label>
                                    </div>
                                    <div class="radio col-sm-2">
                                        <label>
                                            <input type="radio" name="plasticcover" id="plasticcover2" value="N"
                                                   <c:if test="${empty order.plasticcover || 'N' eq order.plasticcover}">checked</c:if>
                                            >否
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>20升油箱：</label>
                                <div class="col-sm-9  b-l bg-white" >
                                    <div class="radio col-sm-2">
                                        <label>
                                            <input type="radio" name="fueltank" id="fueltank1" value="Y"
                                                   <c:if test="${'Y' eq order.fueltank}">checked</c:if>
                                            >是
                                        </label>
                                    </div>
                                    <div class="radio col-sm-2">
                                        <label>
                                            <input type="radio" name="fueltank" id="fueltank2" value="N"
                                                   <c:if test="${empty order.fueltank || 'N' eq order.fueltank}">checked</c:if>
                                            >否
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label">备注：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <textarea class="form-control" rows="4" name="merchantremarks"
                                              id="merchantremarks" data-maxlength="256" onblur="trimText(this)"
                                    >${order.merchantremarks}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${order.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${order.versionno}">
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer text-left bg-light lter">
                                <button type="submit" class="btn btn-submit btn-s-xs ">
                                    <i class="fa fa-check"></i>&nbsp;提&nbsp;交
                                </button>
                        </div>
                    </section>
                </form>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('销售服务');
    }



</script>

</body>
</html>