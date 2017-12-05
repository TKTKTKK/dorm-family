<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>

</head>
<body class="">

<section id="content">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                自动回复 / <span class="font-bold  text-shallowred"> 图片库</span>
            </header>
            <c:if test="${not empty wechatBinding}">
                <div class="bg-white closel">
                    <div class="col-sm-12 no-padder">
                        <form class="form-horizontal form-bordered" data-validate="parsley" action="${ctx}/admin/autoRep/uploadPicture" method="POST" enctype="multipart/form-data" id="frm" onsubmit="return checkPicType()">
                            <section class="panel panel-default m-n">
                                <header class="panel-heading mintgreen">
                                    <i class="fa fa-gift"></i>
                                    <span class="text-lg">上传图片：</span>
                                </header>
                                <div class="panel-body p-0-15">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>图片：</label>
                                        <div class="col-sm-9 b-l bg-white">
                                        <div class="col-sm-12">
                                            <c:if test="${not empty image.imgname}">
                                                <%--<input type="file" name="picture" id="pictureId" value="${image.imgname}" class="filestyle" data-icon="false" data-classButton="btn btn-default" data-classInput="form-control inline v-middle input-s" onchange="uploadFile()">--%>
                                                <input type="file" name="picture" id="pictureId" onchange="uploadFile()">
                                            </c:if>
                                            <c:if test="${empty image.imgname}">
                                                <%--<input type="file" name="picture" id="pictureId" value="${image.imgname}" class="filestyle" data-icon="false" data-classButton="btn btn-default" data-classInput="form-control inline v-middle input-s" data-required="true" onchange="uploadFile()">--%>
                                                <input type="file" name="picture" id="pictureId" onchange="uploadFile()" data-required="true">
                                            </c:if>
                                        </div>
                                        <div class="col-sm-12">
                                            <input type="hidden" name="imgname" id="imgnameId" value="${image.imgname}">
                                            <c:if test="${not empty image.imgname}">
                                                <br/><br/>
                                                <img src="${image.imgname}" width="100" height="100">
                                            </c:if>
                                        </div>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-6">
                                            <span id="pictureError" class="text-danger"></span>
                                        </div>
                                        <div class="col-sm-3"></div>
                                    </div>
                                    <div class="form-group checkbox i-checks">
                                        <label class="col-sm-3"></label>
                                        <label class="col-sm-9">
                                            <input type="checkbox" name="uploadToServer" id="uploadToServer"><i></i> 上传到服务器？
                                        </label>
                                    </div>
                                </div>
                                <div class="panel-footer text-left bg-light lter">
                                    <button type="submit" class="btn btn-submit btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                                </div>
                            </section>
                        </form>
                        <p class="warningword"><i class="fa fa-warning">：</i>1. 图片大小不能超过2M，格式：bmp，png，jpeg，jpg，gif。</p>
                        <p class="warningword" style="text-indent: 2em">2. 点击图片库中的图片，可查看大图。</p>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="line line-dashed b-b line-lg pull-in b-dark"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <c:forEach items="${respImageList}" var="picture" varStatus="status">
                            <div class="col-sm-2" style="padding-bottom: 30px; cursor: pointer;" data-toggle="modal" data-target=".bs-example-modal-lg${status.index}">
                                <img src="${picture.imgname}" width="100%" height="150"/>
                            </div>
                            <!-- /.modal -->
                            <div class="modal fade bs-example-modal-lg${status.index}" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">

                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" id="modelCloseBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                            <h4 class="modal-title" id="myLargeModalLabel">大图</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <img src="${picture.imgname}" width="100%" height="100%"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!-- /.modal-content -->
                                </div><!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->
                        </c:forEach>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty wechatBinding}">
                <span>您还没有添加公众号，请先去</span>
                <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
            </c:if>
                </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<script type="text/javascript">

    //检查图片格式
    function checkPicType(){
        var pictureError = document.getElementById('pictureError');
        pictureError.innerHTML = '';

        var pic = document.getElementById('pictureId').value;
        var imgname = document.getElementById('imgnameId').value;
        var type = '';
        //提交时
        if(pic.length == 0){
            type = imgname.substr(imgname.lastIndexOf('.')+1);
        }else{
            //预览时
            type = pic.substr(pic.lastIndexOf('.')+1);
        }
        //格式：bmp，png，jpeg，jpg，gif。
        if(type != '' && type != 'bmp' && type != 'png' && type != 'jpeg' && type != 'jpg' && type != 'gif'){
            pictureError.innerHTML = "图片格式不合法。（格式只允许：bmp，png，jpeg，jpg，gif）";
            return false;
        }
        return true;
    }

    //上传文件
    function uploadFile(){
        //检查图片格式
        if(checkPicType()){
            var frm = document.getElementById("frm");
            frm.submit();
        }
    }
</script>
</body>
</html>