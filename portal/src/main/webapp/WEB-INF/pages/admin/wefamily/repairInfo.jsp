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

        #repairImgContainer{display: inline-block;vertical-align: middle}
        #repairImgUrlContainer{display: inline-block;vertical-align: middle;margin-left: 0rem}
        #repairImgContainer img{width: 5rem;height: 5rem;margin:1rem}
        #workerImgContainer{display: inline-block;vertical-align: middle}
        #workerImgUrlContainer{display: inline-block;vertical-align: middle;margin-left: 0rem}
        #workerImgContainer img{width: 5rem;height: 5rem;margin:1rem}
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
                    宿舍服务 / <a href="${ctx}/admin/wefamily/repairManage"><span class="font-bold text-shallowred">报修管理</span></a>


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
                                                            <div class="caption"><i class="fa fa-cogs"></i>报修详情</div>
                                                        </div>
                                                        <div class="portlet-body">
                                                            <form class="form-horizontal form-bordered" data-validate="parsley"
                                                                  action="${ctx}/admin/wefamily/saveReportRepairInfo" method="POST"
                                                                  id="reportRepairInfoFrm" style="border: 0px">
                                                                <div class="panel-body p-0-15">
                                                                    <span id="machineError" class="text-danger"></span>

                                                                    <div class="form-group" >
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>报修类型：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <select  class="form-control" name="type" id="type"
                                                                                     data-required="true" onchange="judgeRepairType()">
                                                                                <c:set var="commonCodeList" value="${web:queryCommonCodeList('REPAIR_TYPE')}"></c:set>
                                                                                <c:forEach items="${commonCodeList}" var="commonCode">
                                                                                    <option value="${commonCode.code}" <c:if test="${repair.type == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>宿舍楼：</label>
                                                                        <div class="col-sm-9 b-l bg-white">
                                                                            <select class="form-control" id="dormitoryid" name="dormitoryid" onchange="getLayerList()" data-required="true">
                                                                                <c:if test="${fn:length(dormitoryList) > 1}">
                                                                                    <option value="">宿舍楼</option>
                                                                                </c:if>
                                                                                <c:forEach items="${dormitoryList}" var="dormitory">
                                                                                    <option value="${dormitory.uuid}" <c:if test="${repair.dormitoryid == dormitory.uuid}">selected="selected"</c:if>>${dormitory.name}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>
                                                                            楼层（单元）：
                                                                        </label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <select class="form-control" name="layer" onchange="getRoomnoList()" data-required="true">
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>
                                                                            房间号：
                                                                        </label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <select class="form-control" name="roomno" data-required="true">
                                                                                <option value="${repair.roomno}" selected>${repair.roomno}</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group" id="stunoDiv">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>学号：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control"  name="reporterstuno" id="reporterstuno"
                                                                                   value="${repair.reporterstuno}" onblur="trimText(this)"
                                                                                   placeholder="请输入学号" data-maxlength="32"
                                                                            >
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>姓名：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control"  name="reportername" id="reportername"
                                                                                   value="${repair.reportername}" data-required="true" onblur="trimText(this)"
                                                                                   placeholder="请输入姓名" data-maxlength="32"
                                                                            >
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>联系电话：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input type="text" class="form-control"  name="reporterphone" id="reporterphone"
                                                                                   value="${repair.reporterphone}" data-required="true" onblur="trimText(this),validateContactno('reporter')"
                                                                                   placeholder="请输入用户号码" data-maxlength="11"
                                                                            >
                                                                            <span id="reporterPhoneError" class="text-danger"></span>
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

                                                                    <div class="form-group">
                                                                        <label class="col-sm-3 control-label">预约日期：</label>
                                                                        <div class="col-sm-9  b-l bg-white">
                                                                            <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                                                                   name="servicedt" value="${repair.servicedt}" data-maxlength="23" onblur="trimText(this)"
                                                                                   data-date-format="yyyy-mm-dd" id="servicedt" placeholder="预约日期">
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group" >
                                                                        <label class="col-sm-3 control-label">损坏图片：</label>
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

                                                                    <div class="panel-footer text-left bg-light lter">
                                                                        <c:if test="${repair.status ne 'FINISH'}">
                                                                            <a class="btn btn-primary btn-info" href="javascript:saveReportRepairInfo()" style="color: white;margin-left: 10px;margin-bottom: 10px">保存</a>
                                                                            <c:if test="${not empty repair.uuid}">
                                                                                <a class="btn btn-primary btn-info" href="javascript:closeQualityMgmt()" style="color: white;margin-left: 10px;margin-bottom: 10px">关闭报修</a>
                                                                            </c:if>
                                                                        </c:if>
                                                                    </div>

                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>


                                            </div>

                                            <div class="col-md-6">
                                                <!--维修信息-->
                                                    <div class="portlet blue-hoki box">
                                                        <div class="portlet-title">
                                                            <div class="caption"><i class="fa fa-cogs"></i>
                                                                维修信息
                                                            </div>
                                                        </div>
                                                        <div class="portlet-body">
                                                            <c:if test="${repair.status eq 'REPAIRING' or repair.status eq 'FINISH'}">
                                                                <form class="form-horizontal form-bordered" data-validate="parsley"
                                                                      action="${ctx}/admin/wefamily/saveRepairInfo" method="POST"
                                                                      id="repairInfoFrm" style="border: 0px">
                                                                    <div class="panel-body p-0-15">
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label"><span class="text-danger">*</span><c:if test="${type eq 'REPAIR'}">维修</c:if><c:if test="${type eq 'MAINTAIN'}">保养</c:if>工人：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <select  class="form-control" name="workerId" id="workerId" data-required="true">
                                                                                    <option value="">请选择</option>
                                                                                    <c:forEach items="${workerUserList}" var="workerUser">
                                                                                            <option value="${workerUser.uuid}" <c:if test="${repair.worker == workerUser.uuid}">selected</c:if>>${workerUser.name}</option>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label"><c:if test="${type eq 'REPAIR'}">维修</c:if><c:if test="${type eq 'MAINTAIN'}">保养</c:if>日期：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                                                                       name="repairdt" value="${repair.repairdt}" data-maxlength="23" onblur="trimText(this)"
                                                                                       data-date-format="yyyy-mm-dd" id="repairdt" placeholder="请选择维修日期">
                                                                            </div>
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <label class="col-sm-3 control-label">
                                                                               维修金额：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                    <input class="form-control myFee" size="4"
                                                                                           name="price"
                                                                                           value="${repair.price}" id="price"
                                                                                           data-maxlength="10"
                                                                                           onblur="validateMoney(this,'priceError')"
                                                                                    >
                                                                                    <span id="priceError" class="text-danger"></span>
                                                                            </div>
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <label class="col-sm-3  control-label">备注：</label>
                                                                            <div class="col-sm-9 b-l bg-white">
                                                                                <textarea class="form-control" rows="4" name="remarks"
                                                                                          id="remarks" data-maxlength="256" onblur="trimText(this)"
                                                                                >${repair.remarks}</textarea>
                                                                            </div>
                                                                        </div>

                                                                        <div class="form-group" >
                                                                            <label class="col-sm-3 control-label">维修图片：</label>
                                                                            <div class="col-sm-9  b-l bg-white">
                                                                                <div class="my-display-inline-box">
                                                                                    <div id="workerImgUrlContainer">
                                                                                        <input type="file" id="workerImg" name="picUrl" class="filestyle"
                                                                                               data-icon="false" data-classButton="btn btn-default"
                                                                                               data-classInput="form-control inline v-middle input-xs"
                                                                                               onchange="compressUploadPicture(this)" accept="image/*"
                                                                                            <%--data-max_size="2000000" --%>
                                                                                               style="display: none"
                                                                                               data-max-count="4">
                                                                                    </div>
                                                                                    <div id="workerImgContainer" class="row value">
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>

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

                                                            <c:if test="${empty repair.status or repair.status eq 'NEW'}">
                                                                <div class="row static-info">
                                                                    <div class="col-md-12 col-xs-12 value">
                                                                        <span>暂无维修信息</span>
                                                                    </div>
                                                                </div>
                                                                <c:if test="${not empty repair.status && empty repair.worker}">
                                                                    <button class="btn btn-sm" data-toggle="modal" data-target=".bs-example-modal-tj-worker" style="color: #fff;margin-left: 10px;margin-bottom: 10px;background-color: #67809F">派工</button>
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
            showParentMenu('宿舍服务');
        }

        judgeRepairType();

        getLayerList();
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
                url:"${ctx}/admin/wefamily/addWorkerForRepair?repairId=${repair.uuid}&versionno=${repair.versionno}",
                data:$('#addWorkerFrm').serialize(),// 你的formid
                async: false,
                error: function(request) {
                    $('#submitAddWorkerBtn').removeAttr('disabled');
                    qikoo.dialog.alert("系统忙，稍候再试");
                },
                success: function(data) {
                    $('#modelCloseBtnAdd').click();
                    window.location.href = "<%=request.getContextPath()%>/admin/wefamily/repairInfo?repairId=${repair.uuid}&successMessage="+data.successMessage;
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
                    window.location.href = "<%=request.getContextPath()%>/admin/wefamily/repairInfo?repairId="+data.repairId+"&successMessage="+data.successMessage;
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
                url:"${ctx}/admin/wefamily/saveRepairInfo?repairId=${repair.uuid}&repairVersionno=${repair.versionno}&saveType="+saveType,
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

    function judgeRepairType(){
        var type = $('#type').val();
        if(type == 'STUDENT'){
            $("#stunoDiv").removeClass("hidden");
        }else{
            $("#stunoDiv").addClass("hidden");
        }
    }

    //获取分层列表
    function getLayerList() {
        var dormitoryid = $("select[name='dormitoryid'] option:selected").val();
        if (dormitoryid.length > 0) {
            $.get("${ctx}/admin/wefamily/" + dormitoryid + "/layer", function (data, status) {
                var layerList = data.layerList;
                initLayerList();
                for (i = 0; i < layerList.length; i++) {

                    $("select[name='layer']").append($("<option>").val(layerList[i].layer).text(layerList[i].layer));

                    if ('${repair.dormitoryid}' == dormitoryid && '${repair.layer}' == layerList[i].layer) {
                        $("select[name='layer']").val(layerList[i].layer);
                    }
                }
                initRoomnoList();
                //查询房间号
                getRoomnoList();
            });
        }
    }

    //获取房间号列表
    function getRoomnoList() {
        initRoomnoList();
        var dormitoryid = $("select[name='dormitoryid'] option:selected").val();
        var layer = $("select[name='layer'] option:selected").val();
        if (dormitoryid.length > 0 && layer != undefined && layer.length > 0) {
            $.get("${ctx}/admin/wefamily/" + dormitoryid + "/" + layer + "/roomno", function (data, status) {
                var roomnoList = data.roomnoList;
                initRoomnoList();
                for (i = 0; i < roomnoList.length; i++) {
                    $("select[name='roomno']").append($("<option>").val(roomnoList[i].roomno).text(trimZero(roomnoList[i].roomno)));

                    if ('${repair.dormitoryid}' == dormitoryid && '${repair.layer}' == layer && '${repair.roomno}' == roomnoList[i].roomno) {
                        $("select[name='roomno']").val(roomnoList[i].roomno);
                    }
                }
            });
        }
    }

    function initLayerList() {
        $("select[name='layer']").empty();
        $("select[name='layer']").append($("<option>").val("").text("请选择"));
    }
    function initRoomnoList() {
        $("select[name='roomno']").empty();
        $("select[name='roomno']").append($("<option>").val("").text("请选择"));
    }


</script>
</body>
</html>