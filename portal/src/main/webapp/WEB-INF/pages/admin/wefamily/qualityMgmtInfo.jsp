<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
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
        .panel-body .form-group .col-sm-9 {
            padding: 10px;
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
        .mod-dialog-bg {
            z-index: 1050;
        }
        .mod-dialog {
            z-index: 1051;
        }
    </style>
</head>
<body class="">
<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable padder">
            <div class="row" id="sugInfoDiv" style="overflow-x: hidden;overflow-y: auto;">
                <header class="panel-heading bg-white text-md b-b">
                    品质服务 /
                    <c:if test="${type eq 'REPAIR'}">
                        <a href="${ctx}/admin/wefamily/repairManage"><span class="font-bold text-shallowred">报修管理</span></a>
                    </c:if>
                    <c:if test="${type eq 'MAINTAIN'}">
                        <a href="${ctx}/admin/wefamily/maintainManage"><span class="font-bold text-shallowred">保养管理</span></a>
                    </c:if>

                </header>
                <div class="col-sm-12 pos">
                    <div id="myTabContent" class="tab-content">
                        <div class="tab-pane fade in active" id="detail">
                            <div style="margin-bottom: 5px;padding-left: 15px">
                                <span class="text-success">${saveSuccessMessage}</span>
                                <span class="text-success">${successMessage}</span>
                                <span class="text-danger">${errorMessage}</span>
                            </div>
                                <section class="panel panel-default" style="border-top:0">
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="tab_1">
                                            <div class="col-md-6">
                                                <!--详情-->
                                                <div class="portlet green box">
                                                        <div class="portlet-title">
                                                            <div class="caption"><i class="fa fa-cogs"></i>${showType}详情</div>
                                                        </div>
                                                        <div class="portlet-body">
                                                            <form class="form-horizontal form-bordered" data-validate="parsley"
                                                                  action="${ctx}/admin/wefamily/saveReportQualityMgmtInfo" method="POST"
                                                                  id="reportQualityMgmtInfoFrm" style="border: 0px">
                                                                <div class="panel-body p-0-15">
                                                                    <span id="machineError" class="text-danger"></span>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>用户：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control"  name="reportername" id="reportername"
                                                                                   value="${qualityMgmt.reportername}" data-required="true" onblur="trimText(this)"
                                                                                   placeholder="请输入用户姓名" data-maxlength="32"
                                                                            >
                                                                            <input type="hidden" name="uuid" value="${qualityMgmt.uuid}">
                                                                            <input type="hidden" name="versionno" value="${qualityMgmt.versionno}">
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>联系电话：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control"  name="reporterphone" id="reporterphone"
                                                                                   value="${qualityMgmt.reporterphone}" data-required="true" onblur="trimText(this),validateContactno('reporter')"
                                                                                   placeholder="请输入用户号码" data-maxlength="11"
                                                                            >
                                                                            <span id="reporterPhoneError" class="text-danger"></span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>机器型号：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <select class="form-control" name="machinemodel" id="machinemodel"
                                                                                    data-required="true">
                                                                                <c:if test="${fn:length(machineModelList) > 1}">
                                                                                    <option value="">请选择机器型号</option>
                                                                                </c:if>
                                                                                <c:forEach items="${machineModelList}" var="machineModel">
                                                                                    <option value="${machineModel}" <c:if test="${qualityMgmt.machinemodel == machineModel}">selected</c:if>>${machineModel}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>机器号：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <div class="" style="position: relative">
                                                                                <input type="text" class="form-control my-feetype-ul"  name="machineno" id="machineno"
                                                                                       value="${qualityMgmt.machineno}" data-required="true" onblur="trimText(this)"
                                                                                       placeholder="请输入机器号" data-maxlength="32"
                                                                                >
                                                                                <input type="hidden" name="machineid" id="machineid" value="${machine.uuid}">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>发动机号：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control"  name="engineno" id="engineno"
                                                                                   value="${qualityMgmt.engineno}" data-required="true" onblur="trimText(this)"
                                                                                   placeholder="请输入发动机号" data-maxlength="32"
                                                                            >
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label">生产日期：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                                                                   name="productiondt" value="${qualityMgmt.productiondt}" data-maxlength="23" onblur="trimText(this)"
                                                                                   data-date-format="yyyy-mm-dd" id="productiondt" placeholder="请选择生产日期">
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label">报修位置：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control"  name="reportlocation" id="reportlocation"
                                                                                   value="${qualityMgmt.reportlocation}" onblur="trimText(this)"
                                                                                   placeholder="请输入报修位置" data-maxlength="32"
                                                                            >
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>经销商：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <select class="form-control" name="merchantid" id="merchantid"
                                                                                    onchange="queryMerchantById()"
                                                                                    data-required="true"
                                                                            >
                                                                                <c:if test="${fn:length(merchantList) > 1}">
                                                                                    <option value="">请选择经销商</option>
                                                                                </c:if>
                                                                                <c:forEach items="${merchantList}" var="merchant">
                                                                                    <option value="${merchant.uuid}" <c:if test="${qualityMgmt.merchantid == merchant.uuid}">selected</c:if>>${merchant.name}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label">联系电话：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control" readonly id="merchantContactno"
                                                                                   onblur="trimText(this)" data-maxlength="32"
                                                                            >
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label">地址：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control" readonly id="merchantAddress"
                                                                                   data-maxlength="32"  onblur="trimText(this)"
                                                                            >
                                                                        </div>
                                                                    </div>
                                                                    <c:if test="${type eq 'REPAIR'}">
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3  control-label">问题描述：</label>
                                                                            <div class="col-sm-9 b-l bg-white">
                                                                                <textarea class="form-control" rows="4" name="content"
                                                                                          id="content" data-maxlength="256" onblur="trimText(this)"
                                                                                >${qualityMgmt.content}</textarea>
                                                                            </div>
                                                                        </div>
                                                                    </c:if>
                                                                    <c:if test="${fn:length(reporterAttachmentList) > 0}">
                                                                        <div class="form-group" >
                                                                            <label class="col-sm-3 control-label">报修照片：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <c:forEach items="${reporterAttachmentList}" var="attachment">
                                                                                    <img src="${attachment.name}" width="50" height="50"
                                                                                         onclick="viewBigImage(this)" data-toggle="modal" data-target=".bs-example-modal-lg-image"/>
                                                                                </c:forEach>
                                                                            </div>
                                                                        </div>
                                                                    </c:if>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3  control-label">备注：</label>
                                                                        <div class="col-sm-9 b-l bg-white">
                                                                                <textarea class="form-control" rows="4" name="remarks"
                                                                                          id="remarks" data-maxlength="256" onblur="trimText(this)"
                                                                                >${qualityMgmt.remarks}</textarea>
                                                                            <span id="remarksError" class="text-danger"></span>
                                                                        </div>
                                                                    </div>

                                                                    <div class="panel-footer text-left bg-light lter">
                                                                        <c:if test="${qualityMgmt.status ne 'FINISH'}">
                                                                            <a class="btn btn-primary btn-info" href="javascript:checkMachineInfo()" style="color: white;margin-left: 10px;margin-bottom: 10px">保存</a>
                                                                        </c:if>
                                                                        <c:if test="${type eq 'REPAIR' && qualityMgmt.status ne 'FINISH'}">
                                                                            <a class="btn btn-primary btn-info" href="javascript:closeQualityMgmt()" style="color: white;margin-left: 10px;margin-bottom: 10px">关闭报修</a>
                                                                        </c:if>
                                                                    </div>

                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>


                                            </div>

                                            <div class="col-md-6">
                                                <!--维修信息-->
                                                <c:if test="${not empty qualityMgmt.merchantid}">
                                                    <div class="portlet blue-hoki box">
                                                        <div class="portlet-title">
                                                            <div class="caption"><i class="fa fa-cogs"></i>
                                                                <c:if test="${type eq 'REPAIR'}">维修</c:if><c:if test="${type eq 'MAINTAIN'}">保养</c:if>信息
                                                            </div>
                                                        </div>
                                                        <div class="portlet-body">
                                                            <c:if test="${qualityMgmt.status eq 'REPAIRING' or qualityMgmt.status eq 'FINISH'}">
                                                                <form class="form-horizontal form-bordered" data-validate="parsley"
                                                                      action="${ctx}/admin/wefamily/saveQualityMgmtInfo" method="POST"
                                                                      id="qualityMgmtInfoFrm" style="border: 0px">
                                                                    <div class="panel-body p-0-15">
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label"><span class="text-danger">*</span><c:if test="${type eq 'REPAIR'}">维修</c:if><c:if test="${type eq 'MAINTAIN'}">保养</c:if>工人：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <select  class="form-control" name="workerId" id="workerId" data-required="true">
                                                                                    <option value="">请选择</option>
                                                                                    <c:forEach items="${workerUserList}" var="workerUser">
                                                                                            <option value="${workerUser.uuid}" <c:if test="${worker.userid == workerUser.uuid}">selected</c:if>>${workerUser.name}</option>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label"><c:if test="${type eq 'REPAIR'}">维修</c:if><c:if test="${type eq 'MAINTAIN'}">保养</c:if>日期：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                                                                       name="servicedt" value="${qualityMgmt.servicedt}" data-maxlength="23" onblur="trimText(this)"
                                                                                       data-date-format="yyyy-mm-dd" id="servicedt" placeholder="请选择维修日期">
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">现场地点：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input type="text" class="form-control"  name="location" id="location"
                                                                                       value="${qualityMgmt.location}" onblur="trimText(this)"
                                                                                       data-maxlength="32" readonly
                                                                                >
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">损坏项目：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input type="text" class="form-control"  name="program" id="program"
                                                                                       value="${qualityMgmt.program}" onblur="trimText(this)"
                                                                                       placeholder="请输入损坏项目" data-maxlength="32"
                                                                                >
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">处理配件：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input type="text" class="form-control"  name="parts" id="parts"
                                                                                       value="${qualityMgmt.parts}" onblur="trimText(this)"
                                                                                       placeholder="请输入处理配件" data-maxlength="32"
                                                                                >
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">已作业面积：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input type="text" class="form-control"  name="workarea" id="workarea"
                                                                                       value="${qualityMgmt.workarea}" onblur="trimText(this)"
                                                                                       placeholder="请输入已作业面积" data-maxlength="32"
                                                                                >
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">效果如何：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input type="text" class="form-control"  name="effect" id="effect"
                                                                                       value="${qualityMgmt.effect}" onblur="trimText(this)"
                                                                                       placeholder="请输入效果" data-maxlength="32"
                                                                                >
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group" >
                                                                            <label class="col-sm-3 control-label">损坏分类：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <select  class="form-control" name="damagecategory" id="damagecategory">
                                                                                    <c:set var="commonCodeList" value="${web:queryCommonCodeList('DAMAGE_CATEGORY')}"></c:set>
                                                                                    <option value="">--请选择--</option>
                                                                                    <c:forEach items="${commonCodeList}" var="commonCode">
                                                                                        <option value="${commonCode.code}" <c:if test="${qualityMgmt.damagecategory == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">到达所用时间：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input type="text" class="form-control"  name="arrivetime" id="arrivetime"
                                                                                       value="${qualityMgmt.arrivetime}" onblur="trimText(this)"
                                                                                       placeholder="请输入到达所用时间" data-maxlength="32"
                                                                                >
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">
                                                                                <c:if test="${type eq 'REPAIR'}">维修</c:if><c:if test="${type eq 'MAINTAIN'}">保养</c:if>金额：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                    <input class="form-control myFee" size="4"
                                                                                           name="price"
                                                                                           value="${qualityMgmt.price}" id="price"
                                                                                           data-maxlength="10"
                                                                                           onblur="validateMoney(this,'priceError')"
                                                                                    >
                                                                                    <span id="priceError" class="text-danger"></span>
                                                                            </div>
                                                                        </div>
                                                                        <c:if test="${qualityMgmt.status ne 'FINISH'}">
                                                                            <div class="form-group" >
                                                                                <label class="col-sm-3 control-label">上传人机合影：</label>
                                                                                <div class="col-sm-9  b-l bg-white">
                                                                                    <div class="my-display-inline-box">
                                                                                        <div id="qualityMgmtImgUrlContainer">
                                                                                            <input type="file" id="qualityMgmtImg" name="picUrl" class="filestyle"
                                                                                                   data-icon="false" data-classButton="btn btn-default"
                                                                                                   data-classInput="form-control inline v-middle input-xs"
                                                                                                   onchange="compressUploadPicture(this)" accept="image/*"
                                                                                                <%--data-max_size="2000000" --%>
                                                                                                   style="display: none"
                                                                                                   data-max-count="4">
                                                                                            <div id="picUrlError" class="text-danger"></div>
                                                                                        </div>
                                                                                        <div id="qualityMgmtImgContainer" class="row value">
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </c:if>
                                                                        <c:if test="${fn:length(workerAttachmentList) > 0}">
                                                                            <div class="form-group" >
                                                                                <label class="col-sm-3 control-label"></label>
                                                                                <div class="col-sm-9  b-l bg-white">
                                                                                    <c:forEach items="${workerAttachmentList}" var="attachment">
                                                                                        <img src="${attachment.name}" width="50" height="50"
                                                                                             onclick="viewBigImage(this)" data-toggle="modal" data-target=".bs-example-modal-lg-image"/>
                                                                                    </c:forEach>
                                                                                </div>
                                                                            </div>
                                                                        </c:if>
                                                                    </div>
                                                                </form>
                                                            </c:if>

                                                            <c:if test="${empty qualityMgmt.status or qualityMgmt.status eq 'NEW'}">
                                                                <div class="row static-info">
                                                                    <div class="col-md-12 col-xs-12 value">
                                                                        <span>暂无<c:if test="${type eq 'qualityMgmt'}">维修</c:if><c:if test="${type eq 'MAINTAIN'}">保养</c:if>信息</span>
                                                                    </div>
                                                                </div>
                                                                <c:if test="${not empty qualityMgmt.status && empty worker}">
                                                                    <button class="btn btn-sm" data-toggle="modal" data-target=".bs-example-modal-tj-worker" style="color: #fff;margin-left: 10px;margin-bottom: 10px;background-color: #67809F">派工</button>
                                                                </c:if>
                                                            </c:if>
                                                            <div class="panel-footer text-left bg-light lter">
                                                                <c:if test="${qualityMgmt.status eq 'REPAIRING'}">
                                                                    <a class="btn btn-sm" href="javascript:saveQualityMgmtInfo('SAVE')" style="color: #fff;margin-left: 10px;margin-bottom: 10px;background-color: #67809F">
                                                                        保存<c:if test="${type eq 'REPAIR'}">维修</c:if><c:if test="${type eq 'MAINTAIN'}">保养</c:if>信息
                                                                    </a>
                                                                    <a class="btn btn-sm" href="javascript:saveQualityMgmtInfo('FINISH')" style="color: #fff;margin-left: 10px;margin-bottom: 10px;background-color: #67809F">
                                                                        <i class="fa fa-check"></i> <c:if test="${type eq 'REPAIR'}">维修</c:if><c:if test="${type eq 'MAINTAIN'}">保养</c:if>结束
                                                                    </a>
                                                                </c:if>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </c:if>
                                                <c:if test="${qualityMgmt.status eq 'FINISH'}">
                                                    <form class="form-horizontal form-bordered" data-validate="parsley"
                                                          action="${ctx}/admin/wefamily/saveQualityMgmtPraiseInfo" method="POST" id="praiseInfoFrm">
                                                        <section class="panel panel-default">
                                                            <header class="panel-heading mintgreen">
                                                                <i class="fa fa-gift"></i>
                                                                <span class="text-lg">奖励信息：</span>
                                                            </header>
                                                            <div class="panel-body p-0-15">
                                                                <div class="form-group" >
                                                                    <label class="col-sm-3 control-label">用户评价：</label>
                                                                    <div class="col-sm-9  b-l bg-white">
                                                                        <select  class="form-control" name="evaluate" id="evaluate" <c:if test="${not empty qualityMgmt.evaluate}">disabled</c:if>>
                                                                            <c:set var="commonCodeList" value="${web:queryCommonCodeList('REPAIR_EVALUATE')}"></c:set>
                                                                            <option value="">请选择</option>
                                                                            <c:forEach items="${commonCodeList}" var="commonCode">
                                                                                <option value="${commonCode.code}" <c:if test="${qualityMgmt.evaluate == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3  control-label">评价备注：</label>
                                                                    <div class="col-sm-9 b-l bg-white">
                                                                        <textarea class="form-control" rows="3" name="evaluateremarks" <c:if test="${not empty qualityMgmt.evaluate}">readonly</c:if>
                                                                                  id="evaluateremarks" data-maxlength="256" onblur="trimText(this)"
                                                                        >${qualityMgmt.evaluateremarks}</textarea>
                                                                    </div>
                                                                </div>

                                                                <div class="form-group" >
                                                                    <label class="col-sm-3 control-label">奖励状态：</label>
                                                                    <div class="col-sm-9  b-l bg-white">
                                                                        <select  class="form-control" name="praisestatus" id="praisestatus">
                                                                            <c:set var="commonCodeList" value="${web:queryCommonCodeList('PRAISE_STATUS')}"></c:set>
                                                                            <option value="">请选择</option>
                                                                            <c:forEach items="${commonCodeList}" var="commonCode">
                                                                                <option value="${commonCode.code}" <c:if test="${qualityMgmt.praisestatus == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3  control-label">备注：</label>
                                                                    <div class="col-sm-9 b-l bg-white">
                                                                        <textarea class="form-control" rows="3" name="praiseremarks"
                                                                                  id="praiseremarks" data-maxlength="256" onblur="trimText(this)"
                                                                        >${qualityMgmt.praiseremarks}</textarea>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="col-sm-12">
                                                                        <input type="hidden" name="uuid" class="form-control" value="${qualityMgmt.uuid}">
                                                                        <input type="hidden" name="versionno" class="form-control" value="${qualityMgmt.versionno}">
                                                                    </div>
                                                                </div>

                                                            </div>
                                                            <div class="panel-footer text-left bg-light lter">
                                                                <c:if test="${qualityMgmt.status eq 'FINISH'}">
                                                                    <a class="btn btn-submit btn-s-xs " href="javascript:saveQualityMgmtPraiseInfo()">
                                                                        &nbsp;保&nbsp;存
                                                                    </a>
                                                                </c:if>
                                                            </div>
                                                        </section>
                                                    </form>
                                                </c:if>

                                            </div>
                                        </div>
                                    </div>
                                </section>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3"></div>
            </div>


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

            <!-- 工人modal添加 -->
            <div class="modal fade bs-example-modal-tj-worker" tabindex="-1" role="dialog"
                 aria-labelledby="myLargeModalLabelTj" aria-hidden="false">
                <div class="modal-dialog modal-lg" style="margin-top: 15%">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" id="modelCloseBtnAddWorker"><span
                                    aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title" id="myLargeModalLabelAddWorker">指派工人</h4>
                        </div>
                        <form action="${ctx}/admin/wefamily/addWorkerForQualityMgmt" method="POST" id="addWorkerFrm" data-validate="parsley">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="portlet green box">
                                            <div class="portlet-title">
                                                <div class="caption"><i class="fa fa-cogs"></i>工人信息</div>
                                            </div>
                                            <div class="portlet-body">
                                                <div class="row static-info">
                                                    <div class="col-md-3 col-xs-4 name" style="margin-top: 7px;text-align: left">工人姓名:<span class="text-danger">*</span></div>
                                                    <div class="col-md-9 col-xs-12 value">
                                                        <div class="my-display-inline-box">
                                                            <select  class="form-control" name="workerId" id="workerId" data-required="true">
                                                                <option value="">请选择</option>
                                                                <c:forEach items="${workerUserList}" var="workerUser">
                                                                    <option value="${workerUser.uuid}" <c:if test="${worker.userid == workerUser.uuid}">selected</c:if>>${workerUser.name}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer" style="text-align: center;border: 0;margin: 0;padding: 0 20px 20px 20px;">
                                    <a href="javascript:submitWorkerInfo()"
                                       class="btn btn-submit btn-s-md a-noline" style="color: #fff"
                                       id="submitAddWorkerBtn"
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
            showParentMenu('品质服务');
        }

        queryMerchantById();
    }

    function saveQualityMgmtPraiseInfo(){
        var searchForm = document.getElementById("praiseInfoFrm")
        searchForm.action = "${ctx}/admin/wefamily/saveQualityMgmtPraiseInfo?type=${type}"
        searchForm.submit();
    }


    //根据id查询经销商
    function queryMerchantById(){
        initMerchantInfo();
        var merchantId = $('#merchantid').val();
        if(merchantId.length > 0){
            $.get("${ctx}/admin/wefamily/queryMerchantById?merchantId="+merchantId+"&version="+Math.random(),function(data,status){
                if(undefined != data.merchant){
                    $('#merchantContactno').val(data.merchant.contactno);
                    $('#merchantAddress').val(data.merchant.address);
                }
            });
        }
    }

    function initMerchantInfo(){
        $('#merchantContactno').val("");
        $('#merchantAddress').val("");
    }

    //派工
    function submitWorkerInfo(){
        $("#addWorkerFrm").parsley("validate");
        if($('#addWorkerFrm').parsley().isValid()){
            $('#submitAddWorkerBtn').attr('disabled', true);
            $.ajax({
                cache: true,
                type: "POST",
                url:"${ctx}/admin/wefamily/addWorkerForQualityMgmt?qualityMgmtId=${qualityMgmt.uuid}&versionno=${qualityMgmt.versionno}",
                data:$('#addWorkerFrm').serialize(),// 你的formid
                async: false,
                error: function(request) {
                    $('#submitAddWorkerBtn').removeAttr('disabled');
                    qikoo.dialog.alert("系统忙，稍候再试");
                },
                success: function(data) {
                    $('#modelCloseBtnAdd').click();
                    window.location.href = "<%=request.getContextPath()%>/admin/wefamily/qualityMgmtInfo?qualityMgmtId=${qualityMgmt.uuid}&type=${type}&successMessage="+data.successMessage;
                }
            });
        }
    }

    function checkMachineInfo(){
        var machinemodel = $('#machinemodel').val();
        var machineno = $('#machineno').val();
        var engineno = $('#engineno').val();

        var url = "${ctx}/admin/wefamily/checkMachineIfexist?machinemodel="+machinemodel+"&machineno="+machineno+"&engineno="+engineno;
        $.get(url,function(data,status){
            if(data.existFlag == 'N'){
                qikoo.dialog.confirm('机器信息不存在，确定保存？',function(){
                    //确定
                  saveReportQualityMgmtInfo();
                },function(){
                    //取消
                });
            }else{
                saveReportQualityMgmtInfo();
            }
        });
    }

    function saveReportQualityMgmtInfo(){
        var machineError = document.getElementById('machineError');
        machineError.innerHTML = "";
        $("#reportQualityMgmtInfoFrm").parsley("validate");
        if($('#reportQualityMgmtInfoFrm').parsley().isValid()){
            $.ajax({
                cache: true,
                type: "POST",
                url:"${ctx}/admin/wefamily/saveReportQualityMgmtInfo?type=${type}",
                data:$('#reportQualityMgmtInfoFrm').serialize(),// 你的formid
                async: false,
                error: function(request) {
                    qikoo.dialog.alert("系统忙，稍候再试");
                },
                success: function(data) {
                    if(undefined != data.returnMsg){
                        machineError.innerHTML = data.returnMsg;
                    }else{
                        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/qualityMgmtInfo?qualityMgmtId="+data.qualityMgmtId+"&successMessage="+data.successMessage+"&type=${type}";
                    }
                }
            });
        }
    }

    function saveQualityMgmtInfo(saveType){
        $("#qualityMgmtInfoFrm").parsley("validate");
        if($('#qualityMgmtInfoFrm').parsley().isValid()){
            $.ajax({
                cache: true,
                type: "POST",
                url:"${ctx}/admin/wefamily/saveQualityMgmtInfo?qualityMgmtId=${qualityMgmt.uuid}&qualityMgmtVersionno=${qualityMgmt.versionno}&saveType="+saveType,
                data:$('#qualityMgmtInfoFrm').serialize(),// 你的formid
                async: false,
                error: function(request) {
                    qikoo.dialog.alert("系统忙，稍候再试");
                },
                success: function(data) {
                    if(undefined != data.returnMsg){

                    }else{
                        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/qualityMgmtInfo?qualityMgmtId=${qualityMgmt.uuid}&successMessage="+data.successMessage+"&type=${type}";
                    }
                }
            });
        }
    }

    function startQualityMgmt(){
        $.get("${ctx}/admin/wefamily/startQualityMgmt?qualityMgmtId=${qualityMgmt.uuid}&versionno=${qualityMgmt.versionno}",function(data,status){
            if(undefined != data.startFlag){
                window.location.href = "<%=request.getContextPath()%>/admin/wefamily/qualityMgmtInfo?qualityMgmtId=${qualityMgmt.uuid}"+"&type=${type}";
            }
        });
    }

    function closeQualityMgmt(){
        var remarksError = document.getElementById('remarksError');
        remarksError.innerHTML = "";
        var remarks=document.getElementById("remarks").value;
        if(null == remarks || remarks == ""){
            remarksError.innerHTML = "此项关闭时必填";
        }else{
            $("#reportQualityMgmtInfoFrm").parsley("validate");
            if($('#reportQualityMgmtInfoFrm').parsley().isValid() && validateContactno('reporter')){
                qikoo.dialog.confirm('确定关闭维修？',function(){
                    //确定
                    $.get("${ctx}/admin/wefamily/finishQualityMgmt?qualityMgmtId=${qualityMgmt.uuid}&versionno=${qualityMgmt.versionno}&remarks="+remarks,function(data,status){
                        if(undefined != data.finishFlag){
                            window.location.href = "<%=request.getContextPath()%>/admin/wefamily/qualityMgmtInfo?qualityMgmtId=${qualityMgmt.uuid}&finishFlag="+data.finishFlag+"&type=${type}";
                        }
                    });
                },function(){
                    //取消
                });
            }
        }
    }


    //验证联系号码
    function validateContactno(type){
        if(type == 'reporter'){
            var phoneno = $('#reporterphone').val();
            document.getElementById("reporterPhoneError").innerHTML = "";
        }
        var rule = /^\d*-?\d*$/;
        if(!rule.test(phoneno) || phoneno.length > 11){
            if(type == 'reporter'){
                document.getElementById("reporterPhoneError").innerHTML = "号码格式不正确";
            }
            return false;
        }
        return true;
    }



</script>
</body>
</html>