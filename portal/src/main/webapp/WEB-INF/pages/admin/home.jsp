<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <link rel="stylesheet" href="${ctx}/static/admin/css/home.css"  type="text/css" />
    <style type="text/css">
        .sc-navy-bg {
            background-color: #1ab394;
            color: #ffffff;
        }

        .sc-widget {
            border-radius: 5px;
            margin-bottom: 10px;
            margin-top: 10px;
            padding: 0px;
        }

        .sc-card-content{
            padding: 15px 20px;
        }

        .sc-lazur-bg {
            background-color: #23c6c8;
            color: #ffffff;
        }

        .sc-yellow-bg {
            background-color: #f8ac59;
            color: #ffffff;
        }

        .sc-blue-bg {
            background-color: #1c84c6;
            color: #ffffff;
        }

        .sc-danger-bg {
            background-color: #e65c50;
            color: #FFFFFF;
        }

        .sc-not-visit-bg {
            background-color: #8f89ed;
            color: #FFFFFF;
        }

        .sc-overdue-bg {
            background-color: #a52a2a;
            color: #FFFFFF;
        }

        .sc-green-bg {
            background-color: #86BA60;
            color: #FFFFFF;
        }

        .sc-wait-bg {
            background-color: #f8641f;
            color: #ffffff;
        }
        .needo  span:nth-of-type(1){
            vertical-align: middle;
            font-size: 17px;
        }
        .needo  span:nth-of-type(2){
            vertical-align: middle;
            font-size: 24px;
            width: 57px;
            display: inline-block;
            text-align: left;
            padding-left: 10px;
        }
        .needo a{
            display: block;
        }
        #dashTblDiv .table tbody>tr>td{
            white-space: nowrap;
        }
        .col-lg-4{
            margin-left: 20px;
        }
        .col-sm-12{
            margin-left: 20px;
        }
    </style>
