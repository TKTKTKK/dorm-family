<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <style>
        .detaildiv1 ul li {
            border: 0;
            padding: 0px 10px;
            list-style: none;
        }

        .new-of-storey li {
            position: relative;
            padding: 15px 10px;
            border-bottom: 1px dotted #e8e5e5;
        }

        .new-of-storey li span {
            display: block;
            font-size: 14px;
            color: #6e6e6e;
        }

        .new-of-storey li .icon {
            position: absolute;
            top: 42%;
            /*left: -15px;*/
            left: -8px;
            width: 12px;
            height: 12px;
            /*width: 9px;*/
            /*height: 9px;*/
            border-radius: 6px;
            background-color: #dedede;
            /*background-color: #ccc;*/
        }

        .new-of-storey li .icon.on {
            background-color: #e4393c;
        }

        .tishiyu {
            font-family: "微软雅黑";
            font-size: 13px;
            width: 100%;
            color: #6e6e6e;
        }

        .time {
            color: #999;
            font-family: "微软雅黑";
            font-size: 13px;
        }

        .panel-body .form-group .col-sm-3 {
            padding: 15px;
            margin: 0;
        }

        .dropdown > .dropdown-menu:after {
            position: absolute;
            top: -7px;
            /*left: 10px;*/
            right: 10px;
            display: inline-block !important;
            border-right: 7px solid transparent;
            border-bottom: 7px solid #fff;
            border-left: 7px solid transparent;
            content: '';
        }

        .dropdown > .dropdown-menu:before {
            position: absolute;
            top: -8px;
            /*left: 9px;*/
            right: 10px;
            display: inline-block !important;
            border-right: 8px solid transparent;
            border-bottom: 8px solid #e0e0e0;
            border-left: 8px solid transparent;
            content: '';
        }

        .dropdown-menu {
            border-radius: 5px;
        }

        .portlet.box.green {
            border: 1px solid #5cd1db;
            border-top: 0;
        }

        .portlet {
            margin-top: 0;
            margin-bottom: 25px;
            padding: 0;
            border-radius: 4px;
        }

        .portlet-title {
            border-bottom: 1px solid #eee;
            padding: 0;
            margin-bottom: 10px;
            min-height: 41px;
            -webkit-border-radius: 4px 4px 0 0;
            -moz-border-radius: 4px 4px 0 0;
            -ms-border-radius: 4px 4px 0 0;
            -o-border-radius: 4px 4px 0 0;
            border-radius: 4px 4px 0 0;
            padding: 0 10px;
        }
        .detail-div{
            padding-right: 0px;
            margin-bottom: 10px;
        }

        .caption {
            padding: 11px 0 9px;
            float: left;
            display: inline-block;
            font-size: 18px;
            line-height: 18px;
            padding: 10px 0;
            color: #fff;
        }

        .static-info .value {
            font-size: 14px;
        }
        .static-info .name {
            font-weight: 600;
        }
        .green .portlet-title {
            background-color: #32c5d2;
            color: #fff;
        }

        .static-info {
            width: 100%;
            margin: 0 auto 10px auto;
        }

        .portlet.box.blue-hoki {
            border: 1px solid #869ab3;
            border-top: 0;
        }

        .blue-hoki > .portlet-title {
            background-color: #67809F;
        }

        .portlet.box.red-sunglo {
            border: 1px solid #ea9595;
            border-top: 0;
        }

        .red-sunglo .portlet-title {
            background-color: #E26A6A;
        }
        @media screen and (max-width: 500px){
            .value img,.value .new-of-storey img{
                width: 40%;
                padding-bottom: 3px;
            }
            .modal-body img{
                width: 40%;
                padding-bottom: 3px;
            }
        }
        @media screen and (min-width: 510px){
            .value img,.value .new-of-storey img{
                width: 10%;
                padding-bottom: 3px;
            }
            .modal-body img{
                width: 10%;
                padding-bottom: 3px;
            }
        }
        .new-of-storey img{
            width: 15%;
        }
        .new-of-storey li:nth-of-type(even){
            background-color: #efefef;
        }
        .form-group{
            background-color: #fff;
        }
        .nav-tabs .active{
            margin-bottom: 0;
            padding: 0;
        }
        .modal-header .close{
            padding: 5px 10px !important;
        }
        .table-responsive td{
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
        }
        .tab li{
            margin-bottom: -1px;
            display: inline-block;
            padding: 0 3%;
            float: none;
        }
        .tab  .active{
            border-bottom: 3px solid red;
            border-top:0;
            padding: 0 3%;
        }
        .tab  .active a{
            border:0 !important;
        }
        .tab{
            overflow: auto;
            white-space: nowrap;
            margin-bottom: 10px;
        }
        .pading{
            padding-top: 0px;
            padding-bottom: 10px;
            border:1px solid transparent;
            height: 30px;
            line-height: 30px;
            border-radius: 4px;
        }
        .pading:hover{
            background-color: #c4e1ff;
            color: #000;
        }
        .supplier-ul{
            margin: 0;
            padding: 0;
            border-radius: 4px;
            border:1px solid #cbd5dd;;
        }
        .supplier-ul, li{
            list-style: none;
            margin: 0;
            padding: 0
        }

        @media (max-width: 767px){
            .static-info .value {
                font-size: 14px;
            }
            .static-info .name {
                font-weight: 600;
                text-align: right;
                padding-right: 0px;
                padding-left: 0px;
            }
            .form-horizontal .control-label {
                text-align: right;
            }
            .top-margin-sm{
                margin-top: 25px;
            }
            .form-horizontal .control-label {
                text-align: right;
            }
        }
        #receiptImgContainer{display: inline-block;vertical-align: middle}
        #receiptImgUrlContainer{display: inline-block;vertical-align: middle;margin-left: 0rem}
        #receiptImgContainer img{width: 5rem;height: 5rem;margin:1rem}
    </style>
