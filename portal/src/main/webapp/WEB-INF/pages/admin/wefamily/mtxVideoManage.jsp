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
            满田星 / <span class="font-bold  text-shallowred"> 视频管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
                <div class="bg-white closel newclosel">
                    <c:if test="${not empty wechatBinding}">
                        <form method="post" action="" class="form-horizontal bg-white padding20 b-t b-b b-l b-r" data-validate="parsley" id="searchForm">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4 my-display-inline-lbl" style="padding-top: 7px"><span class="text-danger"></span> 型号：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <select class="form-control" id="model" name="model">
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
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4 my-display-inline-lbl" style="padding-top: 7px"><span class="text-danger"></span> 状态：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <select class="form-control" id="status" name="status">
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
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4  my-display-inline-lbl" style="padding-top: 7px">分类：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <select class="form-control" id="type" name="type">
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
                                <div style="clear: both"></div>
                                <div class="row col-sm-12 text-center text-white" style="margin-top: 20px">
                                    <a type="submit"  class="btn btn-submit btn-s-xs"
                                       onclick="searchMtxVideo()"
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
                                        <th width="20%">型号</th>
                                        <th width="20%">状态</th>
                                        <th width="20%">分类</th>
                                        <th width="20%">视频连接</th>
                                        <th width="20%">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${mtxVideoList}" var="mtxVideo">
                                        <tr>
                                            <td>
                                                    ${mtxVideo.model}
                                            </td>
                                            <td>
                                                    ${web:getCodeDesc("PRODUCT_STATUS", mtxVideo.status)}
                                            </td>
                                            <td>
                                                    ${web:getCodeDesc("VIDEO_TYPE", mtxVideo.type)}
                                            </td>
                                            <td>
                                                    ${mtxVideo.videourl}
                                            </td>
                                            <td>
                                                <a href="${ctx}/admin/wefamily/goMtxVideo?uuid=${mtxVideo.uuid}"
                                                   class="btn  btn-infonew btn-sm" style="color: white">
                                                    修改
                                                </a>
                                                <a href="javascript:deleteMtxVideo('${mtxVideo.uuid}')" class="btn  btn-dangernew btn-sm" style="color: white">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <web:pagination pageList="${mtxVideoList}" postParam="true"/>
                                <button class="btn btn-sm btn-submit" onclick="showMtxVideoInfo()"> 添加</button>
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
        searchForm.action = "${ctx}/admin/wefamily/mtxVideoManage?page="+page;
        searchForm.submit();
    }
    function searchMtxVideo(){
        var searchForm = document.getElementById("searchForm");
        searchForm.action = "${ctx}/admin/wefamily/mtxVideoManage";
        searchForm.submit();
    }
    function showMtxVideoInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/goMtxVideo";
    }
    function deleteMtxVideo(uuid){
        qikoo.dialog.confirm('确定要删除吗？',function(){
            //确定删除
            $.post("${ctx}/admin/wefamily/deleteMtxVideo?uuid="+uuid,function(data){
                //删除成功
                if(data.deleteFlag){
                    var searchForm = document.getElementById("searchForm");
                    searchForm.action = "${ctx}/admin/wefamily/mtxVideoManage?deleteFlag=1";
                    searchForm.submit();
                }
            });
        },function(){
            //取消删除
        });
    }
</script>
</body>
</html>