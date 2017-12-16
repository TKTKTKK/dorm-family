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
    </style>
</head>
<body class="">
<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable padder">
            <div class="row" id="sugInfoDiv" style="overflow-x: hidden;overflow-y: auto;">
                <header class="panel-heading bg-white text-md b-b">
                    满田星 /
                    <a href="${ctx}/admin/wefamily/repairManage"><span class="font-bold text-shallowred">报修管理</span></a>
                </header>
                <div class="col-sm-12 pos">
                    <div id="myTabContent" class="tab-content">
                        <div class="tab-pane fade in active" id="detail">
                            <div class="b-l b-r">
                                <span class="text-success">${successMessage}</span>
                                <span class="text-danger">${errorMessage}</span>
                            </div>
                                <section class="panel panel-default" style="border-top:0">
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="tab_1">
                                            <div class="col-md-6">
                                                <!--报修详情-->
                                                <div class="portlet green box">
                                                        <div class="portlet-title">
                                                            <div class="caption"><i class="fa fa-cogs"></i>报修详情</div>
                                                        </div>
                                                        <div class="portlet-body">
                                                            <form class="form-horizontal form-bordered" data-validate="parsley"
                                                                  action="${ctx}/admin/wefamily/saveReportRepairInfo" method="POST"
                                                                  enctype="multipart/form-data" id="reportRepairInfoFrm" style="border: 0px">
                                                                <div class="panel-body p-0-15">
                                                                    <span id="machineError" class="text-danger"></span>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>报修人：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control"  name="reportername" id="reportername"
                                                                                   value="${repair.reportername}" data-required="true" onblur="trimText(this)"
                                                                                   placeholder="请输入报修人姓名" data-maxlength="32"
                                                                            >
                                                                            <input type="hidden" name="uuid" value="${repair.uuid}">
                                                                            <input type="hidden" name="versionno" value="${repair.versionno}">
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>联系电话：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control"  name="reporterphone" id="reporterphone"
                                                                                   value="${repair.reporterphone}" data-required="true" onblur="trimText(this),validateContactno('reporter')"
                                                                                   placeholder="请输入报修人号码" data-maxlength="11"
                                                                            >
                                                                            <span id="reporterPhoneError" class="text-danger"></span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>机器型号：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control"  name="machinemodel" id="machinemodel"
                                                                                   value="${repair.machinemodel}" data-required="true" onblur="trimText(this)"
                                                                                   placeholder="请输入机器型号" data-maxlength="32"
                                                                            >
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>机器号：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <div class="" style="position: relative">
                                                                                <input type="text" class="form-control my-feetype-ul"  name="machineno" id="machineno"
                                                                                       value="${repair.machineno}" data-required="true" onblur="trimText(this)"
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
                                                                                   value="${repair.engineno}" data-required="true" onblur="trimText(this)"
                                                                                   placeholder="请输入发动机号" data-maxlength="32"
                                                                            >
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>生产日期：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                                                                   name="productiondt" value="${repair.productiondt}" data-maxlength="23" onblur="trimText(this)"
                                                                                   data-date-format="yyyy-mm-dd" id="productiondt" placeholder="请选择生产日期" data-required="true">
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>经销商：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control" readonly
                                                                                   value="${merchant.name}" data-required="true"
                                                                                   data-maxlength="32"
                                                                            >
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>联系电话：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control" readonly
                                                                                   value="${merchant.contactno}" data-required="true" onblur="trimText(this)"
                                                                                   data-maxlength="32"
                                                                            >
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>地址：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control" readonly
                                                                                   value="${merchant.address}" data-required="true"
                                                                                   data-maxlength="32"
                                                                            >
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3  control-label">问题描述：</label>
                                                                        <div class="col-sm-9 b-l bg-white">
                                                                                <textarea class="form-control" rows="4" name="content"
                                                                                          id="content" data-maxlength="256" onblur="trimText(this)"
                                                                                >${repair.content}</textarea>
                                                                        </div>
                                                                    </div>
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
                                                                                >${repair.remarks}</textarea>
                                                                            <span id="remarksError" class="text-danger"></span>
                                                                        </div>
                                                                    </div>

                                                                    <div class="panel-footer text-left bg-light lter">
                                                                        <a class="btn btn-primary btn-info" href="javascript:saveReportRepairInfo()" style="color: white;margin-left: 10px;margin-bottom: 10px">保存</a>
                                                                        <a class="btn btn-primary btn-info" href="javascript:distributeRepair()" style="color: white;margin-left: 10px;margin-bottom: 10px">分配报修</a>
                                                                        <a class="btn btn-primary btn-info" href="javascript:closeRepair()" style="color: white;margin-left: 10px;margin-bottom: 10px">关闭报修</a>
                                                                    </div>

                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>


                                            </div>

                                            <div class="col-md-6">
                                                <!--维修信息-->
                                                <c:if test="${order.status ne 'NEW'}">
                                                    <div class="portlet blue-hoki box">
                                                        <div class="portlet-title">
                                                            <div class="caption"><i class="fa fa-cogs"></i>维修信息</div>
                                                        </div>
                                                        <div class="portlet-body">
                                                            <c:if test="${repair.status eq 'REPAIRING' or repair.status eq 'FINISH'}">
                                                                <form class="form-horizontal form-bordered" data-validate="parsley"
                                                                      action="${ctx}/admin/wefamily/saveRepairInfo" method="POST"
                                                                      enctype="multipart/form-data" id="repairInfoFrm" style="border: 0px">
                                                                    <div class="panel-body p-0-15">
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label"><span class="text-danger">*</span>维修人员：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <select  class="form-control" name="workerId" id="workerId" data-required="true">
                                                                                    <c:if test="${fn:length(repairWorkerList) > 1}">
                                                                                        <option value="">请选择</option>
                                                                                    </c:if>
                                                                                    <c:forEach items="${repairWorkerList}" var="repairWorker">
                                                                                            <option value="${repairWorker.uuid}" <c:if test="${repairWorker.uuid == workerUser.uuid}">selected</c:if>>${repairWorker.name}</option>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">维修日期：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                                                                       name="repairdt" value="${repair.repairdt}" data-maxlength="23" onblur="trimText(this)"
                                                                                       data-date-format="yyyy-mm-dd" id="repairdt" placeholder="请选择维修日期">
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">现场地点：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input type="text" class="form-control"  name="location" id="location"
                                                                                       value="${repair.location}" onblur="trimText(this)"
                                                                                       data-maxlength="32" readonly
                                                                                >
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">损坏项目：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input type="text" class="form-control"  name="program" id="program"
                                                                                       value="${repair.program}" onblur="trimText(this)"
                                                                                       placeholder="请输入损坏项目" data-maxlength="32"
                                                                                >
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">处理配件：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input type="text" class="form-control"  name="parts" id="parts"
                                                                                       value="${repair.parts}" onblur="trimText(this)"
                                                                                       placeholder="请输入处理配件" data-maxlength="32"
                                                                                >
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">已作业面积：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input type="text" class="form-control"  name="workarea" id="workarea"
                                                                                       value="${repair.workarea}" onblur="trimText(this)"
                                                                                       placeholder="请输入已作业面积" data-maxlength="32"
                                                                                >
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">效果如何：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input type="text" class="form-control"  name="effect" id="effect"
                                                                                       value="${repair.effect}" onblur="trimText(this)"
                                                                                       placeholder="请输入效果" data-maxlength="32"
                                                                                >
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group" >
                                                                            <label class="col-sm-3 control-label"><span class="text-danger">*</span>损坏分类：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <select  class="form-control" name="damagecategory" id="damagecategory"
                                                                                         data-required="true">
                                                                                    <c:set var="commonCodeList" value="${web:queryCommonCodeList('DAMAGE_CATEGORY')}"></c:set>
                                                                                    <option value="">--请选择--</option>
                                                                                    <c:forEach items="${commonCodeList}" var="commonCode">
                                                                                        <option value="${commonCode.code}" <c:if test="${repair.damagecategory == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">到达所用时间：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input type="text" class="form-control"  name="arrivetime" id="arrivetime"
                                                                                       value="${repair.arrivetime}" onblur="trimText(this)"
                                                                                       placeholder="请输入到达所用时间" data-maxlength="32"
                                                                                >
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label"><span class="text-danger">*</span>维修金额：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                    <input class="form-control myFee" size="4"
                                                                                           data-required="true"
                                                                                           name="price"
                                                                                           value="${repair.price}" id="price"
                                                                                           data-maxlength="10"
                                                                                           onblur="validateMoney(this,'priceError')"
                                                                                    >
                                                                                    <span id="priceError" class="text-danger"></span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group" >
                                                                            <label class="col-sm-3 control-label">用户评价：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <select  class="form-control" name="evaluate" id="evaluate">
                                                                                    <c:set var="commonCodeList" value="${web:queryCommonCodeList('REPAIR_EVALUATE')}"></c:set>
                                                                                    <option value="">--请选择--</option>
                                                                                    <c:forEach items="${commonCodeList}" var="commonCode">
                                                                                        <option value="${commonCode.code}" <c:if test="${repair.evaluate == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <c:if test="${repair.status ne 'FINISH'}">
                                                                            <div class="form-group" >
                                                                                <label class="col-sm-3 control-label">上传照片：</label>
                                                                                <div class="col-sm-9  b-l bg-white">
                                                                                    <div class="my-display-inline-box">
                                                                                        <div id="repairImgUrlContainer">
                                                                                            <input type="file" id="repairImg" name="picUrl" class="filestyle"
                                                                                                   data-icon="false" data-classButton="btn btn-default"
                                                                                                   data-classInput="form-control inline v-middle input-xs"
                                                                                                   onchange="compressUploadPicture(this)" accept="image/*"
                                                                                                <%--data-max_size="2000000" --%>
                                                                                                   style="display: none"
                                                                                                   data-max-count="4">
                                                                                            <div id="picUrlError" class="text-danger"></div>
                                                                                        </div>
                                                                                        <div id="repairImgContainer" class="row value">
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </c:if>
                                                                        <c:if test="${fn:length(workerAttachmentList) > 0}">
                                                                            <div class="form-group" >
                                                                                <label class="col-sm-3 control-label">维修照片：</label>
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

                                                            <c:if test="${empty repair.status or repair.status eq 'NEW' or repair.status eq 'DISTRIBUTED'}">
                                                                <div class="row static-info">
                                                                    <div class="col-md-12 col-xs-12 value">
                                                                        <span>暂无维修信息</span>
                                                                    </div>
                                                                </div>
                                                                <c:if test="${repair.status eq 'DISTRIBUTED'}">
                                                                    <a class="btn btn-sm" href="javascript:startRepair()" style="color: #fff;margin-left: 10px;margin-bottom: 10px;background-color: #67809F">
                                                                        开始维修
                                                                    </a>
                                                                </c:if>
                                                            </c:if>
                                                            <div class="panel-footer text-left bg-light lter">
                                                                <c:if test="${repair.status eq 'REPAIRING'}">
                                                                    <a class="btn btn-sm" href="javascript:saveRepairInfo('SAVE')" style="color: #fff;margin-left: 10px;margin-bottom: 10px;background-color: #67809F">
                                                                        保存维修信息
                                                                    </a>
                                                                    <a class="btn btn-sm" href="javascript:saveRepairInfo('FINISH')" style="color: #fff;margin-left: 10px;margin-bottom: 10px;background-color: #67809F">
                                                                        <i class="fa fa-check"></i> 维修结束
                                                                    </a>
                                                                </c:if>
                                                            </div>

                                                        </div>
                                                    </div>
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
    }

    function saveReportRepairInfo(){
        var machineError = document.getElementById('machineError');
        machineError.innerHTML = "";
        $("#reportRepairInfoFrm").parsley("validate");
        if($('#reportRepairInfoFrm').parsley().isValid()){
            $.ajax({
                cache: true,
                type: "POST",
                url:"${ctx}/admin/wefamily/saveReportRepairInfo",
                data:$('#reportRepairInfoFrm').serialize(),// 你的formid
                async: false,
                error: function(request) {
                    qikoo.dialog.alert("系统忙，稍候再试");
                },
                success: function(data) {
                    if(undefined != data.returnMsg){
                        machineError.innerHTML = data.returnMsg;
                    }else{
                        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/repairInfo?repairId="+data.repairId+"&successMessage="+data.successMessage;
                    }
                }
            });
        }
    }

    function saveRepairInfo(saveType){
        $("#repairInfoFrm").parsley("validate");
        if($('#repairInfoFrm').parsley().isValid()){
            $.ajax({
                cache: true,
                type: "POST",
                url:"${ctx}/admin/wefamily/saveRepairInfo?repairId=${repair.uuid}&versionno=${repair.versionno}&saveType="+saveType,
                data:$('#repairInfoFrm').serialize(),// 你的formid
                async: false,
                error: function(request) {
                    qikoo.dialog.alert("系统忙，稍候再试");
                },
                success: function(data) {
                    if(undefined != data.returnMsg){

                    }else{
                        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/repairInfo?repairId=${repair.uuid}&successMessage="+data.successMessage;
                    }
                }
            });
        }
    }

    function distributeRepair(){
        $.get("${ctx}/admin/wefamily/distributeRepair?repairId=${repair.uuid}&merchantId=${merchant.uuid}&versionno=${repair.versionno}",function(data,status){
            if(undefined != data.distributeFlag){
                window.location.href = "<%=request.getContextPath()%>/admin/wefamily/repairInfo?repairId=${repair.uuid}&distributeFlag="+data.distributeFlag;
            }
        });
    }

    function startRepair(){
        $.get("${ctx}/admin/wefamily/startRepair?repairId=${repair.uuid}&versionno=${repair.versionno}",function(data,status){
            if(undefined != data.startFlag){
                window.location.href = "<%=request.getContextPath()%>/admin/wefamily/repairInfo?repairId=${repair.uuid}";
            }
        });
    }

    function finishRepair(){
        $("#repairInfoFrm").parsley("validate");
        if($('#repairInfoFrm').parsley().isValid() && validateContactno()){
            if(confirm('确定完成维修？')){
                //确定
                $.get("${ctx}/admin/wefamily/finishRepair?repairId=${repair.uuid}&versionno=${repair.versionno}",function(data,status){
                    if(undefined != data.finishFlag){
                        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/repairInfo?repairId=${repair.uuid}&finishFlag="+data.finishFlag;
                    }
                });
            }
        }
    }

    function closeRepair(){
        var remarksError = document.getElementById('remarksError');
        remarksError.innerHTML = "";
        var remarks=document.getElementById("remarks").value;
        if(null == remarks || remarks == ""){
            remarksError.innerHTML = "此项关闭时必填";
        }else{
            $("#reportRepairInfoFrm").parsley("validate");
            if($('#reportRepairInfoFrm').parsley().isValid() && validateContactno()){
                if(confirm('确定关闭维修？')){
                    //确定
                    $.get("${ctx}/admin/wefamily/finishRepair?repairId=${repair.uuid}&versionno=${repair.versionno}",function(data,status){
                        if(undefined != data.finishFlag){
                            window.location.href = "<%=request.getContextPath()%>/admin/wefamily/repairInfo?repairId=${repair.uuid}&finishFlag="+data.finishFlag;
                        }
                    });
                }
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