</head>
<body class="">

    <%--<section id="content" class="pager">--%>
    <c:if test="${ifHqUser == 'Y' || ifMerchantManager == 'Y'}">
        <section id="content" class="pager contentStyle">
            <div id="contentDiv">


                <c:if test="${not empty merchantList}">
                    <div class="row
            <c:if test="${'ALL' eq queryType}">
                hidden
            </c:if>
            " id="computerCardDiv">
                        <div  class="col-sm-12">
                            <form method="post" action="" class="form-horizontal" data-validate="parsley" id="searchForm" style="margin: 10px 0">
                                <div class=" row">
                                    <div class="col-sm-2">
                                        <select data-required="true" class="form-control" onchange="searchMyConsole(this.value)" id="merchantId">
                                            <c:forEach items="${merchantList}" var="merchant">
                                                <c:if test="${merchantId == merchant.uuid}">
                                                    <option value="${merchant.uuid}" selected>${merchant.name}</option>
                                                </c:if>
                                                <c:if test="${merchantId != merchant.uuid}">
                                                    <option value="${merchant.uuid}">${merchant.name}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-sm-10">
                                    </div>
                                </div>
                            </form>
                        </div>
                        <c:if test="${ifHqUser eq 'Y'}">
                            <div class="col-lg-4" style="text-align: left">
                                <div class=" sc-navy-bg sc-widget">
                                    <div class="sc-card-content style1">
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <i class="fa fa-wrench fa-5x"></i>
                                            </div>
                                            <div class="col-xs-8 text-right needo">
                                                <a>
                                                    <span>&nbsp;&nbsp;</span>
                                                    <span>&nbsp;&nbsp;</span>
                                                </a>
                                                <a href="${ctx}/admin/wefamily/qualityMgmtManage?type=REPAIR&status=NEW&unDistributed=Y" style="color: #fff;">
                                                    <span> 未分配新任务 </span>
                                                    <span id="newRepairForHQ">0</span>
                                                </a>
                                                <a>
                                                    <span>&nbsp;&nbsp;</span>
                                                    <span>&nbsp;&nbsp;</span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel-footer"
                                         style="background: rgba(255, 255, 255, 0.1) !important;filter: Alpha(opacity=30);
                                         border:0;padding-left: 10px;">
                                        <span style="color: #fff;font-weight: bold">报修分配</span>
                                        <a href="${ctx}/admin/wefamily/qualityMgmtManage?type=REPAIR&status=NEW&unDistributed=Y"
                                           class="pull-right" style="color:#fff">
                                            进入<span class="fa fa-angle-double-right"></span>
                                        </a>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <div class="col-lg-4" style="text-align: left">
                            <div class=" sc-navy-bg sc-widget">
                                <div class="sc-card-content style1">
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <i class="fa fa-wrench fa-5x"></i>
                                        </div>
                                        <div class="col-xs-8 text-right needo">

                                            <a href="${ctx}/admin/wefamily/qualityMgmtManage?type=REPAIR&merchantid=${merchantId}&status=NEW" style="color: #fff;">
                                                <span> 新任务 </span>
                                                <span id="newRepair">0</span>
                                            </a>


                                            <a href="${ctx}/admin/wefamily/qualityMgmtManage?type=REPAIR&merchantid=${merchantId}&status=REPAIRING" style="color: #fff;">
                                                <span> 处理中 </span>
                                                <span id="inRepair">0</span>
                                            </a>
                                            <a href="${ctx}/admin/wefamily/qualityMgmtManage?type=REPAIR&merchantid=${merchantId}&status=FINISH" style="color: #fff;">
                                                <span> 处理完成 </span>
                                                <span id="completeRepair">0</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer"
                                     style="background: rgba(255, 255, 255, 0.1) !important;filter: Alpha(opacity=30);
                                     border:0;padding-left: 10px;">
                                    <span style="color: #fff;font-weight: bold">报修管理</span>
                                    <a href="${ctx}/admin/wefamily/repairManage"
                                       class="pull-right" style="color:#fff">
                                        进入<span class="fa fa-angle-double-right"></span>
                                    </a>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4" style="text-align: left">
                            <div class="sc-green-bg sc-widget">
                                <div class="sc-card-content style1">
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <i class="fa fa-users fa-5x"></i>
                                        </div>
                                        <div class="col-xs-8 text-right needo">
                                            <c:if test="${ifHqUser eq 'N'}">
                                                <a href="${ctx}/admin/wefamily/goOrderManage?merchantid=${merchantId}&status=UNSUBMIT" style="color: #fff;">
                                                    <span> 未发送 </span> <span id="unsubmitOrder">0</span>
                                                </a>
                                            </c:if>
                                            <c:if test="${ifHqUser eq 'Y'}">
                                                <a href="${ctx}/admin/wefamily/goOrderManage?merchantid=${merchantId}&status=NEW" style="color: #fff;">
                                                    <span> 新订单 </span> <span id="newOrder">0</span>
                                                </a>
                                            </c:if>
                                            <a href="${ctx}/admin/wefamily/goOrderManage?merchantid=${merchantId}&status=INPLAN" style="color: #fff;">
                                                <span> 计划中 </span>
                                                <span id="planingOrder">0</span>
                                            </a>
                                            <a href="${ctx}/admin/wefamily/goOrderManage?merchantid=${merchantId}&status=INLOGISTICS" style="color: #fff;">
                                                <span> 运输中 </span>
                                                <span id="transportOrder">0</span>
                                            </a>
                                            <a href="${ctx}/admin/wefamily/goOrderManage?merchantid=${merchantId}&status=RECEIVED" style="color: #fff;">
                                                <span> 已收货 </span>
                                                <span id="receivedOrder">0</span>
                                            </a>
                                            <a href="${ctx}/admin/wefamily/goOrderManage?merchantid=${merchantId}&status=FILED" style="color: #fff;">
                                                <span> 归档完成 </span>
                                                <span id="filedOrder">0</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer"
                                     style="background: rgba(255, 255, 255, 0.1) !important;filter: Alpha(opacity=30);
                                     border:0;padding-left: 10px;">
                                    <span style="color: #fff;font-weight: bold">订单管理</span>
                                    <a href="${ctx}/admin/wefamily/orderManage"
                                       class="pull-right" style="color:#fff">
                                        进入<span class="fa fa-angle-double-right"></span>
                                    </a>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </section>
    </c:if>

    <c:if test="${ifHqUser == 'N' && ifMerchantManager == 'N'}">
        <div>
            <section id="content" class="pager contentStyle">
                <div id="contentDiv">
                    <div style="padding-top: 10%">
                        <H1 class="icon-emoticon-smile icon text-success-dker">欢迎光临满田星微信管理系统！</H1>
                    </div>
                </div>
            </section>
        </div>
    </c:if>