</head>
<body class="">
<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable padder">
            <div class="row" id="sugInfoDiv" style="overflow-x: hidden;overflow-y: auto;">
                <header class="panel-heading bg-white text-md b-b">
                    满田星 /
                    <a href="${ctx}/admin/wefamily/orderManage"><span class="font-bold text-shallowred">订单管理</span></a>
                </header>
                <div class="col-sm-12 pos">
                    <div id="myTabContent" class="tab-content">
                        <div class="tab-pane fade in active" id="detail">
                            <div class="b-l b-r">
                                <span class="text-success">${successMessage}</span>
                                <span class="text-danger">${errorMessage}</span>
                            </div>
                            <form class="form-horizontal" data-validate="parsley"
                                  action="${ctx}/admin/weproperty/saveSuggestionFeedback?communityId=${wpCommunity.uuid}"
                                  method="POST" id="frmForDtl"
                                  enctype="multipart/form-data">
                                <section class="panel panel-default" style="border-top:0">
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="tab_1">
                                            <div class="col-md-6">
                                                <!--订单详情-->
                                                <div class="portlet green box">
                                                        <div class="portlet-title">
                                                            <div class="caption"><i class="fa fa-cogs"></i>订单详情</div>
                                                        </div>
                                                        <div class="portlet-body">
                                                            <div class="row static-info" style="margin-bottom: 0px">
                                                                <div class="col-md-2 col-xs-4 name detail-div">订单编号:</div>
                                                                <div class="col-md-4 col-xs-8 value detail-div" >${order.snno}</div>

                                                                <div class="col-md-2 col-xs-4 name detail-div">订单数量:</div>
                                                                <div class="col-md-4 col-xs-8 value detail-div" >${order.quantity}</div>
                                                            </div>
                                                            <div class="row static-info" style="margin-bottom: 0px">
                                                                <div class="col-md-2 col-xs-4 name detail-div">机器型号:</div>
                                                                <div class="col-md-4 col-xs-8 value detail-div" >${order.machinemodel}</div>

                                                                <div class="col-md-2 col-xs-4 name detail-div">委托运输:</div>
                                                                <div class="col-md-4 col-xs-8 value detail-div" >${web:getCodeDesc("ENTRUST_TRANSPORT",order.entrusttransport)}</div>
                                                            </div>
                                                            <div class="row static-info" style="margin-bottom: 0px">
                                                                <div class="col-md-2 col-xs-4 name detail-div" style="padding-right: 0px">株距要求:</div>
                                                                <div class="col-md-4 col-xs-8 value detail-div" >${order.rowspace}</div>

                                                                <div class="col-md-2 col-xs-4 name detail-div" style="padding-right: 0px">横向送秧次数:</div>
                                                                <div class="col-md-4 col-xs-8 value detail-div" >${order.transversetime}</div>
                                                            </div>
                                                            <div class="row static-info" style="margin-bottom: 0px">
                                                                <div class="col-md-2 col-xs-4 name detail-div" style="padding-right: 0px">宽秧针:</div>
                                                                <div class="col-md-4 col-xs-8 value detail-div" >${web:getCodeDesc("SEEDLING_NEEDLE",order.seedlingneedle)}</div>

                                                                <div class="col-md-2 col-xs-4 name detail-div" style="padding-right: 0px">载秧篮:</div>
                                                                <div class="col-md-4 col-xs-8 value detail-div" >${web:getCodeDesc("SEEDLING_BASKET",order.seedlingbasket)}</div>
                                                            </div>
                                                            <div class="row static-info" style="margin-bottom: 0px">
                                                                <div class="col-md-2 col-xs-4 name detail-div" style="padding-right: 0px">电启动:</div>
                                                                <div class="col-md-4 col-xs-8 value detail-div" >${web:getCodeDesc("ORDER_CHOOSE",order.electricstart)}</div>

                                                                <div class="col-md-2 col-xs-4 name detail-div" style="padding-right: 0px">工作服:</div>
                                                                <div class="col-md-4 col-xs-8 value detail-div" >${web:getCodeDesc("ORDER_CHOOSE",order.coverall)}</div>
                                                            </div>
                                                            <div class="row static-info" style="margin-bottom: 0px">
                                                                <div class="col-md-2 col-xs-4 name detail-div" style="padding-right: 0px">塑料罩:</div>
                                                                <div class="col-md-4 col-xs-8 value detail-div" >${web:getCodeDesc("ORDER_CHOOSE",order.plasticcover)}</div>

                                                                <div class="col-md-2 col-xs-4 name detail-div" style="padding-right: 0px">20升油箱:</div>
                                                                <div class="col-md-4 col-xs-8 value detail-div" >${web:getCodeDesc("ORDER_CHOOSE",order.fueltank)}</div>
                                                            </div>
                                                            <c:if test="${not empty order.merchantremarks}">
                                                                <div class="row static-info" style="margin-bottom: 0px">
                                                                    <div class="col-md-2 col-xs-4 name detail-div" style="padding-right: 0px">经销商备注:</div>
                                                                    <div class="col-md-10 col-xs-8 value detail-div" >${order.merchantremarks}</div>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </div>

                                                    <!--物流信息-->
                                                    <c:if test="${order.status ne 'NEW'}">
                                                        <div class="portlet red-sunglo box">
                                                            <div class="portlet-title">
                                                                <div class="caption"><i class="fa fa-cogs"></i>物流信息</div>
                                                            </div>
                                                            <div class="portlet-body">
                                                                <div class="row static-info">
                                                                    <div class="col-md-12 col-xs-12 value">
                                                                        <c:if test="${fn:length(logisticsList) > 0}">
                                                                            <div class="detaildiv1"
                                                                                 style="padding: 0px 0px 0px 0px;margin-left: 0px;margin-bottom: 10px;width: 100%;">
                                                                                <ul class="new-of-storey"
                                                                                    style="margin-left: -35px;">
                                                                                    <c:forEach var="logistics" items="${logisticsList}" varStatus="stat">
                                                                                        <li style="border:0px;padding: 0px 0px 0px 10px;border-left: 3px solid #ccc;">
                                                                                            <div>
                                                                                                <c:if test="${stat.index > 0}">
                                                                                                    <span class="icon" ></span>
                                                                                                </c:if>
                                                                                                <c:if test="${stat.index == 0}">
                                                                                                    <span class="icon on"></span>
                                                                                                </c:if>
                                                                                                <span style="color: #000000">
                                                                                                        司机号码：${logistics.driverphone} 车牌号：${logistics.platenumber}
                                                                                                </span>
                                                                                            </div>
                                                                                            <c:if test="${not empty logistics.remarks}">
                                                                                                <div>
                                                                                                <span style="color: #000000">
                                                                                                    备注：${logistics.remarks}
                                                                                                </span>
                                                                                                </div>
                                                                                            </c:if>
                                                                                            <div class="time">
                                                                                                <div class="pull-left">
                                                                                                        ${fn:substring(logistics.createon, 0, 19)}
                                                                                                </div>
                                                                                                <div class="pull-right">
                                                                                                        ${logistics.location}
                                                                                                </div>
                                                                                            </div>
                                                                                            <div style="clear: both"></div>
                                                                                        </li>
                                                                                    </c:forEach>
                                                                                </ul>
                                                                            </div>
                                                                        </c:if>
                                                                        <c:if test="${fn:length(logisticsList) == 0}">
                                                                            <span>暂无物流信息</span>
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                                <shiro:hasRole name="HQ_FINANCE">
                                                                    <c:if test="${order.status == 'INLOGISTICS' && fn:length(receiptList) == 0}">
                                                                        <a class="btn btn-sm btn-danger" href="javascript:addLogistics()" style="color: white;margin-left: 10px;margin-bottom: 10px">添加物流信息</a>
                                                                        <button class="hidden" data-toggle="modal" data-target=".bs-example-modal-tj-logistics" style="color: white" id="addLogistics">添加物流信息</button>
                                                                    </c:if>
                                                                </shiro:hasRole>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                    <!--回执信息-->
                                                    <c:if test="${order.status ne 'NEW'}">
                                                        <div class="portlet blue-hoki box">
                                                            <div class="portlet-title">
                                                                <div class="caption"><i class="fa fa-cogs"></i>回执信息</div>
                                                            </div>
                                                            <div class="portlet-body">
                                                                <c:if test="${fn:length(receiptList) > 0}">
                                                                    <div class="row static-info" style="margin-bottom: 0px">
                                                                        <div class="col-md-2 col-xs-4 name detail-div">回执日期:</div>
                                                                        <div class="col-md-4 col-xs-8 value detail-div" >${receiptList[0].receiptdt}</div>

                                                                        <div class="col-md-2 col-xs-4 name detail-div">满意度:</div>
                                                                        <div class="col-md-4 col-xs-8 value detail-div" >${web:getCodeDesc("SATISFACTION", receiptList[0].satisfaction)}</div>
                                                                    </div>
                                                                    <c:if test="${not empty receiptList[0].question}">
                                                                        <div class="row static-info" style="margin-bottom: 0px">
                                                                            <div class="col-md-2 col-xs-4 name detail-div">问题反馈:</div>
                                                                            <div class="col-md-10 col-xs-8 value detail-div" >${receiptList[0].question}</div>
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${fn:length(attachmentList) > 0}">
                                                                        <div class="row static-info" style="margin-bottom: 0px">
                                                                            <div class="col-md-2 col-xs-4 name detail-div">回执图片:</div>
                                                                            <div class="col-md-10 col-xs-8 value detail-div" >
                                                                                <c:forEach var="receiptImg" items="${attachmentList}">
                                                                                    <img src="${receiptImg.name}" style="width: 50px;height: 50px;"
                                                                                         onclick="viewBigImage(this)" data-toggle="modal" data-target=".bs-example-modal-lg-image"
                                                                                    />
                                                                                </c:forEach>
                                                                            </div>
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${not empty order.remarks}">
                                                                        <div class="row static-info" style="margin-bottom: 0px">
                                                                            <div class="col-md-2 col-xs-4 name detail-div">订单备注:</div>
                                                                            <div class="col-md-10 col-xs-8 value detail-div" >${order.remarks}</div>
                                                                        </div>
                                                                    </c:if>
                                                                </c:if>
                                                                <c:if test="${fn:length(receiptList) == 0}">
                                                                    <div class="row static-info">
                                                                        <div class="col-md-12 col-xs-12 value">
                                                                            <span>暂无回执信息</span>
                                                                        </div>
                                                                    </div>
                                                                </c:if>
                                                                <shiro:hasRole name="HQ_FINANCE">
                                                                    <c:if test="${ fn:length(logisticsList) > 0 && order.status ne 'FILED' && order.status == 'INLOGISTICS' || order.status == 'RECEIVED'}">
                                                                        <a class="btn btn-sm" href="javascript:addReceipt()" style="color: #fff;margin-left: 10px;margin-bottom: 10px;background-color: #67809F">
                                                                            <c:if test="${fn:length(receiptList) == 0}">添加回执信息</c:if>
                                                                            <c:if test="${fn:length(receiptList) == 1}">修改回执信息</c:if>
                                                                        </a>
                                                                        <button class="hidden" data-toggle="modal" data-target=".bs-example-modal-tj-receipt" style="color: white" id="addReceipt">添加回执信息</button>
                                                                        <c:if test="${fn:length(receiptList) > 0}">
                                                                            <a class="btn btn-sm"  data-toggle="modal" data-target=".bs-example-modal-order-remarks" style="color: #fff;margin-left: 10px;margin-bottom: 10px;background-color: #67809F">
                                                                                <i class="fa fa-check"></i> 订单完成
                                                                            </a>
                                                                        </c:if>
                                                                    </c:if>
                                                                </shiro:hasRole>
                                                            </div>
                                                        </div>
                                                    </c:if>

                                            </div>
                                            <div class="col-md-6">
                                                <!--机器信息-->
                                                <div class="portlet green box">
                                                        <div class="portlet-title">
                                                            <div class="caption"><i class="fa fa-cogs"></i>机器信息</div>
                                                        </div>
                                                        <div class="portlet-body">
                                                            <div class="table-responsive" id="respDiv">
                                                                <table class="table table-striped  b-light b-a text-center">
                                                                    <thead>
                                                                    <tr>
                                                                        <th class="text-center">机器名称</th>
                                                                        <th class="text-center">机器号</th>
                                                                        <th class="text-center">发动机号</th>
                                                                        <th class="text-center">生产日期</th>
                                                                        <shiro:hasRole name="HQ_PLAN">
                                                                            <c:if test="${order.status == 'NEW' || order.status == 'INPLAN'}">
                                                                                <th class="text-center">操作</th>
                                                                            </c:if>
                                                                        </shiro:hasRole>


                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    <c:forEach items="${machineList}" var="machine">
                                                                        <tr>
                                                                            <td>
                                                                                    ${machine.machinename}
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
                                                                            <shiro:hasRole name="HQ_PLAN">
                                                                                <c:if test="${order.status == 'NEW' || order.status == 'INPLAN'}">
                                                                                    <td>
                                                                                        <a href="javascript:showMachineInfo('${machine.machinename}','${machine.machinemodel}','${machine.machineno}','${machine.engineno}','${machine.productiondate}','${machine.price}','${machine.remarks}','${machine.uuid}','${machine.versionno}')"
                                                                                           class="btn btn-sm btn-infonew a-noline" style="color: #fff">详情</a>
                                                                                        <a href="javascript:deleteMachineForOrder('${machine.uuid}')"
                                                                                           class="btn btn-sm btn-danger a-noline" style="color: #fff">删除</a>
                                                                                    </td>
                                                                                </c:if>
                                                                            </shiro:hasRole>
                                                                        </tr>
                                                                    </c:forEach>
                                                                    </tbody>
                                                                </table>
                                                                <c:if test="${not empty machineList}">
                                                                    <web:pagination pageList="${machineList}" postParam="true"/>
                                                                </c:if>
                                                                <shiro:hasRole name="HQ_PLAN">
                                                                    <c:if test="${order.status == 'NEW' || order.status == 'INPLAN'}">
                                                                        <a class="btn btn-sm btn-info" href="javascript:addMachine()" style="color: white;margin-left: 10px;margin-bottom: 10px">添加机器</a>
                                                                        <button class="hidden" data-toggle="modal" data-target=".bs-example-modal-tj" style="color: white" id="addMachine">添加机器</button>
                                                                    </c:if>
                                                                    <c:if test="${fn:length(machineList) >= order.quantity && (order.status =='NEW' || order.status == 'INPLAN')}">
                                                                        <a class="btn btn-sm btn-success" href="javascript:finishAddMachine('${order.uuid}','${order.versionno}')" style="color: white;margin-left: 10px;margin-bottom: 10px">添加完成</a>
                                                                    </c:if>
                                                                </shiro:hasRole>
                                                            </div>

                                                        </div>
                                                    </div>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3"></div>
            </div>

            <!-- 机器信息modal添加 -->
            <div class="modal fade bs-example-modal-tj " tabindex="-1" role="dialog"
                 aria-labelledby="myLargeModalLabelTj" aria-hidden="false">
                <div class="modal-dialog modal-lg" style="margin-top: 15%">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" id="modelCloseBtnAdd"><span
                                    aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title" id="myLargeModalLabelAdd">机器</h4>
                        </div>
                        <form action="${ctx}/admin/wefamily/addMachineForOrder" method="POST" id="addMachineFrm">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="portlet green box">
                                            <div class="portlet-title">
                                                <div class="caption"><i class="fa fa-cogs"></i>机器信息</div>
                                            </div>
                                            <div class="portlet-body">
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">机器型号:<span class="text-danger">*</span></div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <input type="text" class="form-control" name="machinemodel"
                                                                   id="machinemodel"  data-required="true"
                                                                   value="${order.machinemodel}" readonly
                                                            >
                                                            <input type="hidden" id="machineId" name="machineId">
                                                            <input type="hidden" id="versionno" name="versionno">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">机器名称:<span class="text-danger">*</span></div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <input type="text" class="form-control" name="machinename"
                                                                   id="machinename" data-maxlength="32" data-required="true"
                                                                   onblur="trimText(this)"
                                                            >
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">机器号:<span class="text-danger">*</span></div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <input type="text" class="form-control" name="machineno"
                                                                   id="machineno" data-maxlength="32" data-required="true"
                                                                   onblur="trimText(this)"
                                                            >
                                                            <span id="machinenoError" class="text-danger"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">发动机号:<span class="text-danger">*</span></div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <input type="text" class="form-control" name="engineno"
                                                                   id="engineno" data-maxlength="32" data-required="true"
                                                                   onblur="trimText(this)"
                                                            >
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">生产日期:<span class="text-danger">*</span></div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                                                   name="productiondate"
                                                                   data-date-format="yyyy-mm-dd" id="productiondate" >
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">机器价格:<span class="text-danger">*</span></div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <input class="form-control" size="6"
                                                                   data-required="true" name="price"
                                                                   id="price" data-maxlength="10"
                                                                   onblur="validateMoney(this,'priceError')"
                                                            >
                                                            <span id="priceError" class="text-danger"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">备注:</div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <textarea class="form-control" rows="5" name="remarks" id="remarks"
                                                                      data-maxlength="256"
                                                                      onblur="trimText(this)"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer" style="text-align: center;border: 0;margin: 0;padding: 0 20px 20px 20px;">
                                    <a href="javascript:submitMachineInfo()"
                                       class="btn btn-submit btn-s-md a-noline" style="color: #fff"
                                       id="submitAddBtn"
                                    >提交</a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->

            <!-- 物流信息modal添加 -->
            <div class="modal fade bs-example-modal-tj-logistics " tabindex="-1" role="dialog"
                 aria-labelledby="myLargeModalLabelTj" aria-hidden="false">
                <div class="modal-dialog modal-lg" style="margin-top: 15%">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" id="modelCloseBtnAddLogistics"><span
                                    aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title" id="myLargeModalLabelAddLogistics">物流</h4>
                        </div>
                        <form action="${ctx}/admin/wefamily/addLogisticsForOrder" method="POST" id="addLogisticsFrm" data-validate="parsley">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="portlet green box">
                                            <div class="portlet-title">
                                                <div class="caption"><i class="fa fa-cogs"></i>物流信息</div>
                                            </div>
                                            <div class="portlet-body">
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">司机电话:<span class="text-danger">*</span></div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <input type="text" class="form-control" name="driverphoneAdd"
                                                                   id="driverphoneAdd"  data-required="true" data-maxlength="11"
                                                                   onblur="trimText(this),validateContactno()"
                                                            >
                                                            <span class="text-danger" id="contactnoError"></span>
                                                            <input type="hidden" id="logisticsId" name="logisticsId">
                                                            <input type="hidden" id="versionnoForLogistics" name="versionnoForLogistics">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">车牌号:<span class="text-danger">*</span></div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <input type="text" class="form-control" name="platenumberAdd"
                                                                   id="platenumberAdd" data-maxlength="20" data-required="true"
                                                            >
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">现在位置:<span class="text-danger">*</span></div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <input type="text" class="form-control" name="locationAdd"
                                                                   id="locationAdd" data-maxlength="32" data-required="true"
                                                                   onblur="trimText(this)"
                                                            >
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">备注:</div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <textarea class="form-control" rows="5" name="remarksAdd" id="remarksAdd"
                                                                      data-maxlength="100"
                                                                      onblur="trimText(this)"></textarea>
                                                            <span id="remarksError" class="text-danger"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer" style="text-align: center;border: 0;margin: 0;padding: 0 20px 20px 20px;">
                                    <a href="javascript:submitLogisticsInfo()"
                                       class="btn btn-submit btn-s-md a-noline" style="color: #fff"
                                       id="submitAddLogisticsBtn"
                                    >提交</a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->

            <!-- 回执信息modal添加 -->
            <div class="modal fade bs-example-modal-tj-receipt " tabindex="-1" role="dialog"
                 aria-labelledby="myLargeModalLabelTj" aria-hidden="false">
                <div class="modal-dialog modal-lg" style="margin-top: 15%">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" id="modelCloseBtnAddReceipt"><span
                                    aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title" id="myLargeModalLabelAddReceipt">回执</h4>
                        </div>
                        <form action="${ctx}/admin/wefamily/addReceiptForOrder" method="POST" id="addReceiptFrm" data-validate="parsley">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="portlet green box">
                                            <div class="portlet-title">
                                                <div class="caption"><i class="fa fa-cogs"></i>回执信息</div>
                                            </div>
                                            <div class="portlet-body">
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">回执日期:<span class="text-danger">*</span></div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                                                   name="receiptdtAdd" data-required="true"
                                                                   data-date-format="yyyy-mm-dd" id="receiptdtAdd" >
                                                        </div>
                                                        <input type="hidden" id="receiptId" name="receiptId">
                                                        <input type="hidden" id="receiptVersionno" name="receiptVersionno">
                                                    </div>
                                                </div>
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">满意度:<span class="text-danger">*</span></div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <select  class="form-control" name="satisfactionAdd" id="satisfactionAdd"
                                                                     data-required="true">
                                                                <c:set var="commonCodeList" value="${web:queryCommonCodeList('SATISFACTION')}"></c:set>
                                                                <option value="">--请选择--</option>
                                                                <c:forEach items="${commonCodeList}" var="commonCode">
                                                                    <option value="${commonCode.code}" <c:if test="${receipt.satisfaction == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">问题反馈:</div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <textarea class="form-control" rows="4" name="questionAdd" id="questionAdd"
                                                                      data-maxlength="100"
                                                                      onblur="trimText(this)"></textarea>
                                                            <span id="questionError" class="text-danger"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">回执照片:</div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <div id="receiptImgUrlContainer">
                                                                <input type="file" id="receiptImg" name="picUrl" class="filestyle"
                                                                       data-icon="false" data-classButton="btn btn-default"
                                                                       data-classInput="form-control inline v-middle input-xs"
                                                                       onchange="compressUploadPicture(this)" accept="image/*"
                                                                <%--data-max_size="2000000" --%>
                                                                       style="display: none"
                                                                       data-max-count="4">
                                                                <div id="picUrlError" class="text-danger"></div>
                                                            </div>
                                                            <div id="receiptImgContainer" class="row value">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer" style="text-align: center;border: 0;margin: 0;padding: 0 20px 20px 20px;">
                                    <a href="javascript:submitReceiptInfo()"
                                       class="btn btn-submit btn-s-md a-noline" style="color: #fff"
                                       id="submitAddReceiptBtn"
                                    >提交</a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->

            <!-- 订单备注modal添加 -->
            <div class="modal fade bs-example-modal-order-remarks " tabindex="-1" role="dialog"
                 aria-labelledby="myLargeModalLabelTj" aria-hidden="false">
                <div class="modal-dialog modal-lg" style="margin-top: 15%">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" id="modelCloseBtnAddRemarks"><span
                                    aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title" id="myLargeModalLabelAddRemarks">订单</h4>
                        </div>
                        <form action="${ctx}/admin/wefamily/finishOrder" method="POST" id="addRemarksFrm" data-validate="parsley">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="portlet green box">
                                            <div class="portlet-title">
                                                <div class="caption"><i class="fa fa-cogs"></i>订单完成</div>
                                            </div>
                                            <div class="portlet-body">


                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">备注:</div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <textarea class="form-control" rows="4" name="remarksForOrder" id="remarksForOrder"
                                                                      data-maxlength="256"
                                                                      onblur="trimText(this)"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer" style="text-align: center;border: 0;margin: 0;padding: 0 20px 20px 20px;">
                                    <a href="javascript:finishOrder()"
                                       class="btn btn-submit btn-s-md a-noline" style="color: #fff"
                                       id="submitAddRemarksBtn"
                                    >提交</a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->

            <!-- /.modal 大图 start -->
            <div class="modal fade bs-example-modal-lg-image" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">

                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" id="modelCloseBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title" id="myLargeModalLabel">大图</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="bs-example" data-example-id="simple-carousel">
                                        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div>
            <!-- /.modal 大图 end -->

        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<script src="${ctx}/static/admin/js/lrz/dist/lrz.bundle.js"></script>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">
    window.onload = function () {
        if($(window).width()>500){
            document.getElementById('sugInfoDiv').style.height = (document.documentElement.clientHeight - 85 / 985 * document.documentElement.clientHeight) + "px";
            //显示父菜单
            showParentMenu('微物业');
        }
    }

    //订单添加机器
    function submitMachineInfo(){
        var machinenoError = document.getElementById('machinenoError');
        machinenoError.innerHTML = "";
        $("#addMachineFrm").parsley("validate");
        if($('#addMachineFrm').parsley().isValid()){
            $('#submitAddBtn').attr('disabled', true);
            $.ajax({
                cache: true,
                type: "POST",
                url:"${ctx}/admin/wefamily/addMachineForOrder?orderId=${order.uuid}",
                data:$('#addMachineFrm').serialize(),// 你的formid
                async: false,
                error: function(request) {
                    $('#submitAddBtn').removeAttr('disabled');
                    qikoo.dialog.alert("系统忙，稍候再试");
                },
                success: function(data) {
                    if(undefined != data.returnMsg){
                        machinenoError.innerHTML = data.returnMsg;
                        $('#submitAddBtn').removeAttr('disabled');
                    }else{
                        $('#modelCloseBtnAdd').click();
                        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/orderDetail?orderId=${order.uuid}&successMessage="+data.successMessage;
                    }
                }
            });
        }
    }

    //订单删除机器
    function deleteMachineForOrder(machineId){
        $.get("${ctx}/admin/wefamily/deleteMachineForOrder?machineId="+machineId,function(data,status){
            if(undefined != data.deleteFlag){
                   window.location.href = "<%=request.getContextPath()%>/admin/wefamily/orderDetail?orderId=${order.uuid}&deleteFlag="+data.deleteFlag;
            }
        });
    }

    function finishAddMachine(orderId,versionno){
        $.get("${ctx}/admin/wefamily/finishAddMachine?orderId="+orderId+"&versionno="+versionno,function(data,status){
            if(undefined != data.finishAddFlag){
                window.location.href = "<%=request.getContextPath()%>/admin/wefamily/orderDetail?orderId=${order.uuid}&finishAddFlag="+data.finishAddFlag;
            }
        });
    }

    function resubmitSearch(page){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/orderDetail?orderId=${order.uuid}&page="+page;
    }

    function showMachineInfo(machinename,machinemodel,machineno,engineno,productiondate,price,remarks,machineId,versionno){
        $('#machinename').val(machinename);
        $('#machineno').val(machineno);
        $('#engineno').val(engineno);
        $('#productiondate').val(productiondate);
        $('#price').val(price);
        $('#remarks').val(remarks);
        $('#machineId').val(machineId);
        $('#versionno').val(versionno);
        var machinenoError = document.getElementById('machinenoError');
        machinenoError.innerHTML = "";
        $('#addMachine').click();
    }

    function addMachine(){
        if(${fn:length(machineList) >= order.quantity}){
            if(confirm('已达到订单数量，继续添加？')){
                openAddMachineModal();
            }
        }else{
            openAddMachineModal();
        }

    }

    function openAddMachineModal(){
        $('#machinename').val("");
        $('#machineno').val("");
        $('#engineno').val("");
        $('#productiondate').val("");
        $('#price').val("");
        $('#remarks').val("");
        $('#machineId').val("");
        $('#versionno').val("");
        var machinenoError = document.getElementById('machinenoError');
        machinenoError.innerHTML = "";
        $('#addMachine').click();
    }

    function addLogistics(){
        if('${fn:length(logisticsList) > 0}'){
            $('#driverphoneAdd').val("${logisticsList[0].driverphone}");
            $('#platenumberAdd').val("${logisticsList[0].platenumber}");
            $('#locationAdd').val("");
        }else{
            $('#driverphoneAdd').val("");
            $('#platenumberAdd').val("");
            $('#locationAdd').val("");
        }

        $('#addLogistics').click();
    }

    //订单添加物流
    function submitLogisticsInfo(){
        $("#addLogisticsFrm").parsley("validate");
        if($('#addLogisticsFrm').parsley().isValid() && validateContactno()){
            $('#submitAddLogisticsBtn').attr('disabled', true);
            $.ajax({
                cache: true,
                type: "POST",
                url:"${ctx}/admin/wefamily/addLogisticsForOrder?orderId=${order.uuid}",
                data:$('#addLogisticsFrm').serialize(),// 你的formid
                async: false,
                error: function(request) {
                    $('#submitAddLogisticsBtn').removeAttr('disabled');
                    qikoo.dialog.alert("系统忙，稍候再试");
                },
                success: function(data) {
                    $('#modelCloseBtnAdd').click();
                    window.location.href = "<%=request.getContextPath()%>/admin/wefamily/orderDetail?orderId=${order.uuid}&successMessage="+data.successMessage;
                }
            });
        }
    }

    function addReceipt(){
        if('${fn:length(receiptList) > 0}'){
            $('#receiptdtAdd').val("${receiptList[0].receiptdt}");
            $('#satisfactionAdd').val("${receiptList[0].satisfaction}");
            $('#questionAdd').val("${receiptList[0].question}");
            $('#receiptId').val("${receiptList[0].uuid}");
            $('#receiptVersionno').val("${receiptList[0].versionno}");
        }else{
            $('#receiptdtAdd').val("");
            $('#satisfactionAdd').val("");
            $('#questionAdd').val("");
        }

        $('#addReceipt').click();
    }

    //订单添加回执
    function submitReceiptInfo(){
        $("#addReceiptFrm").parsley("validate");
        if($('#addReceiptFrm').parsley().isValid() && validateContactno()){
            $('#submitAddReceiptBtn').attr('disabled', true);
            $.ajax({
                cache: true,
                type: "POST",
                url:"${ctx}/admin/wefamily/addReceiptForOrder?orderId=${order.uuid}",
                data:$('#addReceiptFrm').serialize(),// 你的formid
                async: false,
                error: function(request) {
                    $('#submitAddReceiptBtn').removeAttr('disabled');
                    qikoo.dialog.alert("系统忙，稍候再试");
                },
                success: function(data) {
                    $('#modelCloseBtnAddReceipt').click();
                    window.location.href = "<%=request.getContextPath()%>/admin/wefamily/orderDetail?orderId=${order.uuid}&successMessage="+data.successMessage;
                }
            });
        }
    }

    function finishOrder(){
        if(confirm('确定完成订单？')){
            //确定
            $.get("${ctx}/admin/wefamily/finishOrder?orderId=${order.uuid}&versionno=${order.versionno}&remarks="+$('#remarksForOrder').val(),function(data,status){
                if(undefined != data.finishFlag){
                    window.location.href = "<%=request.getContextPath()%>/admin/wefamily/orderDetail?orderId=${order.uuid}&finishFlag="+data.finishFlag;
                }
            });
        }
    }

    //验证联系号码
    function validateContactno(){
        document.getElementById("contactnoError").innerHTML = "";
        var phoneno = $('#driverphoneAdd').val();
        var rule = /^\d*-?\d*$/;
        if(!rule.test(phoneno) || phoneno.length > 11){
            document.getElementById("contactnoError").innerHTML = "输入非法";
            return false;
        }
        return true;
    }


</script>
</body>
</html>