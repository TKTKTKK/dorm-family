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
            活动中心 / <span class="font-bold  text-shallowred">活动管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
                <div class="bg-white closel newclosel">
                    <c:if test="${not empty wechatBinding}">
                        <form method="post" action="" class="form-horizontal bg-white padding20 b-t b-b b-l b-r" data-validate="parsley" id="searchForm">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4  my-display-inline-lbl" style="padding-top: 7px">经销商：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <select class="form-control" id="merchantid" name="merchantid">
                                            <option value="">--全部--</option>
                                            <c:forEach items="${merchantList}" var="merchant">
                                                <c:if test="${merchant.uuid == activity.merchantid}">
                                                    <option value="${merchant.uuid}" selected>${merchant.name}</option>
                                                </c:if>
                                                <c:if test="${merchant.uuid != activity.merchantid}">
                                                    <option value="${merchant.uuid}">${merchant.name}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4 my-display-inline-lbl" style="padding-top: 7px"><span class="text-danger"></span> 活动名称：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <input type="text" class="form-control" name="name" id="name" data-maxlength="64"
                                               onblur="trimText(this)" value="${activity.name}">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4  my-display-inline-lbl" style="padding-top: 7px">状态：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <select class="form-control" id="status" name="status">
                                            <option value="">--全部--</option>
                                            <c:set var="typeList" value="${web:queryCommonCodeList('ACTIVITY_STATUS')}"></c:set>
                                            <c:forEach items="${typeList}" var="typeCode">
                                                <c:if test="${activity.status == typeCode.code}">
                                                    <option value="${typeCode.code}" selected>${typeCode.codevalue}</option>
                                                </c:if>
                                                <c:if test="${activity.status != typeCode.code}">
                                                    <option value="${typeCode.code}">${typeCode.codevalue}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-sm-4" style="margin-top: 20px">
                                    <label class="control-label col-sm-4  my-display-inline-lbl" style="padding-top: 7px">开始时间：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <input class="input-sm form-control" type="text"
                                               name="startdate"
                                               data-date-format="yyyy-mm-dd hh:ii:00" id="startdate"
                                               size="23" readonly
                                               value="${activity.startdate}"
                                        >
                                        <div class="text-danger" id="dateError">
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-4" style="margin-top: 20px">
                                    <label class="control-label col-sm-4  my-display-inline-lbl" style="padding-top: 7px">结束时间：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <input class="input-sm form-control" type="text"
                                               name="enddate"
                                               data-date-format="yyyy-mm-dd hh:ii:00" id="enddate"
                                               size="23" readonly
                                               value="${activity.enddate}"
                                        >
                                    </div>
                                </div>
                                <div style="clear: both"></div>
                                <div class="row col-sm-12 text-center text-white" style="margin-top: 20px">
                                    <a type="submit"  class="btn btn-submit btn-s-xs"
                                       onclick="searchMtxActivity()"
                                       id="searchBtn" style="color: #fff">查 询</a>
                                </div>
                            </div>
                        </form>
                            <div style="margin-top: 30px">
                                <span class="text-success">${successMessage}</span>
                                <span class="text-success">${successFlag}</span>
                            </div>
                            <div class="table-responsive" >
                                <table class="table table-striped b-t b-light  b-l b-r b-b">
                                    <thead>
                                    <tr>
                                        <th width="15%">经销商</th>
                                        <th width="15%">活动名称</th>
                                        <th width="10%">活动地点</th>
                                        <th width="10%">开始时间</th>
                                        <th width="10%">结束时间</th>
                                        <th width="15%">详情</th>
                                        <th width="10%">状态</th>
                                        <th width="15%">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${activityList}" var="activity">
                                        <tr>
                                           <td>
                                                <c:forEach items="${merchantList}" var="merchant">
                                                <c:if test="${merchant.uuid == activity.merchantid}">
                                                    ${merchant.name}
                                                </c:if>
                                                </c:forEach>
                                            </td>
                                            <td>
                                                    ${activity.name}
                                            </td>
                                            <td>
                                                    ${activity.address}
                                            </td>
                                            <td>
                                                    ${fn:substring(activity.startdate, 0, 19)}
                                            </td>
                                            <td>
                                                    ${fn:substring(activity.enddate, 0, 19)}
                                            </td>
                                            <td>
                                                    ${activity.detail}
                                            </td>
                                            <td>
                                                    ${web:getCodeDesc("ACTIVITY_STATUS", activity.status)}
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${activity.status eq 'INIT'}">
                                                        <a href="${ctx}/admin/wefamily/goMtxActivity?uuid=${activity.uuid}"
                                                           class="btn  btn-infonew btn-sm" style="color: white">
                                                            修改
                                                        </a>
                                                        <a href="javascript:deleteMtxActivity('${activity.uuid}')" class="btn  btn-dangernew btn-sm" style="color: white">删除</a>
                                                        <a href="javascript:beginMtxActivity('${activity.uuid}')" class="btn  btn-dangernew btn-sm" style="color: white;background: mediumpurple;border: 1px solid mediumpurple">开始</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:if test="${activity.status eq 'PENDING'}">
                                                            <a href="${ctx}/admin/wefamily/goMtxActivity?uuid=${activity.uuid}"
                                                               class="btn  btn-infonew btn-sm" style="color: white;background: mediumpurple;border: 1px solid mediumpurple">
                                                                详情
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${activity.status eq 'APP'}">
                                                            <a href="${ctx}/admin/wefamily/goMtxActivity?uuid=${activity.uuid}"
                                                               class="btn  btn-infonew btn-sm" style="color: white;background: orange;border: 1px solid orange">
                                                                详情
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${activity.status eq 'DRAWING'}">
                                                            <a href="${ctx}/admin/wefamily/goMtxActivity?uuid=${activity.uuid}"
                                                               class="btn  btn-infonew btn-sm" style="color: white;background: green;border: 1px solid green">
                                                                详情
                                                            </a>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <web:pagination pageList="${activityList}" postParam="true"/>
                                <button class="btn btn-sm btn-submit" onclick="showMtxActivityInfo()"> 添加</button>
                            </div>
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
        showParentMenu('活动中心');
    }
    $('#startdate').datetimepicker({
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        forceParse: 0,
        showMeridian: 1,
    });
    $('#enddate').datetimepicker({
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        forceParse: 0,
        showMeridian: 1
    });
    //比较起始日期和截止日期
    function compareBeginEndDate(startDateStr, endDateStr, dateError) {
        var startDateStr = document.getElementById(startDateStr);
        var endDateStr = document.getElementById(endDateStr);
        var dateError = document.getElementById(dateError);
        dateError.innerHTML = '';
        //比较起始和截止日期的大小
        var starttimes;
        var arr = startDateStr.value.split(" ");
        if (arr != null && arr != '') {
            var begin = arr[0].split("-");
            var end = arr[1].split(":");
            var bgDate = new Date(begin[0], begin[1], begin[2], end[0], end[1], end[2]);
            starttimes= bgDate.getTime();
        }
        var edtimes;
        var arrs = endDateStr.value.split(" ");
        if (arrs != null && arrs != '') {
            var begins = arrs[0].split("-");
            var ends = arrs[1].split(":");
            var edDate = new Date(begins[0], begins[1], begins[2], ends[0], ends[1], ends[2]);
            edtimes = edDate.getTime();
        }
        if (starttimes > edtimes) {
            dateError.innerHTML = '起始日期不能大于截止日期';
            return false;
        }
        return true;
    }
    function deleteMtxActivity(uuid){
        qikoo.dialog.confirm('确定要删除吗？',function(){
            //确定删除
            $.post("${ctx}/admin/wefamily/deleteMtxActivity?uuid="+uuid,function(data){
                //删除成功
                if(data.deleteFlag){
                    var searchForm = document.getElementById("searchForm");
                    searchForm.action = "${ctx}/admin/wefamily/mtxActivityManage?deleteFlag=1";
                    searchForm.submit();
                }
            });
        },function(){
            //取消删除
        });
    }
    function beginMtxActivity(uuid){
        qikoo.dialog.confirm('确定开始吗？',function(){
            //确定删除
            $.post("${ctx}/admin/wefamily/beginMtxActivity?uuid="+uuid,function(data){
                //删除成功
                if(data.successFlag){
                    var searchForm = document.getElementById("searchForm");
                    searchForm.action = "${ctx}/admin/wefamily/mtxActivityManage?successFlag=1";
                    searchForm.submit();
                }
            });
        },function(){
            //取消删除
        });
    }
    function resubmitSearch(page){
        var searchForm = document.getElementById("searchForm");
        searchForm.action = "${ctx}/admin/wefamily/mtxActivityManage?page="+page;
        searchForm.submit();
    }


    function showMtxActivityInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/goMtxActivity";
    }
    function searchMtxActivity(){
        if(compareBeginEndDate("startdate", "enddate", "dateError")){
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/admin/wefamily/mtxActivityManage";
            searchForm.submit();
        }
    }

</script>
</body>
</html>