<%--My Script--%>
<script type="text/javascript" src="${ctx}/static/admin/js/myScript.js"></script>
<script>
    window.onload = function(){

        if(document.getElementById('contentDiv') && document.getElementById('menuDiv')){
            document.getElementById('contentDiv').style.height = (document.documentElement.clientHeight - 80/985*document.documentElement.clientHeight) + "px";
            document.getElementById('menuDiv').style.height = (document.documentElement.clientHeight - 100/985*document.documentElement.clientHeight) + "px";
        }

        if(document.documentElement.clientWidth <= 767){
            document.getElementById('contentDiv').style.overflowY = '';
            document.getElementById('contentDiv').style.overflowX = '';
        }else{
            document.getElementById('contentDiv').style.overflowY = 'scroll';
            document.getElementById('contentDiv').style.overflowX = 'hidden';
        }

        //异步查询数据
        queryDataAsy();
    };

    //查询我的工作台
    function searchMyConsole(merchantId){
        window.location.href = "${ctx}/admin/home?merchantId=" + merchantId;
    }

    //删除屏幕样式
    function deleteScreenClass(){
        if( $('#showTblBtn') != undefined){
            $('#showTblBtn').removeClass('dashCard');
        }
        if( $('#showCardBtn') != undefined){
            $('#showCardBtn').removeClass('dashTable');
        }
        if( $('#computerCardDiv') != undefined){
            $('#computerCardDiv').removeClass('dashTable');
        }
        if( $('#dashCardDiv') != undefined){
            $('#dashCardDiv').removeClass('dashCard');
        }
    }

    //以块显示
    function showDashCard(){
        //删除屏幕样式
        deleteScreenClass();

        //默认滚动到顶部
        $('#contentDiv').scrollTop(0);

        if(document.getElementById('showCardBtn') != undefined){
            document.getElementById('showCardBtn').style.display = 'none';
        }
        if(document.getElementById('showTblBtn') != undefined){
            document.getElementById('showTblBtn').style.display = 'block';
        }

        if(document.getElementById('computerCardDiv') != undefined){
            document.getElementById('computerCardDiv').style.display = 'none';
        }
        if(document.getElementById('dashCardDiv') != undefined){
            document.getElementById('dashCardDiv').style.display = 'block';
        }
    }


    //查询关注用户列表
    function queryAttentionUserList(){
        window.location.href = "${ctx}/admin/account/queryAllWpUsersByBindid";
    }

    function goOrderManage(merchantid,status){
       /* $.get(encodeURI("/admin/wefamily/qualityMgmtAsy?status=NEW&type=REPAIR&merchantId=${merchantId}"),function(data,status){
            $('#newRepair').text(data);
        });*/

        $.post("${ctx}/admin/wefamily/orderManage?status=NEW&type=REPAIR&merchantId=${merchantId}",
                {
                    merchantid:merchantid,
                    status:status
                },
                function(data,status){

                });
    }


    //异步查询数据
    function queryDataAsy(){
        //已分配新任务
        $.get(encodeURI("/admin/wefamily/qualityMgmtAsy?status=NEW&type=REPAIR&merchantId=${merchantId}"),function(data,status){
            $('#newRepair').text(data);
        });
        //未分配新任务
        $.get(encodeURI("/admin/wefamily/qualityMgmtAsy?status=NEW&type=REPAIR"),function(data,status){
            $('#newRepairForHQ').text(data);
        });
        //处理中
        $.get(encodeURI("/admin/wefamily/qualityMgmtAsy?status=REPAIRING&type=REPAIR&merchantId=${merchantId}"),function(data,status){
            $('#inRepair').text(data);
        });
        //处理完成
        $.get(encodeURI("/admin/wefamily/qualityMgmtAsy?status=FINISH&type=REPAIR&merchantId=${merchantId}"),function(data,status){
            $('#completeRepair').text(data);
        });
        //未发送订单
        $.get(encodeURI("/admin/wefamily/orderAsy?status=UNSUBMIT&merchantId=${merchantId}"),function(data,status){
            $('#unsubmitOrder').text(data);
        });
        //新订单
        $.get(encodeURI("/admin/wefamily/orderAsy?status=NEW&merchantId=${merchantId}"),function(data,status){
            $('#newOrder').text(data);
        });
        //计划中
        $.get(encodeURI("/admin/wefamily/orderAsy?status=INPLAN&merchantId=${merchantId}"),function(data,status){
            $('#planingOrder').text(data);
        });
        //运输中
        $.get(encodeURI("/admin/wefamily/orderAsy?status=INLOGISTICS&merchantId=${merchantId}"),function(data,status){
            $('#transportOrder').text(data);
        });
        //已收货
        $.get(encodeURI("/admin/wefamily/orderAsy?status=RECEIVED&merchantId=${merchantId}"),function(data,status){
            $('#receivedOrder').text(data);
        });
        //归档完成
        $.get(encodeURI("/admin/wefamily/orderAsy?status=FILED&merchantId=${merchantId}"),function(data,status){
            $('#filedOrder').text(data);
        });
    }

</script>
</body>
</html>

