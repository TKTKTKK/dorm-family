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
        <section class="scrollable padder">
            <header class="panel-heading">
                卡券 》 <span class="font-bold  text-black"> 商家信息</span>
            </header>
            <c:if test="${not empty wechatBinding && not empty wechatBinding.appid && not empty wechatBinding.appsecret}">
                <div class="row">
                    <div class="col-sm-2">
                    </div>
                    <div class="col-sm-8">
                        <div style="margin-bottom: 5px">
                            <span class="text-success">${successMessage}</span>
                            <span class="text-danger">${errorMessage}</span>
                        </div>
                        <form class="form-horizontal" data-validate="parsley" action="${ctx}/admin/card/brandInfo" method="POST" enctype="multipart/form-data" id="frm" onsubmit="return addBrandInfo()">
                            <section class="panel panel-default">
                                <header class="panel-heading">
                                    <strong>商家信息：</strong>
                                </header>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>商家名称:</label>
                                        <div class="col-sm-9">
                                            <input type="text" name="brand_name" class="form-control" data-required="true" data-maxlength="24" onblur="trimText(this),validateChineseTextForTwo(24, this, 'brand_nameError')"
                                                   id="brand_name" value="${brand_name}">
                                            <span id="brand_nameError" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>商家LOGO:</label>
                                        <div class="col-sm-6">
                                            <c:if test="${not empty logoname || not empty logo_url}">
                                                <input type="file" name="picture" id="pictureId" value="${logoname}" class="filestyle" data-icon="false" data-classButton="btn btn-default" data-classInput="form-control inline v-middle input-s" onchange="uploadFile()">
                                            </c:if>
                                            <c:if test="${empty logoname && empty logo_url}">
                                                <input type="file" name="picture" id="pictureId" value="${logoname}" class="filestyle" data-icon="false" data-classButton="btn btn-default"
                                                       data-classInput="form-control inline v-middle input-s" data-required="true" onchange="uploadFile()">
                                            </c:if>
                                        </div>
                                        <div class="col-sm-3">
                                            <input type="hidden" name="logoname" id="logonameId" value="${logoname}">
                                            <c:if test="${not empty logoname}">
                                                <br/><br/>
                                                <img src="${web:getFileViewUrl(logoname)}" width="100" height="100">
                                            </c:if>
                                            <c:if test="${not empty logo_url}">
                                                <br/><br/>
                                                <img src="${web:getFileViewUrl(logo_url)}" width="100" height="100">
                                            </c:if>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-6">
                                            <span id="pictureError" class="text-danger"></span>
                                        </div>
                                        <div class="col-sm-3"></div>
                                    </div>
                                </div>
                                <div>
                                    <input type="hidden" name="versionno" value="${wechatBinding.versionno}">
                                </div>
                                <footer class="panel-footer text-right bg-light lter">
                                    <button type="submit" class="btn btn-success btn-s-xs">提 交</button>
                                </footer>
                            </section>
                        </form>
                        <p class="font-bold">说明：</p>
                        <p style="text-indent: 2em">1. 图片大小不能超过2M，像素：300*300，格式：bmp，png，jpeg，jpg。</p>
                    </div>
                    <div class="col-sm-2">
                    </div>
                </div>
            </c:if>
            <c:if test="${empty wechatBinding}">
                <span>您还没有添加公众号，请先去</span>
                <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
            </c:if>
            <c:if test="${not empty wechatBinding && (empty wechatBinding.appid || empty wechatBinding.appsecret)}">
                <span>您尚未被授权，请先进行 <a href="${ctx}/admin/account/authorizationSetting"  class="text-info">授权设置</a> 。</span>
            </c:if>
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
        var imgname = document.getElementById('logonameId').value;
        var type = '';
        //提交时
        if(pic.length == 0){
            type = imgname.substr(imgname.lastIndexOf('.')+1);
        }else{
            //预览时
            type = pic.substr(pic.lastIndexOf('.')+1);
        }
        //格式：bmp，png，jpeg，jpg，gif。
        if(type != '' && type != 'bmp' && type != 'png' && type != 'jpeg' && type != 'jpg'){
            pictureError.innerHTML = "图片格式不合法。（格式只允许：bmp，png，jpeg，jpg）";
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


    //添加商家信息
    function addBrandInfo(){
        var brand_name = document.getElementById('brand_name');
        //检查商家名称
        var brandNameValid = validateChineseTextForTwo(24, brand_name, 'brand_nameError');

        //检查图片格式
        var picTypeValid = checkPicType();

        if(!brandNameValid || !picTypeValid){
            return false;
        }

        return true;
    }
</script>
</body>
</html>