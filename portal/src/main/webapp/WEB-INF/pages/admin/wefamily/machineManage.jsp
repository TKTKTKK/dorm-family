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
            满田星 / <span class="font-bold  text-shallowred"> 机器管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
                <div class="bg-white closel">
                    <div class="col-sm-12 no-padder">
                        <form method="post" action="${ctx}/admin/wefamily/machineManage" class="form-horizontal b-l b-r b-b padding20"
                              data-validate="parsley"
                              id="searchForm">
                            <div class="row">
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control" name="merchantid" id="merchantid">
                                        <c:if test="${fn:length(merchantList) > 1}">
                                            <option value="">经销商</option>
                                        </c:if>
                                        <c:forEach items="${merchantList}" var="merchant">
                                            <option value="${merchant.uuid}" <c:if test="${machine.merchantid == merchant.uuid}">selected="selected"</c:if>>${merchant.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="orderno" name="orderno" onblur="trimText(this)" value="${machine.orderno}"  placeholder="订单号"/>
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="machineno" name="machineno" onblur="trimText(this)" value="${machine.machineno}"  placeholder="机器号"/>
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="engineno" name="engineno" onblur="trimText(this)" value="${machine.engineno}"  placeholder="发动机号"/>
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
                                <span class="text-danger" id="synFailureMsg"></span>
                                <c:if test="${successFlag == 1}">
                                    <span class="text-success">删除成功！</span>
                                </c:if>
                            </div>
                            <div class="table-responsive" >
                                <table class="table table-striped b-light b-a text-center">

                                    <thead>
                                    <tr>
                                        <th class="text-center">订单号</th>
                                        <th class="text-center">经销商</th>
                                        <th class="text-center">机器名称</th>
                                        <th class="text-center">机器型号</th>
                                        <th class="text-center">机器号</th>
                                        <th class="text-center">发动机号</th>
                                        <th class="text-center">生产日期</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${machineList}" var="machine">
                                        <tr>
                                            <td>
                                                    ${machine.orderno}
                                            </td>
                                            <td>
                                                    ${machine.merchantname}
                                            </td>
                                            <td>
                                                    ${machine.machinename}
                                            </td>
                                            <td>
                                                    ${machine.machinemodel}
                                            </td>
                                            <td>
                                                    ${machine.machineno}
                                            </td>
                                            <td>
                                                    ${machine.engineno}
                                            </td>
                                            <td>
                                                    ${machine.productiondate}
                                            </td>
                                            <td>
                                                <a href="${ctx}/admin/wefamily/machineInfo?machineId=${machine.uuid}" class="btn  btn-infonew btn-sm" style="color: white" >修改</a>
                                                <a href="javascript:deleteMachine('${machine.uuid}')" class="btn  btn-dangernew btn-sm" style="color: white" >删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${not empty machineList}">
                                    <web:pagination pageList="${machineList}" postParam="true"/>
                                </c:if>
                            </div>
                        <div class="navbar-left">
                            <a class="btn btn-sm btn-info" href="javascript:showMachineInfo()"
                               style="color:white">添加机器</a>
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
        showParentMenu('满田星');
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


    function deleteMachine(machineId){
        qikoo.dialog.confirm('确定删除该机器？',function(){
            //确定
            $.get("${ctx}/admin/wefamily/deleteMachine?machineId="+machineId+"&version="+Math.random(),function(data,status){
                if(undefined != data.deleteFlag){
                    var searchForm = document.getElementById("searchForm");
                    searchForm.action = "${ctx}/admin/wefamily/machineManage?deleteFlag=" + data.deleteFlag;
                    searchForm.submit();
                }
            });
        },function(){
            //取消
        });
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
            searchForm.action = "${ctx}/admin/wefamily/machineManage?page=" + page;
            searchForm.submit();
        }
    }


    function showMachineInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/machineInfo";
    }

</script>
</body>
</html>