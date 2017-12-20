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
        <c:if test="${type eq 'REPAIR'}">
            <c:set var="showType" value="报修" scope="page"></c:set>
        </c:if>
        <c:if test="${type eq 'MAINTAIN'}">
            <c:set var="showType" value="保养" scope="page"></c:set>
        </c:if>
        <header class="panel-heading bg-white text-lg">
            满田星 / <span class="font-bold  text-shallowred">
            ${showType}管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
                <div class="bg-white closel">
                    <div class="col-sm-12 no-padder">
                        <form method="post" action="${ctx}/admin/wefamily/qualityMgmtManage" class="form-horizontal b-l b-r b-b padding20"
                              data-validate="parsley"
                              id="searchForm">
                            <div class="row">
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="snno" name="snno" onblur="trimText(this)" value="${qualityMgmt.snno}"
                                           <c:if test="${type eq 'REPAIR'}">placeholder="报修编号"</c:if>
                                           <c:if test="${type eq 'MAINTAIN'}">placeholder="保养编号"</c:if>
                                    />
                                    <input type="hidden" name="type" value="${type}">
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control" name="machinemodel" id="machinemodel">
                                        <c:if test="${fn:length(machineModelList) > 1}">
                                            <option value="">机器型号</option>
                                        </c:if>
                                        <c:forEach items="${machineModelList}" var="machineModel">
                                            <option value="${machineModel}" <c:if test="${qualityMgmt.machinemodel == machineModel}">selected</c:if>>${machineModel}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="reportername" name="reportername" onblur="trimText(this)"
                                           value="${qualityMgmt.reportername}" placeholder="用户姓名"/>
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="reporterphone" name="reporterphone" onblur="trimText(this)"
                                           value="${qualityMgmt.reporterphone}" placeholder="用户电话"/>
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                           name="startDateStr" value="${startDateStr}"
                                           data-date-format="yyyy-mm-dd" id="starttime" placeholder="起始日期">

                                    <div class="text-danger" id="dateError">
                                    </div>
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                           name="endDateStr" value="${endDateStr}"
                                           data-date-format="yyyy-mm-dd" id="endtime" placeholder="截止日期">
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
                            </div>
                            <div class="table-responsive" >
                                <table class="table table-striped b-light b-a text-center">
                                    <thead>
                                    <tr>
                                        <th class="text-center">${showType}编号</th>
                                        <th class="text-center">机器型号</th>
                                        <th class="text-center">用户姓名</th>
                                        <th class="text-center">用户电话</th>
                                        <th class="text-center">${showType}日期</th>
                                        <th class="text-center">${showType}状态</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${qualityMgmtList}" var="qualityMgmt">
                                        <tr>
                                            <td>
                                                    ${qualityMgmt.snno}
                                            </td>
                                            <td>
                                                    ${qualityMgmt.machinemodel}
                                            </td>
                                            <td>
                                                    ${qualityMgmt.reportername}
                                            </td>
                                            <td>
                                                    ${qualityMgmt.reporterphone}
                                            </td>
                                            <td>
                                                    ${fn:substring(qualityMgmt.createon, 0, 10)}
                                            </td>
                                            <td>
                                                    ${web:getCodeDesc("REPAIR_STATUS",qualityMgmt.status)}
                                            </td>
                                            <td>
                                                <a href="${ctx}/admin/wefamily/qualityMgmtInfo?qualityMgmtId=${qualityMgmt.uuid}&type=${type}" class="btn  btn-infonew btn-sm" style="color: white" >处理</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${not empty qualityMgmtList}">
                                    <web:pagination pageList="${qualityMgmtList}" postParam="true"/>
                                </c:if>
                            </div>
                        <div class="navbar-left">
                            <a class="btn btn-sm btn-info" href="javascript:showQualityMgmtInfo()"
                               style="color:white">添加${showType}</a>
                        </div>
                        <div style="clear: both"></div>
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
        showParentMenu('品质服务');
    }

    //提交查询
    function submitSearch() {
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if (compareBeginEndDate('starttime', 'endtime', 'dateError')
                && $('#searchForm').parsley().isValid()) {
            $('#searchBtn').attr('disabled', true);
            //ui block
            pleaseWait();
            document.getElementById('searchForm').submit();
        }
    }

    //比较起始日期和截止日期
    function compareBeginEndDate(startDateStr, endDateStr, dateError) {
        var startDateStr = document.getElementById(startDateStr);
        var endDateStr = document.getElementById(endDateStr);
        var dateError = document.getElementById(dateError);
        dateError.innerHTML = '';

        //比较起始和截止日期的大小
        var arr = startDateStr.value.split("-");
        var bgDate = new Date(arr[0], arr[1], arr[2]);
        var starttimes = bgDate.getTime();

        var arrs = endDateStr.value.split("-");
        var edDate = new Date(arrs[0], arrs[1], arrs[2]);
        var edtimes = edDate.getTime();

        if (starttimes > edtimes) {
            dateError.innerHTML = '起始日期不能大于截止日期';
            return false;
        }
        return true;
    }


    function resubmitSearch(page){
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if (compareBeginEndDate('starttime', 'endtime', 'dateError')
                && $('#searchForm').parsley().isValid()) {
            $('#searchBtn').attr('disabled', true);
            //ui block
            pleaseWait();
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/admin/wefamily/qualityMgmtManage?page=" + page;
            searchForm.submit();
        }
    }

    function showQualityMgmtInfo(){
        window.location.href = "${ctx}/admin/wefamily/qualityMgmtInfo?type=${type}";
    }

</script>
</body>
</html>