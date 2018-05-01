<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="${ctx}/static/admin/bootstrap-select/bootstrap-select.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="${ctx}/static/admin/bootstrap-select/bootstrap-select.min.js"></script>
    <style>
        @media (min-width: 768px){
            .bootstrap-select>.dropdown-menu {
                /*position: absolute;*/
                top: 0;
                left: 0;
                /*z-index: 1000;*/
                /*display: none;*/
                float: left;
                /*min-width: 160px;*/
                padding: 5px 0;
                margin: 2px 0 0;
                font-size: 14px;
                list-style: none;
                background-color: #fff;
                /*border: 1px solid #ccc;*/
                /*border: 1px solid rgba(0,0,0,0.15);*/
                /*border-radius: 4px;*/
                /*-webkit-box-shadow: 0 6px 12px rgba(0,0,0,0.175);*/
                /*box-shadow: 0 6px 12px rgba(0,0,0,0.175);*/
                background-clip: padding-box;
            }
        }
    </style>
</head>

<body class="">

<section id="content">
    <section class="vbox">

        <header class="panel-heading bg-white text-lg">
            报表管理 / <span class="font-bold  text-shallowred">
            报修报表</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
                <div class="bg-white closel">
                    <div class="col-sm-12 no-padder">
                        <form method="post" action="${ctx}/admin/report/repairReportManage" class="form-horizontal b-l b-r b-b b-t padding20"
                              data-validate="parsley"
                              id="searchForm">
                            <div class="row">
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control " name="dormitoryid" id="dormitoryid" onchange="getDealPersonList()">
                                        <c:if test="${fn:length(dormitoryList) > 1}">
                                            <option value="">宿舍楼</option>
                                        </c:if>
                                        <c:forEach items="${dormitoryList}" var="dormitory">
                                            <option value="${dormitory.uuid}" <c:if test="${repair.dormitoryid == dormitory.uuid}">selected="selected"</c:if>>${dormitory.name}</option>
                                        </c:forEach>
                                    </select>
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
                                        <th class="text-center">宿舍楼</th>
                                        <th class="text-center">学生报修</th>
                                        <th class="text-center">宿管报修</th>
                                        <th class="text-center">未处理</th>
                                        <th class="text-center">占比</th>
                                        <th class="text-center">处理中</th>
                                        <th class="text-center">占比</th>
                                        <th class="text-center">已完成</th>
                                        <th class="text-center">占比</th>
                                        <th class="text-center">维修总额</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${repairReportPageList}" var="repair" varStatus="vs">
                                        <tr
                                                <c:if test="${vs.index%2==1 }">style="background-color: #E1EEF0" </c:if>
                                                <c:if test="${vs.index%2==0 }">style="background-color: #ffffff"</c:if>>
                                            <td>
                                                    ${repair.dormitoryname}
                                            </td>
                                            <td>
                                                    ${repair.countByStudent}
                                            </td>
                                            <td>
                                                    ${repair.countByDormitoryManage}
                                            </td>
                                            <td>
                                                <c:if test="${not empty repair.dormitoryid}">
                                                    <a href="/admin/wefamily/repairManage?fromHome=Y&status=NEW&dormitoryId=${repair.dormitoryid}&startDateStr=${startDateStr}&endDateStr=${endDateStr}" style="text-decoration: underline;">
                                                            ${repair.newCount}
                                                    </a>
                                                </c:if>
                                                <c:if test="${empty repair.dormitoryid}">
                                                    ${repair.newCount}
                                                </c:if>

                                            </td>
                                            <td>
                                                    ${repair.newPercent}%
                                            </td>
                                            <td>
                                                <c:if test="${not empty repair.dormitoryid}">
                                                    <a href="/admin/wefamily/repairManage?fromHome=Y&status=REPAIRING&dormitoryId=${repair.dormitoryid}&startDateStr=${startDateStr}&endDateStr=${endDateStr}" style="text-decoration: underline;">
                                                            ${repair.repairingCount}
                                                    </a>
                                                </c:if>
                                                <c:if test="${empty repair.dormitoryid}">
                                                    ${repair.repairingCount}
                                                </c:if>
                                            </td>
                                            <td>
                                                    ${repair.repairingPercent}%
                                            </td>
                                            <td>
                                                <c:if test="${not empty repair.dormitoryid}">
                                                    <a href="/admin/wefamily/repairManage?fromHome=Y&status=FINISH&dormitoryId=${repair.dormitoryid}&startDateStr=${startDateStr}&endDateStr=${endDateStr}" style="text-decoration: underline;">
                                                            ${repair.finishCount}
                                                    </a>
                                                </c:if>
                                                <c:if test="${empty repair.dormitoryid}">
                                                    ${repair.finishCount}
                                                </c:if>

                                            </td>
                                            <td>
                                                    ${repair.finishPercent}%
                                            </td>
                                            <td>
                                                    ${repair.totalMoney}
                                            </td>

                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${not empty repairReportPageList}">
                                    <web:pagination pageList="${repairReportPageList}" postParam="true"/>
                                </c:if>
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
        showParentMenu('报表管理');

        $("button[data-id='status']").attr('title', "状态");
        $($("button[data-id='status']").find('span')[0]).text("状态")
        $($("button[data-id='status']").find('span')[0]).css('color', '#555');

        if('${statusStr}'.length > 0){
            var statusArr = '${statusStr}'.split(",");
            $('.selectpicker').selectpicker('val', statusArr);
        }
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

    function exportQualityMgmtList(){
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if (compareBeginEndDate('starttime', 'endtime', 'dateError')
                && $('#searchForm').parsley().isValid()) {
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/admin/wefamily/exportRepairList";
            searchForm.submit();
            searchForm.action = "${ctx}/admin/wefamily/repairManage";
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
            searchForm.action = "${ctx}/admin/wefamily/repairManage?page=" + page;
            searchForm.submit();
        }
    }

    function showRepairInfo(){
        window.location.href = "${ctx}/admin/wefamily/repairInfo";
    }

    //获取处理人列表
    function getDealPersonList(){
        var dormitoryId = $("select[name='dormitoryid'] option:selected").val();
        if(dormitoryId.length > 0){
            $.get("${ctx}/admin/wefamily/"+dormitoryId+"/dealRepairPerson",function(data,status){
                var workerList = data.workerList;
                initDealPersonList();
                for(i=0;i<workerList.length;i++){
                    $("select[name='worker']").append($("<option>").val(workerList[i].uuid).text(workerList[i].name));
                    if('${repair.worker}' != "" && '${repair.worker}' == workerList[i].uuid){
                        $("select[name='worker']").val(workerList[i].uuid);
                    }
                }
            });
        }
    }
    //查询处理人
    getDealPersonList();

    function initDealPersonList(){
        $("select[name='worker']").empty();
        $("select[name='worker']").append($("<option>").val("").text("处理人"));
    }

</script>
</body>
</html>