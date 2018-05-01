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
            咨询报表</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
                <div class="bg-white closel">
                    <div class="col-sm-12 no-padder">
                        <form method="post" action="${ctx}/admin/report/consultReportManage" class="form-horizontal b-l b-r b-b b-t padding20"
                              data-validate="parsley"
                              id="searchForm">
                            <div class="row">
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control " name="dormitoryid" id="dormitoryid" onchange="getDealPersonList()">
                                        <c:if test="${fn:length(dormitoryList) > 1}">
                                            <option value="">宿舍楼</option>
                                        </c:if>
                                        <c:forEach items="${dormitoryList}" var="dormitory">
                                            <option value="${dormitory.uuid}" <c:if test="${consult.dormitoryid == dormitory.uuid}">selected="selected"</c:if>>${dormitory.name}</option>
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
                                        <th class="text-center">未回复</th>
                                        <th class="text-center">占比</th>
                                        <th class="text-center">已回复</th>
                                        <th class="text-center">占比</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${consultReportPageList}" var="consult" varStatus="vs">
                                        <tr
                                                <c:if test="${vs.index%2==1 }">style="background-color: #E1EEF0" </c:if>
                                                <c:if test="${vs.index%2==0 }">style="background-color: #ffffff"</c:if>>
                                            <td>
                                                    ${consult.dormitoryname}
                                            </td>
                                            <td>
                                                <c:if test="${not empty consult.dormitoryid}">
                                                    <a href="/admin/wefamily/consultManage?fromHome=Y&status=N_REPLY&dormitoryId=${consult.dormitoryid}&startDateStr=${startDateStr}&endDateStr=${endDateStr}" style="text-decoration: underline;">
                                                            ${consult.nreplyCount}
                                                    </a>
                                                </c:if>
                                                <c:if test="${empty consult.dormitoryid}">
                                                    ${consult.nreplyCount}
                                                </c:if>

                                            </td>
                                            <td>
                                                    ${consult.nreplyPercent}%
                                            </td>
                                            <td>
                                                <c:if test="${not empty consult.dormitoryid}">
                                                    <a href="/admin/wefamily/consultManage?fromHome=Y&status=Y_REPLY&dormitoryId=${consult.dormitoryid}&startDateStr=${startDateStr}&endDateStr=${endDateStr}" style="text-decoration: underline;">
                                                            ${consult.yreplyCount}
                                                    </a>
                                                </c:if>
                                                <c:if test="${empty consult.dormitoryid}">
                                                    ${consult.yreplyCount}
                                                </c:if>
                                            </td>
                                            <td>
                                                    ${consult.yreplyPercent}%
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${not empty consultReportPageList}">
                                    <web:pagination pageList="${consultReportPageList}" postParam="true"/>
                                </c:if>
                            </div>
                        <div class="navbar-left">
                            <button class="btn btn-sm btn-submit" onclick="exportConsultReportList()">导出</button>
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
        showParentMenu('报表统计');
    }

    function exportConsultReportList(){
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if (compareBeginEndDate('starttime', 'endtime', 'dateError')
                && $('#searchForm').parsley().isValid()) {
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/admin/report/exportConsultReportList";
            searchForm.submit();
            searchForm.action = "${ctx}/admin/report/repairConsultManage";
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
            searchForm.action = "${ctx}/admin/wefamily/consultReportManage?page=" + page;
            searchForm.submit();
        }
    }
    

</script>
</body>
</html>