<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>

</head>
<body class="">

<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                学生管理 / <a href="${ctx}/admin/wefamily/stuManage"> 学生信息管理</a> / <span class="font-bold  text-shallowred">信息详情</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="${ctx}/admin/wefamily/stuInfo" method="POST"
                      onsubmit="return checkIfValid()" id="frm">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">学生详情：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>宿舍楼：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select class="form-control" id="dormitoryid" name="dormitoryid" onchange="getLayerList()">
                                        <c:if test="${fn:length(dormitoryList) > 1}">
                                            <option value="">宿舍楼</option>
                                        </c:if>
                                        <c:forEach items="${dormitoryList}" var="dormitory">
                                            <option value="${dormitory.uuid}" <c:if test="${student.dormitoryid == dormitory.uuid}">selected="selected"</c:if>>${dormitory.name}</option>
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
                                        <option value="${student.roomno}" selected>${student.roomno}</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">
                                    <span class="text-danger">*</span>
                                    姓名：</label>

                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" name="name" class="form-control" data-required="true"
                                           onblur="trimText(this)"
                                           value="${student.name}"
                                           data-maxlength="90" id="name"
                                           >
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label"> <span class="text-danger">*</span>性别：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <div class="radio col-sm-2">
                                        <label>
                                            <input type="radio" name="gender" id="gender1" value="M"
                                                   <c:if test="${empty student.gender || student.gender == 'M'}">checked</c:if>
                                            >男
                                        </label>
                                    </div>
                                    <div class="radio col-sm-2">
                                        <label>
                                            <input type="radio" name="gender" id="gender2" value="F"
                                                   <c:if test="${student.gender == 'F'}">checked</c:if>
                                            >女
                                        </label>
                                    </div>
                                    <div class="col-sm-8">&nbsp;</div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">
                                    <span class="text-danger">*</span>
                                    学号：</label>

                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" name="stuno" class="form-control" data-required="true"
                                           onblur="trimText(this)"
                                           value="${student.stuno}"
                                           data-maxlength="20" id="stuno"
                                    >
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-sm-3 control-label">
                                    <span class="text-danger">*</span>
                                    手机：</label>

                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" name="contactno" class="form-control" data-required="true"
                                           onblur="checkPhone(this.value)"
                                           value="${student.contactno}"
                                           data-maxlength="20" id="contactno">
                                    <span id="contactnoError" class="text-danger"></span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">证件类型：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <c:set var="authIdTypeList"
                                           value="${web:queryCommonCodeList('ID_TYPE')}"></c:set>
                                    <select class="form-control" name="idtype" id="idtype" data-required="true">
                                        <option value="">--请选择--</option>
                                        <c:forEach items="${authIdTypeList}" var="authIdType">
                                                <option value="${authIdType.code}"
                                                        <c:if test="${student.idtype eq authIdType.code}">selected </c:if>
                                                >${authIdType.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                    <div id="idError" class="text-danger"></div>
                                    <div id="idTypeError" class="text-danger"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">证件号码：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <input type="text" class="form-control"
                                           name="idno" id="idno" value="${student.idno}" data-required="true"
                                    >
                                    <div id="idnoError" class="text-danger"></div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">民族：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <input type="text" class="form-control" name="nation"
                                           id="nation" data-maxlength="10"
                                           value="${student.nation}">
                                    <span id="nationError" class="text-danger"></span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">政治面貌：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <c:set var="politicalList"
                                           value="${web:queryCommonCodeList('POLITICAL')}"></c:set>
                                    <select class="form-control" name="political" id="political">
                                        <option value="">--请选择--</option>
                                        <c:forEach items="${politicalList}" var="political">
                                            <option value="${political.code}"
                                                    <c:if test="${student.political eq political.code}">selected </c:if>
                                            >${political.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${student.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${student.versionno}">
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer text-left bg-light lter">
                                <button type="submit" class="btn btn-submit btn-s-xs ">
                                    <i class="fa fa-check"></i>&nbsp;提&nbsp;交
                                </button>
                        </div>
                    </section>
                </form>
            </div>

        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script src="${ctx}/static/admin/js/lrz/dist/lrz.bundle.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('宿舍管理');

        getLayerList();
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
        $("select[name='layer']").append($("<option>").val("").text("请选择"));
    }
    function initRoomnoList() {
        $("select[name='roomno']").empty();
        $("select[name='roomno']").append($("<option>").val("").text("请选择"));
    }

    function checkPhone(phone) {
        var contactnoError = document.getElementById('contactnoError');
        contactnoError.innerHTML = "";
        trimText(document.getElementById('contactno'));
        var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
        if (!myreg.test(phone)) {
            contactnoError.innerHTML = "请输入正确的手机号！";
            return false;
        } else {
            return true;
        }
    }


</script>

</body>
</html>