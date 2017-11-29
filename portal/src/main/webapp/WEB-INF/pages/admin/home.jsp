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
    </style>
</head>
<body class="">

<shiro:hasAnyRoles name="STEWARD,RE_REPAIR_WORKER,ENVIRONMENT_DIRECTOR,FACILITY_DIRECTOR,SAFETY_DIRECTOR,RE_REPAIR_DIRECTOR,REPORT_MANAGER,WP_ADM,AM,QC,WP_REPAIR_WORKER,WP_USER,WP_REPAIR_DIRECTOR,ESTATE_TECHNICAL_MANAGER,RE_CUSTOMER_SERVICE,QUAL_MANAGER,WP_PM,WP_COMP,WP_SUPER,SYSTEM_ADM,WP_ENG_ADM,FORCE_CLOSE">
    <%--<section id="content" class="pager">--%>
    <section id="content" class="pager contentStyle">
        <div id="contentDiv">
            <%--<div class="row hideInfo" id="authInfo">--%>
                <%--<div class="col-lg-4 col-md-4 statisticPaddingRight"--%>
                     <%--onclick="queryAttentionUserList()"--%>
                     <%--style="cursor: pointer">--%>
                    <%--<div class="panel text-white" style="background-color: #86BA60">--%>
                        <%--<div class="panel-heading">--%>
                            <%--<div style="font-size: 20px">&nbsp;</div>--%>
                            <%--<i class="fa fa-users" style="font-size: 30px"> ${attentionCount}</i>--%>
                            <%--<div style="font-size: 16px">关注人数</div>--%>
                            <%--<div style="font-size: 20px">&nbsp;</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>

                <%--<div class="col-lg-4 col-md-4">--%>
                    <%--<div class="panel text-white" style="background-color: #4E8FDA">--%>
                        <%--<div class="panel-heading">--%>
                            <%--<div style="font-size: 20px">&nbsp;</div>--%>
                            <%--<i class="fa fa-user" style="font-size: 30px"> ${authCount}</i>--%>
                            <%--<div style="font-size:  16px">认证人数</div>--%>
                            <%--<div style="font-size: 20px">&nbsp;</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="col-lg-4 col-md-4"--%>
                        <%--onclick="queryTodoReportList()"--%>
                        <%--style="cursor: pointer">--%>
                    <%--<div class="panel text-white" style="background-color: #f8641f">--%>
                        <%--<div class="panel-heading">--%>
                            <%--<div style="font-size: 20px">&nbsp;</div>--%>
                            <%--<i class="icon-star fa-5x" style="font-size: 30px"> ${todoTaskNumMagnifier}</i>--%>
                            <%--<div style="font-size: 16px">报事待办</div>--%>
                            <%--<div style="font-size: 20px">&nbsp;</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="xs-12 hidden-lg hidden-md"--%>
                 <%--onclick="queryTodoReportList()"--%>
                 <%--style="cursor: pointer">--%>
                <%--<div class="panel text-white" style="background-color: #f8641f">--%>
                    <%--<div class="panel-heading">--%>
                        <%--<div style="font-size: 20px">&nbsp;</div>--%>
                        <%--<i class="icon-star fa-5x" style="font-size: 30px"> ${todoTaskNumMagnifier}</i>--%>
                        <%--<div style="font-size: 16px">报事待办</div>--%>
                        <%--<div style="font-size: 20px">&nbsp;</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>

            <c:if test="${not empty wpCommunityList}">
            <%--<div class="row " style="margin-bottom: 10px">--%>
            <%--<div class="col-lg-12 col-md-12" style="padding:0px 20px 10px 20px;text-align: left">--%>
            <%--<button class="btn btn-sm btn-info pull-left" onclick="exportHomeTable()">导出</button>--%>
            <%--<button class="btn btn-sm btn-info dashTable pull-right" id="showCardBtn"--%>
            <%--onclick="showDashCard()">以块显示</button>--%>
            <%--<button class="btn btn-sm btn-info dashCard pull-right" id="showTblBtn"--%>
            <%--onclick="showDashTable()">以表格显示</button>--%>
            <%--</div>--%>
            <%--</div>--%>
            <!-- /.row -->
            <div class="row
            <c:if test="${'ALL' eq queryType}">
                hidden
            </c:if>
            " id="computerCardDiv">
                <div  class="col-sm-12">
                    <form method="post" action="" class="form-horizontal" data-validate="parsley" id="searchForm" style="margin: 10px 0">
                        <div class=" row">
                            <div class="col-sm-2">
                                <select data-required="true" class="form-control" onchange="searchMyConsole(this.value)" id="communityid">
                                    <c:forEach items="${wpCommunityList}" var="community">
                                        <c:if test="${communityId == community.uuid}">
                                            <option value="${community.uuid}" selected>${community.name}</option>
                                        </c:if>
                                        <c:if test="${communityId != community.uuid}">
                                            <option value="${community.uuid}">${community.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-sm-10">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-lg-4" style="text-align: left">
                    <div class="col-lg-12 sc-yellow-bg sc-widget">
                        <div class="sc-card-content style1">
                            <div class="row">
                                <div class="col-xs-4">
                                    <i class="fa fa-user fa-5x"></i>
                                </div>
                                <div class="col-xs-8 text-right needo">
                                    <a href="${ctx}/admin/weproperty/householdAuth?fromType=HOME&communityid=${communityId}&status=PENDING" style="color: #fff;">
                                        <span> 业主待认证 </span> <span id="pendingAuth">0</span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=PR&fromType=HOME&communityId=${communityId}&finaltype=PR" style="color: #fff;">
                                        <span> 点赞待处理 </span> <span id="newPraise">0</span>
                                    </a>
                                    <a href="javascript:queryTodoReportList()" style="color: #fff;">
                                        <span> 报事待处理 </span> <span id="todoReport">${todoTaskNumMagnifier}</span>
                                    </a>
                                    <a class="hidden-xs">
                                        <span>&nbsp;</span>
                                        <span>&nbsp;</span>
                                    </a>
                                    <a class="hidden-xs">
                                        <span>&nbsp;</span>
                                        <span>&nbsp;</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer"
                             style="background: rgba(255, 255, 255, 0.1) !important;filter: Alpha(opacity=30);
                                     border:0;padding-left: 10px;">
                            <span style="color: #fff;font-weight: bold">待办事项</span>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4" style="text-align: left">
                    <div class=" sc-navy-bg sc-widget">
                        <div class="sc-card-content style1">
                            <div class="row">
                                <div class="col-xs-4">
                                    <i class="fa fa-wrench fa-5x"></i>
                                </div>
                                <div class="col-xs-8 text-right needo">
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=R&fromType=HOME&communityId=${communityId}&status=NEW&finaltype=R" style="color: #fff;">
                                        <span> 待处理 </span> <span id="newRepair">0</span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=R&fromType=HOME&communityId=${communityId}&status=PENDING&finaltype=R" style="color: #fff;">
                                        <span> 处理中 </span>
                                        <span id="pendingRepair">0</span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=R&querytype=overdue&fromType=HOME&communityId=${communityId}&status=NEW&finaltype=R" style="color: #fff;">
                                        <span> 过期未受理 </span>
                                        <span id="overdueNotDealRepair">0</span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=R&querytype=overdue&fromType=HOME&communityId=${communityId}&status=PENDING&finaltype=R" style="color: #fff;">
                                        <span> 过期未完成 </span>
                                        <span id="overdueNotCompleteRepair">0</span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=R&querytype=overdue&fromType=HOME&communityId=${communityId}&status=PENDING&finaltype=R&typeFlag=FOLLOW_UP" style="color: #fff;">
                                        <span> 过期未跟进 </span>
                                        <span id="overdueNotFollowRepair">0</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer"
                             style="background: rgba(255, 255, 255, 0.1) !important;filter: Alpha(opacity=30);
                                     border:0;padding-left: 10px;">
                            <span style="color: #fff;font-weight: bold">报修管理</span>
                            <a href="${ctx}/admin/weproperty/suggestionManage?type=R"
                               class="pull-right" style="color:#fff">
                                进入<span class="fa fa-angle-double-right"></span>
                            </a>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4" style="text-align: left">
                    <div class=" sc-lazur-bg sc-widget">
                        <div class="sc-card-content style1">
                            <div class="row">
                                <div class="col-xs-4">
                                    <i class="icon-note fa-5x"></i>
                                </div>
                                <div class="col-xs-8 text-right needo">
                                    <a href="${ctx}/admin/magnifier/quickReportManage?type=Q&fromType=HOME&status=INIT&communityId=${communityId}" style="color: #fff;">
                                        <span> 未接单 </span>
                                        <span id="notAssignReport">0</span>
                                    </a>
                                    <a href="${ctx}/admin/magnifier/quickReportManage?type=Q&fromType=HOME&status=CLAIMED&communityId=${communityId}" style="color: #fff;">
                                        <span> 已接单 </span>
                                        <span id="claimedReport">0</span>
                                    </a>
                                    <a href="${ctx}/admin/magnifier/quickReportManage?type=Q&fromType=HOME&status=DEALING&communityId=${communityId}" style="color: #fff;">
                                        <span> 处理中 </span>
                                        <span id="repairingReport">0</span>
                                    </a>
                                    <a href="${ctx}/admin/magnifier/quickReportManage?type=Q&fromType=HOME&statisticsFlag=OVERDUE_DEAL&communityId=${communityId}" style="color: #fff;">
                                        <span> 已逾期 </span>
                                        <span id="overdueReport">0</span>
                                    </a>
                                    <a class="hidden-xs">
                                        <span>&nbsp;</span>
                                        <span>&nbsp;</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer"
                             style="background: rgba(255, 255, 255, 0.1) !important;filter: Alpha(opacity=30);
                                     border:0;padding-left: 10px;">
                            <span style="color: #fff;font-weight: bold"> 报事管理</span>
                            <a href="${ctx}/admin/magnifier/quickReportManage"
                               class="pull-right" style="color:#fff">
                                进入<span class="fa fa-angle-double-right"></span>
                            </a>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4" style="text-align: left">
                    <div class=" sc-wait-bg sc-widget">
                        <div class="sc-card-content style1">
                            <div class="row">
                                <div class="col-xs-4">
                                    <i class="fa fa-comments fa-5x"></i>
                                </div>
                                <div class="col-xs-8 text-right needo">
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=C&fromType=HOME&communityId=${communityId}&status=NEW&finaltype=C" style="color: #fff;">
                                        <span> 待处理 </span> <span id="newSuggest">0</span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=C&fromType=HOME&communityId=${communityId}&status=PENDING&finaltype=C" style="color: #fff;">
                                        <span> 处理中 </span>
                                        <span id="pendingSuggest">0</span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=C&querytype=overdue&fromType=HOME&communityId=${communityId}&status=NEW&finaltype=C" style="color: #fff;">
                                        <span> 过期未受理 </span>
                                        <span id="overdueNotDealSuggest">0</span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=C&querytype=overdue&fromType=HOME&communityId=${communityId}&status=PENDING&finaltype=C" style="color: #fff;">
                                        <span> 过期未完成 </span>
                                        <span id="overdueNotCompleteSuggest">0</span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=C&querytype=overdue&fromType=HOME&communityId=${communityId}&status=PENDING&finaltype=C&typeFlag=FOLLOW_UP" style="color: #fff;">
                                        <span> 过期未跟进 </span>
                                        <span id="overdueNotFollowSuggest">0</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer"
                             style="background: rgba(255, 255, 255, 0.1) !important;filter: Alpha(opacity=30);
                                     border:0;padding-left: 10px;">
                            <span style="color: #fff;font-weight: bold">投诉管理</span>
                            <a href="${ctx}/admin/weproperty/suggestionManage?type=C"
                               class="pull-right" style="color:#fff">
                                进入<span class="fa fa-angle-double-right"></span>
                            </a>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4" style="text-align: left">
                    <div class=" sc-blue-bg sc-widget">
                        <div class="sc-card-content style1">
                            <div class="row">
                                <div class="col-xs-4">
                                    <i class="fa fa-search fa-5x"></i>
                                </div>
                                <div class="col-xs-8 text-right needo">
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=P&fromType=HOME&communityId=${communityId}&status=NEW&finaltype=P" style="color: #fff;">
                                        <span> 待处理 </span> <span id="newConsult">0</span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=P&fromType=HOME&communityId=${communityId}&status=PENDING&finaltype=P" style="color: #fff;">
                                        <span> 处理中 </span>
                                        <span id="pendingConsult">0</span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=P&querytype=overdue&fromType=HOME&communityId=${communityId}&status=NEW&finaltype=P" style="color: #fff;">
                                        <span> 过期未受理 </span>
                                        <span id="overdueNotDealConsult">0</span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=P&querytype=overdue&fromType=HOME&communityId=${communityId}&status=PENDING&finaltype=P" style="color: #fff;">
                                        <span> 过期未完成 </span>
                                        <span id="overdueNotCompleteConsult">0</span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=P&querytype=overdue&fromType=HOME&communityId=${communityId}&status=PENDING&finaltype=P&typeFlag=FOLLOW_UP" style="color: #fff;">
                                        <span> 过期未跟进 </span>
                                        <span id="overdueNotFollowConsult">0</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer"
                             style="background: rgba(255, 255, 255, 0.1) !important;filter: Alpha(opacity=30);
                                     border:0;padding-left: 10px;">
                            <span style="color: #fff;font-weight: bold">咨询建议</span>
                            <a href="${ctx}/admin/weproperty/suggestionManage?type=P"
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
                                    <a style="color: #fff;">
                                        <span> 关注人数 </span>
                                        <span>${attentionCount}</span>
                                    </a>
                                    <a style="color: #fff;">
                                        <span> APP认证 </span>
                                        <span>${appCount}</span>
                                    </a>
                                    <a style="color: #fff;">
                                        <span> 微信认证 </span>
                                        <span>${openidCount}</span>
                                    </a>
                                    <a class="hidden-xs">
                                        <span>&nbsp;</span>
                                        <span>&nbsp;</span>
                                    </a>
                                    <a class="hidden-xs">
                                        <span>&nbsp;</span>
                                        <span>&nbsp;</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer"
                             style="background: rgba(255, 255, 255, 0.1) !important;filter: Alpha(opacity=30);
                                     border:0;padding-left: 10px;">
                            <span style="color: #fff;font-weight: bold">数据看板</span>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>

            <%--<div class="row" style="overflow: auto;height: 900px;" id="homeDiv">--%>
            <div class="row
             <c:choose>
                <c:when test="${'ALL' eq queryType}">
                    dashCard
                </c:when>
                <c:otherwise>
                    hidden
                </c:otherwise>
            </c:choose>
            " style="" id="dashCardDiv">
                <div class="table-responsive" style="overflow-x: auto">
                    <table
                        <%--style="overflow-x: scroll;"--%>
                            class="table">
                        <tr>
                            <th style="background-color: #a3a1a3;text-align:center;color:#fff">小区名称</th>
                            <td class="text-center text-white border" style="background-color: #719832;border-top:0">报修</td>
                            <td class="text-center text-white border"
                                style="  background-color: #0000af;border-top:0;">报事</td>
                            <td class="text-center text-white border"
                                style="  background-color: #db672a;border-top:0;">投诉</td>
                            <td class="text-center text-white border" style="background-color: #008296;border-top:0">建议</td>
                        </tr>
                        <c:forEach items="${wpCommunityList}" var="community" varStatus="stat">
                            <c:if test="${(community.upwsSugCount + community.pwsSugCount + community.fuSugCount + community.upwsRepCount + community.pwsRepCount + community.fuRepCount + community.upwsConCount + community.pwsConCount + community.fuConCount)*1 > 0}">
                                <tr>
                                    <td class="td5 border phone-td"
                                        style="word-wrap: break-word;word-break:break-all;
                                        <c:if test="${stat.index%2 == 0}">
                                                background-color: rgba(140, 148, 29, 0.3);
                                        </c:if>
                                        <c:if test="${stat.index%2 == 1}">
                                                background-color: rgba(207, 49, 138, 0.2);
                                        </c:if>
                                                ">
                                            ${community.name}
                                    </td>
                                    <td class="td8 border">
                                        <a href="
                                            <c:if test="${(community.upwsRepCount + community.pwsRepCount + community.fuRepCount)*1 > 0}">
                                                ${ctx}/admin/showHomeCard?type=R&querytype=overdue&fromType=HOME&communityId=${community.uuid}&status=NEW&finaltype=R&upwsRepCount=${community.upwsRepCount}&pwsRepCount=${community.pwsRepCount}&fuRepCount=${community.fuRepCount}
                                           </c:if>
                                           <c:if test="${(community.upwsRepCount + community.pwsRepCount + community.fuRepCount)*1 == 0}">
                                                #
                                           </c:if>"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.upwsRepCount + community.pwsRepCount + community.fuRepCount)*1 > 0}">
                                                   color:rgba(204, 67, 10, 0.92);
                                                   </c:if>">${community.upwsRepCount + community.pwsRepCount + community.fuRepCount}</a>
                                    </td>
                                    <td class="td11 border">
                                        <a href="${ctx}/admin/magnifier/quickReportManage?type=Q&fromType=HOME&statisticsFlag=OVERDUE_DEAL&communityId=${community.uuid}"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.reportOverdueCount)*1 > 0}">
                                                   color:rgba(204, 67, 10, 0.92);
                                                   </c:if>">${community.reportOverdueCount}</a>
                                    </td>
                                    <td class="td7 border">
                                        <a href="
                                        <c:if test="${(community.upwsSugCount + community.pwsSugCount + community.fuSugCount)*1 > 0}">
                                            ${ctx}/admin/showHomeCard?type=C&querytype=overdue&fromType=HOME&communityId=${community.uuid}&status=NEW&finaltype=C&upwsSugCount=${community.upwsSugCount}&pwsSugCount=${community.pwsSugCount}&fuSugCount=${community.fuSugCount}
                                        </c:if>
                                        <c:if test="${(community.upwsSugCount + community.pwsSugCount + community.fuSugCount)*1 == 0}">
                                            #
                                        </c:if>"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.upwsSugCount + community.pwsSugCount + community.fuSugCount)*1 > 0}">
                                                   color:rgba(204, 67, 10, 0.92);
                                                   </c:if>">${community.upwsSugCount + community.pwsSugCount + community.fuSugCount}</a>
                                    </td>
                                    <td class="td9 border">
                                        <a href="
                                            <c:if test="${(community.upwsConCount + community.pwsConCount + community.fuConCount)*1 > 0}">
                                                ${ctx}/admin/showHomeCard?type=P&querytype=overdue&fromType=HOME&communityId=${community.uuid}&status=NEW&finaltype=P&upwsConCount=${community.upwsConCount}&pwsConCount=${community.pwsConCount}&fuConCount=${community.fuConCount}
                                           </c:if>
                                            <c:if test="${(community.upwsConCount + community.pwsConCount + community.fuConCount)*1 == 0}">
                                                #
                                           </c:if>"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.upwsConCount + community.pwsConCount + community.fuConCount)*1 > 0}">
                                                   color:rgba(204, 67, 10, 0.92);
                                                   </c:if>">${community.upwsConCount + community.pwsConCount + community.fuConCount}</a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>
                </div>
            </div>

            <div class="
            <c:choose>
                <c:when test="${'ALL' eq queryType}">
                    dashTable
                </c:when>
                <c:otherwise>
                    hidden
                </c:otherwise>
            </c:choose>
            "
                 style=""
                 id="dashTblDiv">
                <div class="table-responsive"
                     style="width: 100%;overflow-x: scroll;"
                >
                    <table
                        <%--style="overflow-x: scroll;"--%>
                            class="table">
                        <tr>
                            <th style="background-color: #a3a1a3;text-align:center;color:#fff" rowspan="2">小区名称</th>
                            <th class="text-center text-white border" style="  background-color: #e6ad27;border-top:0" >业主认证</th>
                            <th class="text-center text-white border" style="  background-color: #e65c50;border-top:0" >点赞</th>
                            <th class="text-center text-white border" style="   background-color: #719832;border-top:0" colspan="5">报修</th>
                            <th class="text-center text-white border" style="   background-color: #0000af;border-top:0" colspan="4">报事</th>
                            <th class="text-center text-white border" style="  background-color: #db672a;border-top:0" colspan="5">投诉</th>
                            <th class="text-center text-white border" style="background-color: #008296;border-top:0" colspan="5">咨询建议</th>
                        </tr>
                        <tr>
                            <td class="td1 border">待认证数</td>
                            <td class="td1-1 border">待处理数</td>
                            <td class="td3 border">待处理数</td>
                            <td class="td3 border">处理中数</td>
                            <td class="td3 border">过期未受理数</td>
                            <td class="td3 border">过期未完成数</td>
                            <td class="td3 border">过期未跟进数</td>
                            <td class="td10 border">未接单数</td>
                            <td class="td10 border">已接单数</td>
                            <td class="td10 border">处理中数</td>
                            <td class="td10 border">已逾期数</td>
                            <td class="td2 border">待处理数</td>
                            <td class="td2 border">处理中数</td>
                            <td class="td2 border">过期未受理数</td>
                            <td class="td2 border">过期未完成数</td>
                            <td class="td2 border">过期未跟进数</td>
                            <td class="td4 border">待处理数</td>
                            <td class="td4 border">处理中数</td>
                            <td class="td4 border">过期未受理数</td>
                            <td class="td4 border">过期未完成数</td>
                            <td class="td4 border">过期未跟进数</td>
                        </tr>
                        <c:forEach items="${wpCommunityList}" var="community" varStatus="stat">
                            <%--<c:if test="${(community.pendingAuthCount + community.upwsPraCount--%>
                            <%--+ community.pendingDealSugCount + community.inProcessSugCount + community.upwsSugCount + community.pwsSugCount + community.fuSugCount--%>
                            <%--+ community.pendingDealRepCount + community.inProcessRepCount + community.upwsRepCount + community.pwsRepCount + community.fuRepCount--%>
                            <%--+ community.pendingDealConCount + community.inProcessConCount + community.upwsConCount + community.pwsConCount + community.fuConCount)*1 > 0}">--%>
                                <tr>
                                    <td class="td5 border">
                                            ${community.name}
                                    </td>
                                    <td class="td6 border">
                                        <a href="${ctx}/admin/weproperty/householdAuth?fromType=HOME&communityid=${community.uuid}&status=PENDING"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.pendingAuthCount)*1 > 0}">
                                                color:rgba(204, 67, 10, 0.92);
                                           </c:if>">${community.pendingAuthCount}</a>
                                    </td>
                                    <td class="td6-1 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=PR&fromType=HOME&communityId=${community.uuid}&finaltype=PR"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.upwsPraCount)*1 > 0}">
                                                color:rgba(204, 67, 10, 0.92);
                                           </c:if>">${community.upwsPraCount}</a>
                                    </td>
                                    <td class="td8 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=R&fromType=HOME&communityId=${community.uuid}&status=NEW&finaltype=R"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.pendingDealRepCount)*1 > 0}">
                                                color:rgba(204, 67, 10, 0.92);
                                           </c:if>">${community.pendingDealRepCount}</a>
                                    </td>
                                    <td class="td8 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=R&fromType=HOME&communityId=${community.uuid}&status=PENDING&finaltype=R"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.inProcessRepCount)*1 > 0}">
                                                color:rgba(204, 67, 10, 0.92);
                                           </c:if>">${community.inProcessRepCount}</a>
                                    </td>
                                    <td class="td8 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=R&querytype=overdue&fromType=HOME&communityId=${community.uuid}&status=NEW&finaltype=R"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.upwsRepCount)*1 > 0}">
                                                color:rgba(204, 67, 10, 0.92);
                                           </c:if>">${community.upwsRepCount}</a>
                                    </td>
                                    <td class="td8 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=R&querytype=overdue&fromType=HOME&communityId=${community.uuid}&status=PENDING&finaltype=R"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.pwsRepCount)*1 > 0}">
                                                color:rgba(204, 67, 10, 0.92);
                                           </c:if>">${community.pwsRepCount}</a>
                                    </td>
                                    <td class="td8 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=R&querytype=overdue&fromType=HOME&communityId=${community.uuid}&status=PENDING&finaltype=R&typeFlag=FOLLOW_UP"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.fuRepCount)*1 > 0}">
                                                color:rgba(204, 67, 10, 0.92);
                                           </c:if>">${community.fuRepCount}</a>
                                    </td>
                                    <td class="td11 border">
                                        <a href="${ctx}/admin/magnifier/quickReportManage?type=Q&fromType=HOME&status=INIT&communityId=${community.uuid}"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.reportNotAcceptCount)*1 > 0}">
                                                   color:rgba(204, 67, 10, 0.92);
                                                   </c:if>">${community.reportNotAcceptCount}</a>
                                    </td>
                                    <td class="td11 border">
                                        <a href="${ctx}/admin/magnifier/quickReportManage?type=Q&fromType=HOME&status=CLAIMED&communityId=${community.uuid}"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.reportClaimedCount)*1 > 0}">
                                                   color:rgba(204, 67, 10, 0.92);
                                                   </c:if>">${community.reportClaimedCount}</a>
                                    </td>
                                    <td class="td11 border">
                                        <a href="${ctx}/admin/magnifier/quickReportManage?type=Q&fromType=HOME&status=DEALING&communityId=${community.uuid}"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.reportDealingCount)*1 > 0}">
                                                   color:rgba(204, 67, 10, 0.92);
                                                   </c:if>">${community.reportDealingCount}</a>
                                    </td>
                                    <td class="td11 border">
                                        <a href="${ctx}/admin/magnifier/quickReportManage?type=Q&fromType=HOME&statisticsFlag=OVERDUE_DEAL&communityId=${community.uuid}"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.reportOverdueCount)*1 > 0}">
                                                   color:rgba(204, 67, 10, 0.92);
                                                   </c:if>">${community.reportOverdueCount}</a>
                                    </td>
                                    <td class="td7 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=C&fromType=HOME&communityId=${community.uuid}&status=NEW&finaltype=C"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.pendingDealSugCount)*1 > 0}">
                                                   color:rgba(204, 67, 10, 0.92);
                                                   </c:if>">${community.pendingDealSugCount}</a>
                                    </td>
                                    <td class="td7 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=C&fromType=HOME&communityId=${community.uuid}&status=PENDING&finaltype=C"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.inProcessSugCount)*1 > 0}">
                                                   color:rgba(204, 67, 10, 0.92);
                                                   </c:if>">${community.inProcessSugCount}</a>
                                    </td>
                                    <td class="td7 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=C&querytype=overdue&fromType=HOME&communityId=${community.uuid}&status=NEW&finaltype=C"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.upwsSugCount)*1 > 0}">
                                                   color:rgba(204, 67, 10, 0.92);
                                                   </c:if>">${community.upwsSugCount}</a>
                                    </td>
                                    <td class="td7 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=C&querytype=overdue&fromType=HOME&communityId=${community.uuid}&status=PENDING&finaltype=C"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.pwsSugCount)*1 > 0}">
                                                   color:rgba(204, 67, 10, 0.92);
                                                   </c:if>">${community.pwsSugCount}</a>
                                    </td>
                                    <td class="td7 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=C&querytype=overdue&fromType=HOME&communityId=${community.uuid}&status=PENDING&finaltype=C&typeFlag=FOLLOW_UP"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.fuSugCount)*1 > 0}">
                                                   color:rgba(204, 67, 10, 0.92);
                                                   </c:if>">${community.fuSugCount}</a>
                                    </td>
                                    <td class="td9 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=P&fromType=HOME&communityId=${community.uuid}&status=NEW&finaltype=P"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.pendingDealConCount)*1 > 0}">
                                                color:rgba(204, 67, 10, 0.92);
                                           </c:if>">${community.pendingDealConCount}</a>
                                    </td>
                                    <td class="td9 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=P&fromType=HOME&communityId=${community.uuid}&status=PENDING&finaltype=P"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.inProcessConCount)*1 > 0}">
                                                color:rgba(204, 67, 10, 0.92);
                                           </c:if>">${community.inProcessConCount}</a>
                                    </td>
                                    <td class="td9 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=P&querytype=overdue&fromType=HOME&communityId=${community.uuid}&status=NEW&finaltype=P"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.upwsConCount)*1 > 0}">
                                                color:rgba(204, 67, 10, 0.92);
                                           </c:if>">${community.upwsConCount}</a>
                                    </td>
                                    <td class="td9 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=P&querytype=overdue&fromType=HOME&communityId=${community.uuid}&status=PENDING&finaltype=P"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.pwsConCount)*1 > 0}">
                                                color:rgba(204, 67, 10, 0.92);
                                           </c:if>">${community.pwsConCount}</a>
                                    </td>
                                    <td class="td9 border">
                                        <a href="${ctx}/admin/weproperty/suggestionManage?type=P&querytype=overdue&fromType=HOME&communityId=${community.uuid}&status=PENDING&finaltype=P&typeFlag=FOLLOW_UP"
                                           class="a-noline"
                                           style="font-size: 24px;
                                           <c:if test="${(community.fuConCount)*1 > 0}">
                                                color:rgba(204, 67, 10, 0.92);
                                           </c:if>">${community.fuConCount}</a>
                                    </td>
                                </tr>
                            <%--</c:if>--%>
                        </c:forEach>
                    </table>
                </div>
                    <%--<div class="navbar-left">--%>
                    <%--<button class="btn btn-sm btn-info" onclick="exportHomeTable()">导出</button>--%>
                    <%--</div>--%>
            </div>
            <!-- /.row -->

            <div class="row " style="margin-bottom: 10px" id="exportDiv">
                <div class="col-lg-12 col-md-12" style="padding:0px 20px 10px 20px;text-align: left">
                    <button class="btn btn-sm btn-info pull-left hideInfo" onclick="exportHomeTable()">导出</button>
                    <%--<button class="btn btn-sm btn-info dashTable pull-right" id="showCardBtn"--%>
                            <%--onclick="showDashCard()">以块显示</button>--%>
                    <%--<button class="btn btn-sm btn-info dashCard pull-right" id="showTblBtn"--%>
                            <%--onclick="showDashTable()">以表格显示</button>--%>
                    <button class="btn btn-sm btn-success pull-right
                    <c:if test="${'ALL' eq queryType}">
                        hidden
                    </c:if>
                    " id="showAllDataBtn"
                            onclick="showByTable()">以表格显示</button>
                    <button class="btn btn-sm btn-success pull-right
                    <c:if test="${empty queryType}">
                        hidden
                    </c:if>
                    " id="showOneCommunityDataBtn"
                            onclick="showByCard()">以块显示</button>
                </div>
            </div>

            <form class="hidden" method="post" action="${ctx}/admin/exportHomeTable" class="form-horizontal"
                  data-validate="parsley" id="frm">
            </form>
            </c:if>
            <c:if test="${empty wpCommunityList}">
                <div style="padding-top: 10%">
                    <H1 class="icon-emoticon-smile icon text-success-dker">欢迎光临爱米社区管理系统！</H1>
                </div>
            </c:if>
        </div>
    </section>
