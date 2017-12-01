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

<div>
    <section id="content" class="pager contentStyle">
        <div id="contentDiv">
            <div style="padding-top: 10%">
                <H1 class="icon-emoticon-smile icon text-success-dker">欢迎光临满田星微信管理系统！</H1>
            </div>
        </div>
    </section>
</div>

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


    //异步查询数据
    function queryDataAsy(){
    }

</script>
</body>
</html>

