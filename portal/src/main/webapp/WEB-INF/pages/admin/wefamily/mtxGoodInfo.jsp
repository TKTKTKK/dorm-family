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
                会员管理 /
                <a href="${ctx}/admin/wefamily/mtxGoodManage">商品管理 </a> /
                <span class="font-bold  text-shallowred"> 商品详情</span>
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
                            <span class="text-lg">商品详情：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>名称：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="name" id="name"
                                           data-maxlength="48"
                                           onblur="trimText(this)"
                                           value="${mtxProduct.name}">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-3 control-label"><span class="text-danger">*</span>积分：</div>
                                <div class="col-sm-9 b-l bg-white">
                                    <input class="form-control" type="number" name="points" value="${mtxProduct.points}"
                                           id="points" data-maxlength="11"
                                           data-required="true">
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
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>图片：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <div id="imgStyle" style="width: 265px">
                                    <input type="file" name="imgfile" class="filestyle" id="imgfile" data-icon="false" data-classButton="btn btn-default"
                                           data-classInput="form-control inline v-middle input-s"
                                           id="value"
                                    ></div>
                                    <span id="imgError" class="text-danger"></span>
                                    <input type="text" class="hidden" name="img" id="img" value="${mtxProduct.img}">
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
                                <label class="col-sm-3 control-label"><span class="text-danger"></span>商品详情：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <textarea  class="form-control" name="detail" style="width:400px; height:100px;" data-maxlength="256">${mtxProduct.detail}</textarea>
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
                            <a onclick="submitForm()" class="btn btn-submit btn-s-xs ">
                                <i class="fa fa-check"></i>&nbsp;提&nbsp;交
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
        showParentMenu('会员管理');
        if(${mtxProduct.img!=null && mtxProduct.img!=''}){
            $('#imgDiv').removeClass('hidden');
        }
    }
    function validImg(){
        var imgError=document.getElementById("imgError");
        imgError.innerHTML="";
        var imgfile=$("#imgfile").val();
        var img=$("#img").val();
        if((imgfile==null||imgfile=='')&&(img==null||img=='')){
            $("#imgStyle").css("border","1px solid red");
            imgError.innerHTML="该项为必填项."
            return false;
        }else{
            $("#imgStyle").css("border","none");
            return true;
        }
    }
    function submitForm(){
        $("#frm").parsley("validate");
        if($('#frm').parsley().isValid()&&validImg()){
            var searchForm = document.getElementById("frm");
            searchForm.action = "${ctx}/admin/wefamily/updateMtxGood";
            searchForm.submit();
        }
    }
</script>

</body>
</html>