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
            宿舍管理 / <span class="font-bold  text-shallowred"> 宿舍楼管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">

                <div class="bg-white closel">
                    <div class="col-sm-12 no-padder">
                        <form method="post" action="${ctx}/admin/wefamily/dormitoryManage" class="form-horizontal b-l b-r b-b b-t padding20"
                              data-validate="parsley"
                              id="searchForm">
                            <div class="row">
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="name" name="name" onblur="trimText(this)" value="${dormitory.name}"
                                           placeholder="宿舍楼名称"
                                    />
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="frequentcontacts" name="frequentcontacts" onblur="trimText(this)" value="${dormitory.frequentcontacts}"
                                           placeholder="常用联系人"
                                    />
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="address" name="address" onblur="trimText(this)" value="${dormitory.address}"
                                           placeholder="地址"
                                    />
                                </div>


                            </div>
                            <div class="row col-sm-12 text-center text-white" style="margin-top: 20px">
                                <a class="btn btn-submit btn-s-xs " onclick="submitSearch()"
                                   id="searchBtn" style="color: white">查 询
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="bg-white closel newclosel">
                    <c:if test="${not empty wechatBinding}">
                            <div>
                                <span class="text-success">${successMessage}</span>
                                <span class="text-success" id="synSuccessMsg"></span>
                                <span class="text-danger" id="synFailureMsg"></span>
                                <c:if test="${successFlag == 1}">
                                    <span class="text-success">删除成功！</span>
                                </c:if>
                            </div>
                            <div class="table-responsive" >
                                <table class="table table-striped b-t b-light  b-l b-r b-b text-center">

                                    <thead>
                                    <tr>
                                        <th class="text-center">宿舍楼名称</th>
                                        <th class="text-center">宿舍类型</th>
                                        <th class="text-center">地址</th>
                                        <th class="text-center">宿管电话</th>
                                        <th class="text-center">常用联系人</th>
                                        <th class="text-center">联系人电话</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${dormitoryPageList}" var="dormitory">
                                        <tr>
                                            <td>
                                                    ${dormitory.name}
                                            </td>
                                            <td>
                                                    ${web:getCodeDesc("DORMITORY_TYPE",dormitory.type)}
                                            </td>
                                            <td>
                                                    ${dormitory.address}
                                            </td>
                                            <td>
                                                    ${dormitory.contactno}
                                            </td>
                                            <td>
                                                    ${dormitory.frequentcontacts}
                                            </td>
                                            <td>
                                                    ${dormitory.contactsphone}
                                            </td>
                                            <td>
                                                <a href="${ctx}/admin/wefamily/dormitoryInfo?dormitoryId=${dormitory.uuid}"
                                                   class="btn  btn-infonew btn-sm" style="color: white">
                                                    修改
                                                </a>
                                                <a href="${ctx}/admin/wefamily/addressManage?dormitoryId=${dormitory.uuid}"
                                                   class="btn  btn-yellow btn-sm" style="color: white">
                                                    房间信息
                                                </a>
                                                <a href="javascript:deleteDormitory('${dormitory.uuid}')" class="btn  btn-dangernew btn-sm" style="color: white">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <web:pagination pageList="${dormitoryPageList}" postParam="true"/>
                                <c:if test="${topAccount == 'Y'}">
                                    <button class="btn btn-sm btn-submit" onclick="showDormitoryInfo()"> 添加</button>
                                </c:if>
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
        showParentMenu('宿舍管理');
    }

    //提交查询
    function submitSearch() {
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if ($('#searchForm').parsley().isValid()) {
            $('#searchBtn').attr('disabled', true);
            //ui block
            pleaseWait();
            document.getElementById('searchForm').submit();
        }
    }

    function resubmitSearch(page){
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if ($('#searchForm').parsley().isValid()) {
            $('#searchBtn').attr('disabled', true);
            //ui block
            pleaseWait();
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/admin/wefamily/dormitoryManage?page=" + page;
            searchForm.submit();
        }
    }


    function deleteDormitory(dormitoryId){
        qikoo.dialog.confirm('确认删除？',function(){
            //确定
            $.get("${ctx}/admin/wefamily/deleteDormitory?dormitoryId="+dormitoryId+"&version="+Math.random(),function(data,status){
                if(undefined != data.deleteFlag){
                    var searchForm = document.getElementById("searchForm");
                    searchForm.action = "${ctx}/admin/wefamily/dormitoryManage?deleteFlag=" + data.deleteFlag;
                    searchForm.submit();
                }
            });
        },function(){
            //取消
        });
    }


    function showDormitoryInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/dormitoryInfo";
    }

</script>
</body>
</html>