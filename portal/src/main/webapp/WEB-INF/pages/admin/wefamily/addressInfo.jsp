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
                宿舍管理 / ${dormitory.name} / <a href="${ctx}/admin/wefamily/addressManage?dormitoryId=${dormitory.uuid}"> 房间管理</a> / <span class="font-bold  text-shallowred">房间信息</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="${ctx}/admin/wefamily/addressInfo" method="POST"
                      id="frm">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">房间信息：</span>
                        </header>
                        <div class="panel-body p-0-15">

                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>
                                    <c:choose>
                                        <c:when test="${dormitory.type ne 'N'}">单元：</c:when>
                                        <c:otherwise>楼层：</c:otherwise>
                                    </c:choose>
                                </label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="layer" id="layer"
                                           data-maxlength="48"
                                           onblur="trimText(this)"
                                           value="${address.layer}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>房间号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="roomno" id="roomno"
                                           data-maxlength="48"
                                           onblur="trimText(this)"
                                           value="${address.roomno}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">面积(m²)：</label>
                                <div class="col-sm-9 b-l  bg-white">
                                    <input class="form-control" size="6"
                                           name="area" id="area"
                                           data-maxlength="10"
                                           onblur="validateArea(this,'freightError')"
                                           <c:choose>
                                                <c:when test="${empty address.area}">
                                                    value="0.00"
                                                </c:when>
                                                <c:otherwise>
                                                    value="${address.area}"
                                                </c:otherwise>
                                            </c:choose>
                                           >
                                    <div class="text-danger" id="freightError"></div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="dormitoryid" class="form-control" value="${dormitory.uuid}">
                                    <input type="hidden" name="uuid" class="form-control" value="${address.uuid}">
                                    <input type="hidden" name="versionno" class="form-control" value="${address.versionno}">
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
    }

    //检查面积合法性
    function validateArea(obj, errorId){
        var errorObj = document.getElementById(errorId);
        errorObj.innerHTML = "";
        if(obj.value.length > 0){
            var rule = /^\d+(\.\d+)*$/;
            if(obj.value.length > 0 && (!(rule.test(obj.value)) || obj.value*1 < 0)){
                errorObj.innerText = "输入面积非法";
                return false;
            }
        }
        return true;
    }

</script>

</body>
</html>