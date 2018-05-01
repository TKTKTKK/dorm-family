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
                宿舍管理 / <a href="${ctx}/admin/wefamily/hygieneManage"> 卫生管理</a> / <span class="font-bold  text-shallowred">卫生详情</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="${ctx}/admin/wefamily/hygieneInfo" method="POST"
                      onsubmit="return checkIfValid()" id="frm">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">卫生详情：</span>
                        </header>
                        <div class="panel-body p-0-15">

                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>学期：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select class="form-control" id="term" name="term">
                                        <option value="1" <c:if test="${hygiene.term eq '1'}">selected</c:if>>第一学期</option>
                                        <option value="2" <c:if test="${hygiene.term eq '2'}">selected</c:if>>第二学期</option>
                                        <option value="3" <c:if test="${hygiene.term eq '3'}">selected</c:if>>第三学期</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>周次：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select class="form-control" id="week" name="week" data-required="true">
                                        <option value="">周次</option>
                                        <c:forEach var="w"  begin="1" end="25">
                                            <option value="${w}" <c:if test="${hygiene.week == w}">selected</c:if>>第${w}周</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>宿舍楼：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select class="form-control" id="dormitoryid" name="dormitoryid" data-required="true" onchange="getLayerList()">
                                        <c:if test="${fn:length(dormitoryList) > 1}">
                                            <option value="">宿舍楼</option>
                                        </c:if>
                                        <c:forEach items="${dormitoryList}" var="dormitory">
                                            <option value="${dormitory.uuid}" <c:if test="${hygiene.dormitoryid == dormitory.uuid}">selected="selected"</c:if>>${dormitory.name}</option>
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
                                        <option value="${hygiene.roomno}" selected>${hygiene.roomno}</option>
                                    </select>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>地面：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="number" name="ground" class="form-control" data-required="true"
                                           onblur="trimText(this)" max="20" min="0"
                                           value="${hygiene.ground}" id="ground"
                                    >
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>桌面：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="number" name="desk" class="form-control" data-required="true"
                                           onblur="trimText(this)" max="20" min="0"
                                           value="${hygiene.desk}" id="desk"
                                    >
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>床褥：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="number" name="bed" class="form-control" data-required="true"
                                           onblur="trimText(this)" max="20" min="0"
                                           value="${hygiene.bed}" id="bed"
                                    >
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>阳台：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="number" name="balcony" class="form-control" data-required="true"
                                           onblur="trimText(this)" max="20" min="0"
                                           value="${hygiene.balcony}" id="balcony"
                                    >
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>卫生间：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="number" name="toilet" class="form-control" data-required="true"
                                           onblur="trimText(this)" max="20" min="0"
                                           value="${hygiene.toilet}" id="toilet"
                                    >
                                </div>
                            </div>

                            <c:if test="${not empty hygiene.total}">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>总分：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <input type="number"  class="form-control" data-required="true"
                                               onblur="trimText(this)"  readonly
                                               value="${hygiene.total}"
                                        >
                                    </div>
                                </div>
                            </c:if>


                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${hygiene.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${hygiene.versionno}">
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
        showParentMenu('宿舍服务');

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

                    if ('${hygiene.dormitoryid}' == dormitoryid && '${hygiene.layer}' == layerList[i].layer) {
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

                    if ('${hygiene.dormitoryid}' == dormitoryid && '${hygiene.layer}' == layer && '${hygiene.roomno}' == roomnoList[i].roomno) {
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