<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <link rel="stylesheet" href="${ctx}/static/admin/css/home.css"  type="text/css" />
</head>
<body class="">

<shiro:hasAnyRoles name="WP_SUPER,WP_USER,WP_COMP,WP_ADM">
    <%--<section id="content" class="pager">--%>
    <section id="content" class="pager" style="padding:10px;margin-top: 0px">
        <div id="contentDiv">
            <div class="row dashCard" style="" id="dashCardDiv">
                <div >
                    <c:if test="${upwsSugCount*1 > 0 || upwsRepCount*1 > 0 || upwsConCount*1 > 0}">
                        <div class="col-lg-3 col-md-3">
                            <div class="panel text-white" style="background-color: #588ebd">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <a href="${ctx}/admin/weproperty/suggestionManage?type=${type}&querytype=overdue&fromType=HOME&communityId=${communityId}&status=NEW&finaltype=${finaltype}&fromCard=Y" class="text-white font-bold"
                                               style="font-size: 50px">
                                                <c:if test="${'C' eq type}">
                                                    ${upwsSugCount}
                                                </c:if>
                                                <c:if test="${'R' eq type}">
                                                    ${upwsRepCount}
                                                </c:if>
                                                <c:if test="${'P' eq type}">
                                                    ${upwsConCount}
                                                </c:if>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer"
                                     style="background: rgba(255, 255, 255, 0.1) !important;filter: Alpha(opacity=30);border:0">
                                    <a href="#" style="  position: relative;  color: #fff;font-weight: bold">
                                    <span>
                                        <c:if test="${'C' eq type}">
                                            投诉
                                        </c:if>
                                        <c:if test="${'R' eq type}">
                                            报修
                                        </c:if>
                                        <c:if test="${'P' eq type}">
                                            咨询建议
                                        </c:if>
                                        过期未受理数
                                    </span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=${type}&querytype=overdue&fromType=HOME&communityId=${communityId}&status=NEW&finaltype=${finaltype}&fromCard=Y" class="pull-right"><i class="fa fa-arrow-circle-right"></i></a>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${pwsSugCount*1 > 0 || pwsRepCount*1 > 0 || pwsConCount*1 > 0}">
                        <div class="col-lg-3 col-md-3">
                            <div class="panel text-white" style="background-color: #f2774b">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <a href="${ctx}/admin/weproperty/suggestionManage?type=${type}&querytype=overdue&fromType=HOME&communityId=${communityId}&status=PENDING&finaltype=${finaltype}&fromCard=Y" class="text-white font-bold"
                                               style="font-size: 50px">
                                                <c:if test="${'C' eq type}">
                                                    ${pwsSugCount}
                                                </c:if>
                                                <c:if test="${'R' eq type}">
                                                    ${pwsRepCount}
                                                </c:if>
                                                <c:if test="${'P' eq type}">
                                                    ${pwsConCount}
                                                </c:if>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer"
                                     style="background: rgba(255, 255, 255, 0.1) !important;filter: Alpha(opacity=30);border:0">
                                    <a href="#" style="  position: relative;  color: #fff;font-weight: bold">
                                    <span>
                                        <c:if test="${'C' eq type}">
                                            投诉
                                        </c:if>
                                        <c:if test="${'R' eq type}">
                                            报修
                                        </c:if>
                                        <c:if test="${'P' eq type}">
                                            咨询建议
                                        </c:if>
                                        过期未完成数
                                    </span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=${type}&querytype=overdue&fromType=HOME&communityId=${communityId}&status=PENDING&finaltype=${finaltype}&fromCard=Y" class="pull-right"><i class="fa fa-arrow-circle-right"></i></a>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${fuSugCount*1 > 0 || fuRepCount*1 > 0 || fuConCount*1 > 0}">
                        <div class="col-lg-3 col-md-3">
                            <div class="panel text-white" style="background-color: #1bbc9b">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <a href="${ctx}/admin/weproperty/suggestionManage?type=${type}&querytype=overdue&fromType=HOME&communityId=${communityId}&status=PENDING&finaltype=${finaltype}&typeFlag=FOLLOW_UP&fromCard=Y"
                                               class="text-white font-bold" style="font-size: 50px">
                                                <c:if test="${'C' eq type}">
                                                    ${fuSugCount}
                                                </c:if>
                                                <c:if test="${'R' eq type}">
                                                    ${fuRepCount}
                                                </c:if>
                                                <c:if test="${'P' eq type}">
                                                    ${fuConCount}
                                                </c:if>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer"
                                     style="background: rgba(255, 255, 255, 0.1) !important;filter: Alpha(opacity=30);border:0">
                                    <a href="#" style="  position: relative;  color: #fff;font-weight: bold">
                                    <span>
                                        <c:if test="${'C' eq type}">
                                            投诉
                                        </c:if>
                                        <c:if test="${'R' eq type}">
                                            报修
                                        </c:if>
                                        <c:if test="${'P' eq type}">
                                            咨询建议
                                        </c:if>
                                        过期未跟进数
                                    </span>
                                    </a>
                                    <a href="${ctx}/admin/weproperty/suggestionManage?type=${type}&querytype=overdue&fromType=HOME&communityId=${communityId}&status=PENDING&finaltype=${finaltype}&typeFlag=FOLLOW_UP&fromCard=Y" class="pull-right"><i class="fa fa-arrow-circle-right"></i></a>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </section>
</shiro:hasAnyRoles>
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

        if(checkIfPC()){
            //以表格显示
            showDashTable();
        }else{
            //以块显示
            showDashCard();
        }
    };

    //删除屏幕样式
    function deleteScreenClass(){
        if( $('#showTblBtn') != undefined){
            $('#showTblBtn').removeClass('dashCard');
        }
        if( $('#showCardBtn') != undefined){
            $('#showCardBtn').removeClass('dashTable');
        }
        if( $('#dashTblDiv') != undefined){
            $('#dashTblDiv').removeClass('dashTable');
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

        if(document.getElementById('dashTblDiv') != undefined){
            document.getElementById('dashTblDiv').style.display = 'none';
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
        document.getElementById('frm').action = "${ctx}/admin/exportHomeTable";
        document.getElementById('frm').submit();
        <%--$.get("${ctx}/admin/exportHomeTable");--%>
    }

    //查询关注用户列表
    function queryAttentionUserList(){
        window.location.href = "${ctx}/admin/account/queryAllWpUsersByBindid";
    }
</script>
</body>
</html>

