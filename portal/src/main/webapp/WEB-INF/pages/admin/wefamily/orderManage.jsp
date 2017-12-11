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
            满田星 / <span class="font-bold  text-shallowred"> 订单管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
                <div class="bg-white closel">
                    <div class="col-sm-12 no-padder">
                        <form method="post" action="${ctx}/admin/wefamily/orderManage" class="form-horizontal b-l b-r b-b padding20"
                              data-validate="parsley"
                              id="searchForm">
                            <div class="row">
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="snno" name="snno" onblur="trimText(this)" value="${order.snno}"  placeholder="订单编号"/>
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="machinemodel" name="machinemodel" onblur="trimText(this)" value="${order.machinemodel}"  placeholder="机器型号"/>
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
                                        <th class="text-center">订单编号</th>
                                        <th class="text-center">机器型号</th>
                                        <th class="text-center">数量</th>
                                        <th class="text-center">运输</th>
                                        <th class="text-center">订单状态</th>
                                        <th class="text-center">创建时间</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${orderList}" var="order">
                                        <tr>
                                            <td>
                                                    ${order.snno}
                                            </td>
                                            <td>
                                                    ${order.machinemodel}
                                            </td>
                                            <td>
                                                    ${order.quantity}
                                            </td>
                                            <td>
                                                    ${web:getCodeDesc("ENTRUST_TRANSPORT",order.entrusttransport)}
                                            </td>
                                            <td>
                                                <c:if test="${order.status == 'NEW'}">未发送</c:if>
                                                <c:if test="${order.status == 'OUT'}">已发送</c:if>
                                            </td>
                                            <td>
                                                    ${order.createon}
                                            </td>
                                            <td>
                                                <a href="${ctx}/admin/wefamily/orderInfo?orderId=${order.uuid}" class="btn  btn-infonew btn-sm" style="color: white" <c:if test="${order.status == 'OUT'}">disabled="disabled" </c:if>>修改</a>
                                                <a href="javascript:deleteOrder('${order.uuid}')" class="btn  btn-dangernew btn-sm" style="color: white" <c:if test="${order.status == 'OUT'}">disabled="disabled" </c:if>>删除</a>
                                                <a href="javascript:addMachineForOrder('${order.uuid}')" class="btn btn-sm btn-yellow a-noline" style="color:white">管理订单</a>
                                                <c:if test="${order.status == 'NEW'}">
                                                    <a href="javascript:sendOrder('${order.uuid}','${order.versionno}')" class="btn  btn-success btn-sm" style="color: white">
                                                        发送订单
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${not empty orderList}">
                                    <web:pagination pageList="${orderList}" postParam="true"/>
                                </c:if>
                            </div>
                        <div class="navbar-left">
                            <a class="btn btn-sm btn-info" href="javascript:showOrderInfo()"
                               style="color:white">添加订单</a>
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


    function deleteOrder(orderId){
        qikoo.dialog.confirm('确定删除该仓库？',function(){
            //确定
            $.get("${ctx}/admin/wefamily/deleteOrder?orderId="+orderId+"&version="+Math.random(),function(data,status){
                if(undefined != data.deleteFlag){
                    var searchForm = document.getElementById("searchForm");
                    searchForm.action = "${ctx}/admin/wefamily/orderManage?deleteFlag=" + data.deleteFlag;
                    searchForm.submit();
                }
            });
        },function(){
            //取消
        });
    }

    function sendOrder(orderId,versionno){
        qikoo.dialog.confirm('确定发送订单？',function(){
            //确定
            $.get("${ctx}/admin/wefamily/sendOrder?orderId="+orderId+"&versionno="+versionno,function(data,status){
                if(undefined != data.sendFlag){
                    window.location.href = "<%=request.getContextPath()%>/admin/wefamily/orderDetail?orderId="+orderId+"&sendFlag="+data.sendFlag;
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
            searchForm.action = "${ctx}/admin/wefamily/orderManage?page=" + page;
            searchForm.submit();
        }
    }


    function showOrderInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/orderInfo";
    }

    function addMachineForOrder(orderId){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/orderDetail?orderId="+orderId;
    }

</script>
</body>
</html>