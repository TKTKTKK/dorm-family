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
            销售管理 / <span class="font-bold  text-shallowred"> 订单管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
                <div class="bg-white closel">
                    <div class="col-sm-12 no-padder">
                        <form method="post" action="${ctx}/admin/wefamily/orderManage" class="form-horizontal b-l b-r b-b b-t padding20"
                              data-validate="parsley"
                              id="searchForm">
                            <div class="row">
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control" name="merchantid" id="merchantid" <shiro:hasAnyRoles name="MERCHANT_MANAGER">data-required="true"</shiro:hasAnyRoles>>
                                        <c:if test="${fn:length(merchantList) > 1}">
                                            <option value="">经销商</option>
                                        </c:if>
                                        <c:forEach items="${merchantList}" var="merchant">
                                            <option value="${merchant.uuid}" <c:if test="${order.merchantid == merchant.uuid}">selected="selected"</c:if>>${merchant.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="selectpicker show-tick form-control " name="status" id="status"  multiple data-live-search="false">
                                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('ORDER_STATUS')}"></c:set>
                                        <c:forEach items="${commonCodeList}" var="commonCode">
                                            <option value="${commonCode.code}" <c:if test="${qualityMgmt.evaluate == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="snno" name="snno" onblur="trimText(this)" value="${order.snno}"  placeholder="订单编号"/>
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control" name="machinemodel" id="machinemodel">
                                        <c:if test="${fn:length(machineModelList) > 1}">
                                            <option value="">机器型号</option>
                                        </c:if>
                                        <c:forEach items="${machineModelList}" var="machineModel">
                                            <option value="${machineModel}" <c:if test="${order.machinemodel == machineModel}">selected</c:if>>${machineModel}</option>
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
                                        <th class="text-center">经销商</th>
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
                                                    <a href="${ctx}/admin/wefamily/orderDetail?orderId=${order.uuid}" style="text-decoration: underline;">${order.snno}</a>
                                            </td>
                                            <td>
                                                    ${order.merchantname}
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
                                                    ${web:getCodeDesc("ORDER_STATUS",order.status)}
                                            </td>
                                            <td>
                                                    ${order.createon}
                                            </td>
                                            <td>

                                                <a href="${ctx}/admin/wefamily/orderInfo?orderId=${order.uuid}&merchantId=${order.merchantid}" class="btn  btn-infonew btn-sm" style="color: white" <c:if test="${order.status ne 'UNSUBMIT'}">disabled="disabled" </c:if>>修改</a>
                                                <a href="javascript:deleteOrder('${order.uuid}')" class="btn  btn-dangernew btn-sm" style="color: white" <c:if test="${order.status ne 'UNSUBMIT'}">disabled="disabled" </c:if>>删除</a>
                                                <shiro:hasAnyRoles name="HQ_PLAN,HQ_FINANCE">
                                                    <a href="javascript:addMachineForOrder('${order.uuid}')" class="btn btn-sm btn-yellow a-noline" style="color:white">管理订单</a>
                                                </shiro:hasAnyRoles>
                                                <c:if test="${order.status == 'UNSUBMIT'}">
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
        showParentMenu('销售管理');

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
        qikoo.dialog.confirm('确定删除该订单？',function(){
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
                    var searchForm = document.getElementById("searchForm");
                    searchForm.action = "${ctx}/admin/wefamily/orderManage?sendFlag=" + data.sendFlag;
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
            searchForm.action = "${ctx}/admin/wefamily/orderManage?page=" + page;
            searchForm.submit();
        }
    }


    function showOrderInfo(){
        var mercahntid = $("#merchantid").val();
        if(mercahntid.length > 0){
            window.location.href = "<%=request.getContextPath()%>/admin/wefamily/orderInfo?merchantId="+mercahntid;
        }else{
            qikoo.dialog.alert("请选择经销商！");
        }
    }

    function addMachineForOrder(orderId){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/orderDetail?orderId="+orderId;
    }

</script>
</body>
</html>