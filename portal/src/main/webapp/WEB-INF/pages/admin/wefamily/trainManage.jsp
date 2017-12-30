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
            满田星 / <span class="font-bold  text-shallowred"> 培训管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
                <div class="bg-white closel">
                    <div class="col-sm-12 no-padder">
                        <form method="post" action="${ctx}/admin/wefamily/trainManage" class="form-horizontal b-l b-r b-b padding20"
                              data-validate="parsley"
                              id="searchForm">
                            <div class="row">
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control" name="merchantid" id="merchantid" <shiro:hasAnyRoles name="MERCHANT_MANAGER,MTX_MAINTAIN_WORKER,MTX_REPAIR_WORKER,MTX_TRAIN_WORKER">data-required="true"</shiro:hasAnyRoles>>
                                        <c:if test="${fn:length(merchantList) > 1}">
                                            <option value="">经销商</option>
                                        </c:if>
                                        <c:forEach items="${merchantList}" var="merchant">
                                            <option value="${merchant.uuid}" <c:if test="${train.merchantid == merchant.uuid}">selected="selected"</c:if>>${merchant.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select  class="form-control" name="status" id="status">
                                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('TRAIN_STATUS')}"></c:set>
                                        <option value="">培训状态</option>
                                        <c:forEach items="${commonCodeList}" var="commonCode">
                                            <option value="${commonCode.code}" <c:if test="${train.status == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="snno" name="snno" onblur="trimText(this)" value="${train.snno}"
                                           placeholder="培训编号"
                                    />
                                    <input type="hidden" name="type" value="${type}">
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control" name="machinemodel" id="machinemodel">
                                        <c:if test="${fn:length(machineModelList) > 1}">
                                            <option value="">机器型号</option>
                                        </c:if>
                                        <c:forEach items="${machineModelList}" var="machineModel">
                                            <option value="${machineModel}" <c:if test="${train.machinemodel == machineModel}">selected</c:if>>${machineModel}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="machineno" name="machineno" onblur="trimText(this)" value="${train.machineno}"  placeholder="机器号"/>
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="personphone" name="personphone" onblur="trimText(this)" value="${train.personphone}"  placeholder="用户电话"/>
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
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select  class="form-control" name="praisestatus" id="praisestatus">
                                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('PRAISE_STATUS')}"></c:set>
                                        <option value="">奖励状态</option>
                                        <c:forEach items="${commonCodeList}" var="commonCode">
                                            <option value="${commonCode.code}" <c:if test="${train.praisestatus == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                        </c:forEach>
                                    </select>
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
                                <c:if test="${successFlag == 1}">
                                    <span class="text-success">删除成功！</span>
                                </c:if>
                            </div>
                            <div class="table-responsive" >
                                <table class="table table-striped b-light b-a text-center">

                                    <thead>
                                    <tr>
                                        <th class="text-center">编号</th>
                                        <th class="text-center">经销商</th>
                                        <th class="text-center">机器型号</th>
                                        <th class="text-center">机器号</th>
                                        <th class="text-center">用户姓名</th>
                                        <th class="text-center">用户电话</th>
                                        <th class="text-center">培训类型</th>
                                        <th class="text-center">培训日期</th>
                                        <th class="text-center">培训状态</th>
                                        <th class="text-center">奖励状态</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${trainList}" var="train">
                                        <tr>
                                            <td>
                                                    ${train.snno}
                                            </td>
                                            <td>
                                                    ${train.merchantname}
                                            </td>
                                            <td>
                                                    ${train.machinemodel}
                                            </td>
                                            <td>
                                                    ${train.machineno}
                                            </td>
                                            <td>
                                                    ${train.personname}
                                            </td>
                                            <td>
                                                    ${train.personphone}
                                            </td>
                                            <td>
                                                    ${web:getCodeDesc("TRAIN_TYPE",train.type)}
                                            </td>
                                            <td>
                                                    ${train.traindt}
                                            </td>
                                            <td>
                                                    ${web:getCodeDesc("TRAIN_STATUS",train.status)}
                                            </td>
                                            <td>
                                                    ${web:getCodeDesc("PRAISE_STATUS",train.praisestatus)}
                                            </td>
                                            <td>
                                                <a href="${ctx}/admin/wefamily/trainInfo?trainId=${train.uuid}&merchantId=${train.merchantid}" class="btn  btn-infonew btn-sm" style="color: white" >详情</a>
                                                <a href="javascript:deleteTrain('${train.uuid}')" class="btn  btn-dangernew btn-sm" style="color: white" <c:if test="${train.status == 'FINISH'}">disabled="disabled" </c:if> >删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${not empty trainList}">
                                    <web:pagination pageList="${trainList}" postParam="true"/>
                                </c:if>
                            </div>
                        <div class="navbar-left">
                            <a class="btn btn-sm btn-info" href="javascript:showTrainInfo()"
                               style="color:white">添加培训</a>
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
        showParentMenu('品质服务');
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


    function deleteTrain(trainId){
        qikoo.dialog.confirm('确定删除该培训？',function(){
            //确定
            $.get("${ctx}/admin/wefamily/deleteTrain?trainId="+trainId+"&version="+Math.random(),function(data,status){
                if(undefined != data.deleteFlag){
                    var searchForm = document.getElementById("searchForm");
                    searchForm.action = "${ctx}/admin/wefamily/trainManage?deleteFlag=" + data.deleteFlag;
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
            searchForm.action = "${ctx}/admin/wefamily/trainManage?page=" + page;
            searchForm.submit();
        }
    }

    function showTrainInfo(){
        var mercahntid = $("#merchantid").val();
        if(mercahntid.length > 0){
            window.location.href = "<%=request.getContextPath()%>/admin/wefamily/trainInfo?merchantId=" + mercahntid;
        }else{
            qikoo.dialog.alert("请选择经销商！");
        }

    }

</script>
</body>
</html>