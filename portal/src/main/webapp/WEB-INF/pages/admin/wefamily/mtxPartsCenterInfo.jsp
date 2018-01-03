<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
<style>
    .li{
        position: absolute;
        margin-top: 33px;
    }
    .mod-dialog {
        background-color: #fff;
        border: solid 1px #82c92f;
        border-top: none;
        min-width: 300px;
        position: absolute;
        z-index: 1051;
    }
    .mod-dialog-bg {
        background: #000;
        opacity: .5;
        filter: alpha(opacity=50);
        height: 100%;
        left: 0;
        position: fixed;
        top: 0;
        width: 100%;
        z-index: 1050;
    }
    .modal {
        position: fixed;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        z-index: 1040;
        display: none;
        overflow: auto;
        overflow-y: scroll;
    }
    #detailImgContainer{display: inline-block;vertical-align: middle}
    #detailImgUrlContainer{display: inline-block;vertical-align: middle;margin-left: 0rem}
    #detailImgContainer img{width: 5rem;height: 5rem;margin:1rem}
</style>
</head>
<body class="">

<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                产品中心 /
                <a href="${ctx}/admin/wefamily/mtxPartsCenterManage">配件管理 </a> /
                <span class="font-bold  text-shallowred"> 配件详情</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="" method="POST"
                      enctype="multipart/form-data" id="frm" >
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">配件详情：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>适用机型：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select class="form-control" id="machinemodel" name="machinemodel" data-required="true">
                                        <option value="">--全部--</option>
                                        <c:forEach items="${modelList}" var="modelTemp">
                                            <c:if test="${machine.machinemodel == modelTemp}">
                                                <option value="${modelTemp}" selected>${modelTemp}</option>
                                            </c:if>
                                            <c:if test="${machine.machinemodel != modelTemp}">
                                                <option value="${modelTemp}">${modelTemp}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>物料编码：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="machineno" id="machineno"
                                           data-maxlength="64"
                                           onblur="trimText(this)"
                                           value="${machine.machineno}">
                                    <sapn id="codeError" class="text-danger"></sapn>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>配件名称：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="machinename" id="machinename"
                                           data-maxlength="48"
                                           onblur="trimText(this)"
                                           value="${machine.machinename}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>价格：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="price" id="price"
                                           data-maxlength="11"
                                           onblur="validateMoney(this,'priceError')"
                                           value="${machine.price}">
                                    <div class="text-danger" id="priceError"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>规格：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="format" id="format"
                                           data-maxlength="15"
                                           value="${machine.format}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>产地：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="address" id="address"
                                           data-maxlength="256"
                                           onblur="trimText(this)"
                                           value="${machine.address}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>备注：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <textarea type="text" class="form-control" data-required="true" name="remarks" id="remarks"
                                           data-maxlength="256"
                                           onblur="trimText(this)"
                                          >${machine.remarks}</textarea>
                                </div>
                            </div>
                            <c:if test="${fn:length(attachmentList) < 4}">
                                <div class="form-group" >
                                    <label class="col-sm-3 control-label">配件图片：</label>
                                    <div class="col-sm-9  b-l bg-white">
                                        <div class="my-display-inline-box">
                                            <div id="detailImgUrlContainer">
                                                <input type="file" id="detailImg" name="picUrl" class="filestyle"
                                                       data-icon="false" data-classButton="btn btn-default"
                                                       data-classInput="form-control inline v-middle input-xs"
                                                       onchange="compressUploadPicture(this)" accept="image/*"
                                                    <%--data-max_size="2000000" --%>
                                                       style="display: none"
                                                       data-max-count="4">
                                                <div id="picUrlError" class="text-danger"></div>
                                            </div>
                                            <div id="detailImgContainer" class="row value">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${fn:length(attachmentList) > 0}">
                                <div class="form-group" >
                                    <label class="col-sm-3 control-label">图片：</label>
                                    <div class="col-sm-9  b-l bg-white">
                                        <c:forEach items="${attachmentList}" var="attachment">
                                            <img src="${attachment.name}" width="50" height="50" name="${attachment.uuid}"
                                                 onclick="viewBigImage(this)" data-toggle="modal" data-target=".bs-example-modal-lg-image"/>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${machine.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${machine.versionno}">
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
                    <div class="modal fade bs-example-modal-lg-image" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">

                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" id="modelCloseBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                    <h4 class="modal-title" id="myLargeModalLabel">大图</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="bs-example" data-example-id="simple-carousel">
                                                <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                                                </div>
                                                <div class="text-center" style="margin-top: 10px">
                                                    <a  class="btn btn-submit btn-s-xs"
                                                        onclick="deletePic()">
                                                        删除</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- /.modal-content -->
                        </div><!-- /.modal-dialog -->
                    </div>
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
<script src="${ctx}/static/admin/js/lrz/dist/lrz.bundle.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/myScript.js"></script>
<script src="${ctx}/static/admin/js/jquery.blockui.min.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('产品中心');
        if('${machine.price}'.length > 0){
            formatMoney(document.getElementById('price'));
        }
    }

    //检查物料编码是否存在
    function ifMaterialCodeExist(){
        var codeError=document.getElementById("codeError");
        codeError.innerHTML="";
        var code=document.getElementById("machineno").value;
        var uuid='${machine.uuid}';
        $.post("${ctx}/admin/wefamily/ifMaterialCodeExist?code="+code+"&uuid="+uuid,function(data){
            if(data){
                var searchForm = document.getElementById("frm");
                searchForm.action = "${ctx}/admin/wefamily/updateMtxPartsCenter";
                searchForm.submit();
            }else{
                codeError.innerHTML="物料编码已存在！";
            }
        });
    }

    function submitForm(){
        $("#frm").parsley("validate");
        if(validateMoney(document.getElementById('price'),'priceError') && $('#frm').parsley().isValid()){
            ifMaterialCodeExist();
        }
    }

    function deletePic(){
        var div = document.getElementsByClassName("item active");
        var attachmentId = div[0].getAttribute("name");
        qikoo.dialog.confirm('确定要删除吗？',function(){
            //确定删除
            $.get("${ctx}/admin/wefamily/deletePic?attachmentId="+attachmentId,function(data,status){
                if(undefined != data.deleteFlag){
                    window.location.href = "<%=request.getContextPath()%>/admin/wefamily/goMtxPartsCenter?uuid=${machine.uuid}&deleteFlag="+data.deleteFlag;
                }
            });
        },function(){
            //取消删除
        });

    }
</script>

</body>
</html>