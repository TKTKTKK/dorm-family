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
                宿舍服务 / <a href="${ctx}/admin/wefamily/echargeManage"> 电费缴费记录</a> / <span class="font-bold  text-shallowred">信息详情</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="${ctx}/admin/wefamily/echargeInfo" method="POST"
                      onsubmit="return checkIfValid()" id="frm">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">缴费详情：</span>
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
                                            <option value="${dormitory.uuid}" <c:if test="${echarge.dormitoryid == dormitory.uuid}">selected="selected"</c:if>>${dormitory.name}</option>
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
                                    <input type="text" name="roomno" class="form-control" data-required="true"
                                           onblur="trimText(this)"
                                           value="${echarge.roomno}"
                                           id="roomno"
                                    >
                                </div>
                            </div>
                            <c:if test="${empty echarge.stuid}">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"> <span class="text-danger">*</span>缴费人学号：</label>

                                    <div class="col-sm-9 b-l bg-white">
                                        <input type="text" name="stuno" class="form-control" data-required="true"
                                               onblur="trimText(this)" value="${echarge.stuno}" id="stuno" >
                                    </div>
                                </div>
                            </c:if>


                            <c:if test="${not empty echarge.stuid}">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"> <span class="text-danger">*</span>缴费人学号：</label>

                                    <div class="col-sm-9 b-l bg-white">
                                        <input type="text" name="stuno" class="form-control" data-required="true" readonly
                                               onblur="trimText(this)" value="${student.stuno}" id="stuno" >
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label">缴费人姓名：</label>

                                    <div class="col-sm-9 b-l bg-white">
                                        <input type="text"  class="form-control" readonly
                                               value="${student.name}"  >
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"> 缴费人电话：</label>

                                    <div class="col-sm-9 b-l bg-white">
                                        <input type="text" class="form-control" readonly
                                                value="${student.contactno}">
                                    </div>
                                </div>
                            </c:if>

                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>缴费金额：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <input class="form-control myFee" size="4"
                                           name="price" value="${echarge.price}" id="price"
                                           data-maxlength="10" data-required="true"
                                           onblur="validateMoney(this,'priceError')"
                                    >
                                    <span id="priceError" class="text-danger"></span>
                                </div>
                            </div>

                            <div class="form-group" >
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>缴费方式：</label>
                                <div class="col-sm-9  b-l bg-white">
                                    <select  class="form-control" name="paytype" id="paytype"
                                             data-required="true">
                                        <c:set var="commonCodeList" value="${web:queryCommonCodeList('ECHARGE_PAYTYPE')}"></c:set>
                                        <c:forEach items="${commonCodeList}" var="commonCode">
                                            <option value="${commonCode.code}" <c:if test="${echarge.paytype == commonCode.code}">selected</c:if>>${commonCode.codevalue}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${echarge.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${echarge.versionno}">
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

                    if ('${echarge.dormitoryid}' == dormitoryid && '${echarge.layer}' == layerList[i].layer) {
                        $("select[name='layer']").val(layerList[i].layer);
                    }
                }

            });
        }
    }



    function initLayerList() {
        $("select[name='layer']").empty();
        $("select[name='layer']").append($("<option>").val("").text("请选择"));
    }


</script>

</body>
</html>