</shiro:hasAnyRoles>

<div class="<shiro:hasAnyRoles name="STEWARD,RE_REPAIR_WORKER,ENVIRONMENT_DIRECTOR,FACILITY_DIRECTOR,SAFETY_DIRECTOR,RE_REPAIR_DIRECTOR,REPORT_MANAGER,WP_ADM,AM,QC,WP_REPAIR_WORKER,WP_USER,WP_REPAIR_DIRECTOR,ESTATE_TECHNICAL_MANAGER,RE_CUSTOMER_SERVICE,QUAL_MANAGER,WP_PM,WP_COMP,WP_SUPER,SYSTEM_ADM,WP_ENG_ADM,FORCE_CLOSE">hidden</shiro:hasAnyRoles>">
    <section id="content" class="pager contentStyle">
        <div id="contentDiv">
            <div style="padding-top: 10%">
                <H1 class="icon-emoticon-smile icon text-success-dker">欢迎光临爱米社区管理系统！</H1>
            </div>
        </div>
    </section>
</div>

<%--My Script--%>
<script type="text/javascript" src="${ctx}/static/admin/js/myScript.js"></script>
<script>
    window.onload = function(){
//        if(document.getElementById('dashCardDiv') && (document.getElementById('dashCardDiv').style.display == 'block' || $('#dashCardDiv').hasClass('dashCard')) && document.getElementById('menuDiv')){
//            document.getElementById('dashCardDiv').style.height = (document.documentElement.clientHeight - 200/985*document.documentElement.clientHeight) + "px";
//            document.getElementById('menuDiv').style.height = (document.documentElement.clientHeight - 100/985*document.documentElement.clientHeight) + "px";
//        }
//
//        if(document.getElementById('dashTblDiv') && (document.getElementById('dashTblDiv').style.display == 'block' || $('#dashTblDiv').hasClass('dashTable')) && document.getElementById('menuDiv')){
//            document.getElementById('dashTblDiv').style.height = (document.documentElement.clientHeight - 200/985*document.documentElement.clientHeight) + "px";
//            document.getElementById('menuDiv').style.height = (document.documentElement.clientHeight - 100/985*document.documentElement.clientHeight) + "px";
//        }

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

//        if(checkIfPC()){
//            //以表格显示
//            showDashTable();
//            //$('#exportDiv').removeClass('hidden');
            document.getElementById('content').style.padding = '10px';
//        }else{
            //以块显示
//            showDashCard();
//            //$('#exportDiv').addClass('hidden');
//        }
    };

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

    //以表格显示
    function showDashTable(){
        //删除屏幕样式
        deleteScreenClass();

        //默认滚动到顶部
        $('#contentDiv').scrollTop(0);

        if(document.getElementById('showTblBtn') != undefined){
            document.getElementById('showTblBtn').style.display = 'none';
        }
        if(document.getElementById('showCardBtn') != undefined){
            document.getElementById('showCardBtn').style.display = 'block';
        }

        if(document.getElementById('dashCardDiv') != undefined){
            document.getElementById('dashCardDiv').style.display = 'none';
        }
        if(document.getElementById('dashTblDiv') != undefined){
            document.getElementById('dashTblDiv').style.display = 'block';
        }
    }

    //导出供应者订单信息
    function exportHomeTable(){
        document.getElementById('frm').action = "${ctx}/admin/exportHomeTable?communityId=${communityId}";
        document.getElementById('frm').submit();
        <%--$.get("${ctx}/admin/exportHomeTable");--%>
    }

    //查询关注用户列表
    function queryAttentionUserList(){
        window.location.href = "${ctx}/admin/account/queryAllWpUsersByBindid";
    }

    function queryTodoReportList(){
        window.location.href = "${ctx}/admin/magnifier/todoTaskList?communityId=${communityId}";
    }

    //查询我的工作台
    function searchMyConsole(communityid){
        window.location.href = "${ctx}/admin/home?communityId=" + communityid;
    }

    //异步查询数据
    function queryDataAsy(){
        //待认证业主数
        $.get(encodeURI("/admin/family/queryPendingAuthCountAsy?communityId=${communityId}"),function(data,status){
            $('#pendingAuth').text(data);
        });

        //待处理点赞数
        $.get(encodeURI("/admin/family/queryNewPraiseCountAsy?communityId=${communityId}"),function(data,status){
            $('#newPraise').text(data);
        });

        //新投诉
        $.get(encodeURI("/admin/family/suggestManageAsy?finalType=C&status=NEW&communityId=${communityId}"),function(data,status){
            $('#newSuggest').text(data);
        });
        //处理中投诉
        $.get(encodeURI("/admin/family/suggestManageAsy?finalType=C&status=PENDING&communityId=${communityId}"),function(data,status){
            $('#pendingSuggest').text(data);
        });
        //过期未受理投诉
        $.get(encodeURI("/admin/family/suggestManageOverdueAsy?finalType=C&status=NEW&communityId=${communityId}&configType=DEAL"),function(data,status){
            $('#overdueNotDealSuggest').text(data);
        });
        //过期未完成投诉
        $.get(encodeURI("/admin/family/suggestManageOverdueAsy?finalType=C&status=PENDING&communityId=${communityId}&configType=COMPLETE"),function(data,status){
            $('#overdueNotCompleteSuggest').text(data);
        });
        //过期未跟进投诉
        $.get(encodeURI("/admin/family/suggestManageOverdueAsy?finalType=C&status=PENDING&communityId=${communityId}&configType=COMPLETE&typeFlag=FOLLOW_UP"),function(data,status){
            $('#overdueNotFollowSuggest').text(data);
        });

        //新报修
        $.get(encodeURI("/admin/family/suggestManageAsy?finalType=R&status=NEW&communityId=${communityId}"),function(data,status){
            $('#newRepair').text(data);
        });
        //处理中报修
        $.get(encodeURI("/admin/family/suggestManageAsy?finalType=R&status=PENDING&communityId=${communityId}"),function(data,status){
            $('#pendingRepair').text(data);
        });
        //过期未受理报修
        $.get(encodeURI("/admin/family/suggestManageOverdueAsy?finalType=R&status=NEW&communityId=${communityId}&configType=DEAL"),function(data,status){
            $('#overdueNotDealRepair').text(data);
        });
        //过期未完成报修
        $.get(encodeURI("/admin/family/suggestManageOverdueAsy?finalType=R&status=PENDING&communityId=${communityId}&configType=COMPLETE"),function(data,status){
            $('#overdueNotCompleteRepair').text(data);
        });
        //过期未跟进报修
        $.get(encodeURI("/admin/family/suggestManageOverdueAsy?finalType=R&status=PENDING&communityId=${communityId}&configType=COMPLETE&typeFlag=FOLLOW_UP"),function(data,status){
            $('#overdueNotFollowRepair').text(data);
        });

        //新咨询建议
        $.get(encodeURI("/admin/family/suggestManageAsy?finalType=P&status=NEW&communityId=${communityId}"),function(data,status){
            $('#newConsult').text(data);
        });
        //处理中咨询建议
        $.get(encodeURI("/admin/family/suggestManageAsy?finalType=P&status=PENDING&communityId=${communityId}"),function(data,status){
            $('#pendingConsult').text(data);
        });
        //过期未受理咨询建议
        $.get(encodeURI("/admin/family/suggestManageOverdueAsy?finalType=P&status=NEW&communityId=${communityId}&configType=DEAL"),function(data,status){
            $('#overdueNotDealConsult').text(data);
        });
        //过期未完成咨询建议
        $.get(encodeURI("/admin/family/suggestManageOverdueAsy?finalType=P&status=PENDING&communityId=${communityId}&configType=COMPLETE"),function(data,status){
            $('#overdueNotCompleteConsult').text(data);
        });
        //过期未跟进咨询建议
        $.get(encodeURI("/admin/family/suggestManageOverdueAsy?finalType=P&status=PENDING&communityId=${communityId}&configType=COMPLETE&typeFlag=FOLLOW_UP"),function(data,status){
            $('#overdueNotFollowConsult').text(data);
        });

        //未接单报事
        $.get(encodeURI("/admin/magnifier/quickReportAsy?type=Q&fromType=HOME&status=INIT&communityId=${communityId}"),function(data,status){
            $('#notAssignReport').text(data);
        });

        //已接单报事
        $.get(encodeURI("/admin/magnifier/quickReportAsy?type=Q&fromType=HOME&status=CLAIMED&communityId=${communityId}"),function(data,status){
            $('#claimedReport').text(data);
        });

        //处理中报事
        $.get(encodeURI("/admin/magnifier/quickReportAsy?type=Q&fromType=HOME&status=DEALING&communityId=${communityId}"),function(data,status){
            $('#repairingReport').text(data);
        });

        //逾期报事
        $.get(encodeURI("/admin/magnifier/quickReportAsy?type=Q&fromType=HOME&statisticsFlag=OVERDUE_DEAL&communityId=${communityId}"),function(data,status){
            $('#overdueReport').text(data);
        });
    }

    //以表格形式
    function showByTable(){
        window.location.href="<%=request.getContextPath()%>/admin/home?queryType=ALL";
        $('#showAllDataBtn').addClass('hidden');
        $('#showOneCommunityDataBtn').removeClass('hidden');
    }

    //以块形式
    function showByCard(){
        window.location.href="<%=request.getContextPath()%>/admin/home";
        $('#showOneCommunityDataBtn').addClass('hidden');
        $('#showAllDataBtn').removeClass('hidden');
    }
</script>
</body>
</html>

