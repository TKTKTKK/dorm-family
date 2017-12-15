<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
<style>
    .money{
        margin-top: 10px;
    }
</style>
</head>
<body class="">

<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                满田星 /
                <a href="${ctx}/admin/wefamily/MtxProduct">产品管理 </a> /
                <span class="font-bold  text-shallowred"> 产品详情</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="" method="POST"
                      enctype="multipart/form-data" id="frm">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">产品详情：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>产品型号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="model" id="model"
                                           data-maxlength="48"
                                           onblur="trimText(this)"
                                           value="${mtxProduct.model}">
                                    <sapn id="modelError" class="text-danger"></sapn>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>名称：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="name" id="name"
                                           data-maxlength="60"
                                           onblur="trimText(this)"
                                           value="${mtxProduct.name}">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-3 control-label"><span class="text-danger">*</span>价格：</div>
                                <div class="col-sm-9 b-l bg-white">
                                    <div class="col-sm-8 col-xs-11" style="padding-left: 0">
                                        <input class="form-control" type="text" name="price" value="${mtxProduct.price}"
                                               id="price"
                                               data-maxlength="10"
                                               data-required="true"
                                               onblur="validateMoney(this,'priceError')">
                                        <div class="text-danger" id="priceError"></div>
                                    </div>
                                    <div class="col-sm-1 col-xs-1 my-unit money">元</div>
                                    <div style="clear: both"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>状态：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <select class="form-control" id="status" name="status" data-required="true">
                                        <option value="">--全部--</option>
                                        <c:set var="typeList" value="${web:queryCommonCodeList('PRODUCT_STATUS')}"></c:set>
                                        <c:forEach items="${typeList}" var="typeCode">
                                            <c:if test="${mtxProduct.status == typeCode.code}">
                                                <option value="${typeCode.code}" selected>${typeCode.codevalue}</option>
                                            </c:if>
                                            <c:if test="${mtxProduct.status != typeCode.code}">
                                                <option value="${typeCode.code}">${typeCode.codevalue}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger"></span>图片：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="file" name="imgfile" class="filestyle"  data-icon="false" data-classButton="btn btn-default"
                                           data-classInput="form-control inline v-middle input-s"
                                           id="value"
                                    >
                                    <input type="text" class="hidden" name="img" value="${mtxProduct.img}">
                                    <div class="hidden" id="imgDiv" style="margin-top: 20px">
                                        <img src="${mtxProduct.img}" width="100" height="100"
                                             data-toggle="modal" data-target=".bs-example-modal-lg1"
                                             class="hover-pointer">
                                    </div>


                                    <!-- /.modal -->
                                    <div class="modal fade bs-example-modal-lg1" tabindex="-1" role="dialog" aria-labelledby="myLargePicModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">

                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" id="modelPicCloseBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h4 class="modal-title" id="myLargePicModalLabel">大图</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <img src="${mtxProduct.img}" width="100%" height="100%" id="showLargePic"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div><!-- /.modal-content -->
                                        </div><!-- /.modal-dialog -->
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger"></span>产品详情：</label>
                                <div class="col-sm-9 b-l bg-white" style="margin-top: 10px;margin-bottom: 10px">
                                    <textarea name="detail" id="notificationContent" style="width:100%; height: 350px;">${mtxProduct.detail}</textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${mtxProduct.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${mtxProduct.versionno}">
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
        showParentMenu('满田星');
        if(${mtxProduct.img!=null && mtxProduct.img!=''}){
            $('#imgDiv').removeClass('hidden');
        }
        if('${mtxProduct.price}'.length > 0){
            formatMoney(document.getElementById('price'));
        }
    }
    KindEditor.ready(function(K) {
        window.editor = K.create('#notificationContent', {
            uploadJson : '${ctx}/static/editor/jsp/upload_json.jsp',
            fileManagerJson : '${ctx}/static/editor/jsp/file_manager_json.jsp',
            items : ['fullscreen', 'source', 'undo', 'redo', 'print', 'cut', 'copy', 'paste',
                'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'lineheight','subscript',
                'superscript', '|', 'selectall', '-',
                'title', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                'italic', 'underline', 'strikethrough', 'removeformat', '|', 'advtable', 'hr', 'image', 'link', 'unlink']
        });

    });
    function validModelIsExist(){
        var modelError=document.getElementById("modelError");
        var uuid='${mtxProduct.uuid}';
        modelError.innerHTML="";
        var model=$("#model").val();
        if(model.length>0){
            $.post("${ctx}/admin/wefamily/validModelIsExist?model="+model+"&uuid="+uuid,function(data){
                if(data){
                    var searchForm = document.getElementById("frm");
                    searchForm.action = "${ctx}/admin/wefamily/updateMtxProduct";
                    searchForm.submit();
                }else{
                    modelError.innerHTML="此型号已存在，请换一个试试！"
                }
            });
        }
    }
    function submitForm(){
        $("#frm").parsley("validate");
        if(validateMoney(document.getElementById('price'),'priceError') && $('#frm').parsley().isValid()){
            validModelIsExist();
        }
    }
</script>

</body>
</html>