<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
<style>
    .li{
        position: absolute;
        margin-top: 33px;
    }
</style>
</head>
<body class="">

<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                产品中心 /
                <a href="${ctx}/admin/wefamily/mtxVideoManage">视频管理 </a> /
                <span class="font-bold  text-shallowred"> 视频详情</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="${ctx}/admin/wefamily/updateMtxVideo" method="POST"
                      enctype="multipart/form-data" id="frm">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">视频详情：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>型号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select class="form-control" id="model" name="model" data-required="true">
                                        <option value="">--全部--</option>
                                        <c:forEach items="${modelList}" var="modelTemp">
                                            <c:if test="${mtxVideo.model == modelTemp}">
                                                <option value="${modelTemp}" selected>${modelTemp}</option>
                                            </c:if>
                                            <c:if test="${mtxVideo.model != modelTemp}">
                                                <option value="${modelTemp}">${modelTemp}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>分类：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select class="form-control" id="type" name="type" data-required="true">
                                        <option value="">--全部--</option>
                                        <c:set var="typeList" value="${web:queryCommonCodeList('VIDEO_TYPE')}"></c:set>
                                        <c:forEach items="${typeList}" var="typeCode">
                                            <c:if test="${mtxVideo.type == typeCode.code}">
                                                <option value="${typeCode.code}" selected>${typeCode.codevalue}</option>
                                            </c:if>
                                            <c:if test="${mtxVideo.type != typeCode.code}">
                                                <option value="${typeCode.code}">${typeCode.codevalue}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>状态：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select class="form-control" id="status" name="status" data-required="true">
                                        <option value="">--全部--</option>
                                        <c:set var="typeList" value="${web:queryCommonCodeList('PRODUCT_STATUS')}"></c:set>
                                        <c:forEach items="${typeList}" var="typeCode">
                                            <c:if test="${mtxVideo.status == typeCode.code}">
                                                <option value="${typeCode.code}" selected>${typeCode.codevalue}</option>
                                            </c:if>
                                            <c:if test="${mtxVideo.status != typeCode.code}">
                                                <option value="${typeCode.code}">${typeCode.codevalue}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>视频路径：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" name="videourl" id="videourl" class="form-control"
                                           value="${mtxVideo.videourl}" data-required="true"
                                    >
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${mtxVideo.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${mtxVideo.versionno}">
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
<script charset="utf-8" src="${ctx}/static/admin/editor/kindeditor.js"></script>
<script charset="utf-8" src="${ctx}/static/admin/editor/lang/zh_CN.js"></script>
<script charset="utf-8" src="${ctx}/static/admin/editor/plugins/lineheight/lineheight.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('产品中心');
    }
</script>

</body>
</html>