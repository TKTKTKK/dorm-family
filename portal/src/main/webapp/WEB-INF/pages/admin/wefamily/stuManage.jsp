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
            学生管理 / <span class="font-bold  text-shallowred"> 学生信息</span>
        </header>
        <section class="scrollable padder">
            <div class="row">

                <div class="bg-white closel">
                    <div class="col-sm-12 no-padder">
                        <form method="post" action="${ctx}/admin/wefamily/stuManage" class="form-horizontal b-l b-r b-b b-t padding20"
                              data-validate="parsley"
                              id="searchForm">
                            <div class="row">
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control" name="dormitoryid" id="dormitoryid" onchange="getLayerList()">
                                        <c:if test="${fn:length(dormitoryList) > 1}">
                                            <option value="">宿舍楼</option>
                                        </c:if>
                                        <c:forEach items="${dormitoryList}" var="dormitory">
                                            <option value="${dormitory.uuid}" <c:if test="${student.dormitoryid == dormitory.uuid}">selected="selected"</c:if>>${dormitory.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>


                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control" name="layer" onchange="getRoomnoList()">
                                        <option value="">楼层(单元)</option>
                                    </select>
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control" name="roomno">
                                        <option value="">房间号</option>
                                    </select>
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="name" name="name" onblur="trimText(this)" value="${student.name}"
                                           placeholder="姓名"
                                    />
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="stuno" name="stuno" onblur="trimText(this)" value="${student.stuno}"
                                           placeholder="学号"
                                    />
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="contactno" name="contactno" onblur="trimText(this)" value="${student.contactno}"
                                           placeholder="手机"
                                    />
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control" name="gender">
                                        <option value="">性别</option>
                                        <option value="M" <c:if test="${student.gender eq 'M'}">selected</c:if>>男</option>
                                        <option value="F" <c:if test="${student.gender eq 'F'}">selected</c:if>>女</option>
                                    </select>
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <c:set var="politicalList"
                                           value="${web:queryCommonCodeList('POLITICAL')}"></c:set>
                                    <select class="form-control" name="political" id="political">
                                        <option value="">政治面貌</option>
                                        <c:forEach items="${politicalList}" var="political">
                                            <option value="${political.code}"
                                                    <c:if test="${student.political eq political.code}">selected </c:if>
                                            >${political.codevalue}</option>
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
                                <span class="text-danger" id="synFailureMsg"></span>
                                <c:if test="${successFlag == 1}">
                                    <span class="text-success">删除成功！</span>
                                </c:if>
                            </div>
                            <div class="table-responsive" >
                                <table class="table table-striped b-t b-light  b-l b-r b-b text-center">

                                    <thead>
                                    <tr>
                                        <th class="text-center">姓名</th>
                                        <th class="text-center">学号</th>
                                        <th class="text-center">手机</th>
                                        <th class="text-center">宿舍楼</th>
                                        <th class="text-center">楼层（单元）</th>
                                        <th class="text-center">房间号</th>
                                        <th class="text-center">政治面貌</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${studentPageList}" var="student">
                                        <tr>
                                            <td>
                                                    ${student.name}<c:if test="${student.type eq 'DORMHEAD'}">(舍长)</c:if>
                                            </td>
                                            <td>
                                                    ${student.stuno}
                                            </td>
                                            <td>
                                                    ${student.contactno}
                                            </td>
                                            <td>
                                                    ${student.dormitoryname}
                                            </td>
                                            <td>
                                                    ${student.layer}
                                            </td>
                                            <td>
                                                    ${student.roomno}
                                            </td>
                                            <td>
                                                    ${web:getCodeDesc("POLITICAL",student.political)}
                                            </td>
                                            <td>
                                                <a href="${ctx}/admin/wefamily/stuInfo?studentId=${student.uuid}"
                                                   class="btn  btn-infonew btn-sm" style="color: white">
                                                    修改
                                                </a>
                                                <a href="javascript:setDormHead('${student.uuid}')"
                                                   class="btn  btn-yellow btn-sm" style="color: white">
                                                    设为舍长
                                                </a>
                                                <a href="javascript:deleteStudent('${student.uuid}')" class="btn  btn-dangernew btn-sm" style="color: white">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${fn:length(studentPageList) > 0}">
                                    <web:pagination pageList="${studentPageList}" postParam="true"/>
                                </c:if>

                                <button class="btn btn-sm btn-submit" onclick="showStuInfo()"> 添加</button>

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
        showParentMenu('宿舍管理');


        getLayerList();
    }

    //提交查询
    function submitSearch() {
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if ($('#searchForm').parsley().isValid()) {
            $('#searchBtn').attr('disabled', true);
            //ui block
            pleaseWait();
            document.getElementById('searchForm').submit();
        }
    }

    function resubmitSearch(page){
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if ($('#searchForm').parsley().isValid()) {
            $('#searchBtn').attr('disabled', true);
            //ui block
            pleaseWait();
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/admin/wefamily/dormitoryManage?page=" + page;
            searchForm.submit();
        }
    }

    function setDormHead(studentId){
        qikoo.dialog.confirm('确认设置此学生为舍长？',function(){
            //确定
            $.get("${ctx}/admin/wefamily/setDormHead?studentId="+studentId+"&version="+Math.random(),function(data,status){
                if(1 == data.setFlag){
                    var searchForm = document.getElementById("searchForm");
                    searchForm.action = "${ctx}/admin/wefamily/stuManage?setFlag=" + data.setFlag;
                    searchForm.submit();
                }
            });
        },function(){
            //取消
        });
    }


    function deleteStudent(studentId){
        qikoo.dialog.confirm('确认删除？',function(){
            //确定
            $.get("${ctx}/admin/wefamily/deleteStudent?studentId="+studentId+"&version="+Math.random(),function(data,status){
                if(undefined != data.deleteFlag){
                    var searchForm = document.getElementById("searchForm");
                    searchForm.action = "${ctx}/admin/wefamily/stuManage?deleteFlag=" + data.deleteFlag;
                    searchForm.submit();
                }
            });
        },function(){
            //取消
        });
    }


    function showStuInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/stuInfo";
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

                    if ('${student.dormitoryid}' == dormitoryid && '${student.layer}' == layerList[i].layer) {
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

                    if ('${student.dormitoryid}' == dormitoryid && '${student.layer}' == layer && '${student.roomno}' == roomnoList[i].roomno) {
                        $("select[name='roomno']").val(roomnoList[i].roomno);
                    }
                }
            });
        }
    }

    function initLayerList() {
        $("select[name='layer']").empty();
        $("select[name='layer']").append($("<option>").val("").text("楼层(单元)"));
    }
    function initRoomnoList() {
        $("select[name='roomno']").empty();
        $("select[name='roomno']").append($("<option>").val("").text("房间号"));
    }


</script>
</body>
</html>