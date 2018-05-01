<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
<style>
</style>
</head>
<body class="">

<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                咨询留言/
                <a href="${ctx}/admin/wefamily/mtxReserveManage">咨询管理 </a> /
                <span class="font-bold  text-shallowred"> 咨询详情</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="" method="POST"
                     id="frm">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">咨询详情：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>宿舍楼：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true"
                                           data-maxlength="48" disabled
                                           value="${dormitory.name}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>
                                    <c:choose>
                                        <c:when test="${dormitory.type ne 'N'}"> 单元：</c:when>
                                        <c:otherwise>楼层</c:otherwise>
                                    </c:choose>
                                </label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true"
                                           data-maxlength="48" disabled
                                           value="${student.layer}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>房间号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true"
                                           data-maxlength="48" disabled
                                           value="${student.roomno}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>姓名：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true"
                                           data-maxlength="48" disabled
                                           value="${student.name}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>学号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true"
                                           data-maxlength="48" disabled
                                           value="${student.stuno}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>电话：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true"
                                           data-maxlength="60" disabled
                                           value="${student.contactno}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger"></span>咨询问题：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control"  name="detail" id="detail"
                                           disabled
                                           value="${consult.detail}">
                                </div>
                            </div>
                            <c:if test="${not empty consult.reply}">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>处理状态：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <input type="text" class="form-control" data-required="true"
                                               disabled value="已回复"
                                        >
                                    </div>
                                </div>
                            </c:if>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>回复：</label>
                                <div class="col-sm-9 b-l bg-white" style="margin-top: 10px;margin-bottom: 10px">
                                    <textarea name="reply" data-required="true" style="width:100%; height: 200px;">${consult.reply}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${consult.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${consult.versionno}">
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer text-left bg-light lter">
                            <a onclick="submitForm()"
                               class="btn  btn-submit btn-s-xs " style="color: white">
                                提交
                            </a>
                        </div>
                    </section>
                </form>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script charset="utf-8" src="${ctx}/static/admin/editor/kindeditor.js"></script>
<script charset="utf-8" src="${ctx}/static/admin/editor/lang/zh_CN.js"></script>
<script charset="utf-8" src="${ctx}/static/admin/editor/plugins/lineheight/lineheight.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('宿舍服务');
    }
    if(${mtxReserve.status=='N_DEAL'}){
        changeMerchant();
    }
    function submitForm(){

        $("#frm").parsley("validate");
        if($('#frm').parsley().isValid()){
            var searchForm = document.getElementById("frm");
            searchForm.action = "${ctx}/admin/wefamily/consultInfo";
            searchForm.submit();
        }
    }

    function submitForms(){
        $("#frm").parsley("validate");
        if($('#frm').parsley().isValid()){
        var searchForm = document.getElementById("frm");
        searchForm.action = "${ctx}/admin/wefamily/updateMtxReserve";
        searchForm.submit();
        }

    }

    function changeMerchant(){
        var status=$("select[name='status'] option:selected").val();
        if(status=='CHANGE'){
            $("#merchant").removeClass("hidden");
        }else{
            $("#merchant").addClass("hidden");
        }
    }
</script>

</body>
</html>