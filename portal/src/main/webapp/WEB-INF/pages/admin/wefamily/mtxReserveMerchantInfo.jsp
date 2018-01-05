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
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>姓名：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="name" id="name"
                                           data-maxlength="48" disabled
                                           value="${mtxReserve.name}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>电话：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="phone" id="phone"
                                           data-maxlength="60" disabled
                                           value="${mtxReserve.phone}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>所在地区：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <div class="col-sm-4" style="margin-left: -15px">
                                    <input type="text" class="form-control" data-required="true" name="province" id="province"
                                           data-maxlength="256" disabled
                                           value="${mtxReserve.province}"></div>
                                    <div class="col-sm-4">
                                    <input type="text" class="form-control" data-required="true" name="city" id="city"
                                           data-maxlength="256" disabled
                                           value="${mtxReserve.city}"></div>
                                    <div class="col-sm-4">
                                    <input type="text" class="form-control" data-required="true" name="district" id="district"
                                           data-maxlength="256" disabled
                                           value="${mtxReserve.district}"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>详细地址：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="address" id="address"
                                           data-maxlength="256" disabled
                                           value="${mtxReserve.address}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>机型：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="model" id="model"
                                           data-maxlength="60" disabled
                                           value="${mtxReserve.model}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger"></span>详细信息：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control"  name="detail" id="detail"
                                          disabled
                                           value="${mtxReserve.detail}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>处理状态：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select class="form-control" id="status" name="status">
                                        <option value="CHANGE" <c:if test="${mtxReserve.status == 'CHANGE'}">selected</c:if>>未联系</option>
                                        <option value="C_DEAL" <c:if test="${mtxReserve.status == 'C_DEAL'}">selected</c:if>>已联系</option>
                                    </select>
                                    <span id="statusError" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>经销商：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true"
                                           disabled
                                    <c:forEach items="${merchantList}" var="merchant">
                                           <c:if test="${merchant.uuid==mtxReserve.merchantid}">value="${merchant.name}" </c:if>
                                    </c:forEach>
                                    >
                                    <input type="text" class="form-control hidden" data-required="true" name="merchantid"
                                    <c:forEach items="${merchantList}" var="merchant">
                                       <c:if test="${merchant.uuid==mtxReserve.merchantid}">value="${merchant.uuid}" </c:if>
                                    </c:forEach>
                                    >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>备注：</label>
                                <div class="col-sm-9 b-l bg-white" style="margin-top: 10px;margin-bottom: 10px">
                                    <textarea name="remarks" data-required="true" style="width:100%; height: 200px;">${mtxReserve.remarks}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${mtxReserve.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${mtxReserve.versionno}">
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
                    <div>
                        <p class="warningword"><span class="font-bold"><i class="fa fa-warning">：</i></span>
                            点击图片，可查看大图。</p>
                    </div>
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
        showParentMenu('产品中心');
    }
    function submitForm(){
        var statusError=document.getElementById("statusError");
        statusError.innerHTML="";
        var status=$("select[name='status'] option:selected").val();
        if(status=='CHANGE'){
            statusError.innerHTML="处理状态不能为未联系！";
            return false;
        }else{
            $("#frm").parsley("validate");
            if($('#frm').parsley().isValid()){
                var searchForm = document.getElementById("frm");
                searchForm.action = "${ctx}/admin/wefamily/updateMtxReserve?flag=merchant";
                searchForm.submit();
            }
        }


    }
</script>

</body>
</html>