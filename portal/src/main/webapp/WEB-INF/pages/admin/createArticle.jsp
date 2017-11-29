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
            <header class="panel-heading bg-white text-md b-b">
                自动回复 /
                <a href="${ctx}/admin/autoRep/showArticleSet">图文集</a>  /
                <span class="font-bold text-shallowred"> 添加图文</span>
            </header>
            <div class="bg-white closel newclosel">
                <div class="col-sm-12 no-padder">
                    <div>
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <header class="panel-heading mintgreen text-md">
                        <strong>图文集信息：</strong>
                    </header>
                    <div class="table-responsive">
                        <table class="table table-striped b-t b-light  b-l b-r b-b">
                            <thead>
                            <tr>
                                <th data-toggle="class" style="width: 20%">标题</th>
                                <th style="width: 10%">图片</th>
                                <th style="width: 30%">图文外链网址</th>
                                <th style="width: 20%">简介</th>
                                <th style="width: 20%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${respArticleList}" var="respArticle">
                                <tr>
                                    <td>${respArticle.title}</td>
                                    <td style="word-wrap: break-word;word-break:break-all;">
                                        <c:if test="${not empty respArticle.picurl}">
                                            <img src="${web:getFileViewUrl(respArticle.picurl)}" width="50" height="50">
                                        </c:if>
                                    </td>
                                    <td style="word-wrap: break-word;word-break:break-all;">${respArticle.url}</td>
                                    <td style="word-wrap: break-word;word-break:break-all;">${respArticle.decription}</td>
                                    <td>
                                        <div class="text-success" style="display: inline-block">
                                            <a href="${ctx}/admin/autoRep/addArticle?newsid=${respArticle.newsid}&articleId=${respArticle.uuid}">
                                                <button class="btn btn-submit btn-sm">查看详情</button></a>
                                        </div>
                                        <c:if test="${not empty respArticle.detailcontent}">
                                            <div class="text-info" style="display: inline-block">
                                                <a href="${ctx}/admin/autoRep/showArticleDetail?articleId=${respArticle.uuid}">
                                                    <button class="btn btn-blue btn-sm">图文详细内容界面</button></a>
                                            </div>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <web:pagination pageList="${respArticleList}" postParam="true"/>
                    </div>
                </div>
            </div>
                <div class="col-sm-12 bg-white  wrapper-md">
                    <c:if test="${(respArticleCount+1 > 10) && (empty article.uuid)}">
                        <span class="text-info">最多只能添加十条图文！</span>
                    </c:if>
                    <c:if test="${!((respArticleCount+1 > 10) && (empty article.uuid))}">
                        <form class="form-horizontal  form-bordered" data-validate="parsley" action="${ctx}/admin/autoRep/addArticle" method="POST" onsubmit="return addSubscribeArticle()">
                            <section class="panel panel-default m-n">
                                <header class="panel-heading mintgreen">
                                    <i class="fa fa-gift"></i>
                                    <span class="text-lg">图文信息：</span>
                                </header>
                                <div class="panel-body p-0-15">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>标题:</label>
                                        <div class="col-sm-9 b-l bg-white">
                                            <input type="text" name="title" class="form-control" data-required="true" data-maxlength="192" onblur="trimText(this)" id="title" value="${article.title}">
                                            <span id="titleError" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">图片:</label>
                                        <div class="col-sm-9 b-l bg-white">
                                            <div class="col-sm-10 navbar-left" style="padding-left: 0px">
                                                <input type="text" name="picurl" class="form-control" data-maxlength="255" id="picurl" readonly="true" value="${article.picurl}"/>
                                            </div>
                                            <div class="col-sm-2 navbar-left" style="padding-left: 0px">
                                                <div class="bs-example">
                                                    <button type="button" class="btn btn-default" data-toggle="modal" data-target=".bs-example-modal-lg">从图片库选择</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- /.modal -->
                                    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">

                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" id="modelCloseBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h4 class="modal-title" id="myLargeModalLabel">图片库</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <c:if test="${not empty respImageList}">
                                                                <c:forEach items="${respImageList}" var="pictrue" varStatus="status">
                                                                    <div class="col-sm-3 text-center" style="border: 1px dashed #657789; margin-right: 30px; margin-bottom: 30px">
                                                                        <img src="${web:getFileViewUrl(pictrue.imgname)}" width="100%" height="100"/>
                                                                        <c:if test="${status.index == 0}">
                                                                            <input type="radio" name="pic" checked>
                                                                        </c:if>
                                                                        <c:if test="${status.index != 0}">
                                                                            <input type="radio" name="pic">
                                                                        </c:if>
                                                                        <input type="hidden" value="${pictrue.imgname}" id="hidPic${status.index}">
                                                                    </div>
                                                                </c:forEach>
                                                                <div style="clear:both"></div>
                                                                <div class="col-sm-12 text-right">
                                                                    <button type="button" class="btn btn-success" onclick="getSelectedPic()">保存</button>
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${empty respImageList}">
                                                                抱歉，您还未创建图片库，请先去<a href="${ctx}/admin/autoRep/showPictureLib" class="text-info">创建图片库</a>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div><!-- /.modal-content -->
                                        </div><!-- /.modal-dialog -->
                                    </div><!-- /.modal -->
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">图文外链网址:</label>
                                        <div class="col-sm-9 b-l bg-white">
                                            <input type="text" name="url" data-type="url" class="form-control" data-maxlength="600" id="url" value="${article.url}" onblur="trimText(this)">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>简介：</label>
                                        <div class="col-sm-9 b-l bg-white">
                                            <textarea class="form-control" rows="6" name="decription" data-required="true" id="decription" data-maxlength="300" onblur="trimText(this)">${article.decription}</textarea>
                                            <span id="decriptionError" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">图文详细页内容：</label>
                                        <div class="col-sm-9 b-l bg-white">
                                                <%--<textarea name="detailContent" id='detailContent' style="width:100%; height: 200px;" onblur="checkUrlDetailContent();validateChineseText(2048, this.value, 'detailContentError');"></textarea>--%>
                                            <textarea name="detailcontent" id='detailContent' style="width:100%; height: 200px;"  >${article.detailcontent}</textarea>
                                            <span id="detailContentError" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <input type="hidden" name="newsid" value="${newsid}">
                                        <input type="hidden" name="uuid" value="${article.uuid}">
                                        <input type="hidden" name="versionno" value="${article.versionno}">
                                    </div>
                                </div>
                                <div class="panel-footer text-left bg-light lter">
                                    <button type="submit" class="btn btn-submit btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                                </div>
                            </section>
                        </form>
                        <p class="warningword"><i class="fa fa-warning">：</i>1. “图文外链网址”和“图文详细页内容”不能同时填写。</p>
                        <p class="warningword" style="text-indent: 2em">2. 多图文时，最多只能添加十个图文，并且默认第一个为大图。</p>
                    </c:if>
                </div>

        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<%--kind editor--%>
<script charset="utf-8" src="${ctx}/static/admin/editor/kindeditor.js"></script>
<script charset="utf-8" src="${ctx}/static/admin/editor/lang/zh_CN.js"></script>

<script type="text/javascript">

    KindEditor.ready(function(K) {
        window.editor = K.create('#detailContent', {
            uploadJson : '${ctx}/static/editor/jsp/upload_json.jsp',
            fileManagerJson : '${ctx}/static/admin/editor/jsp/file_manager_json.jsp',
            items : ['fullscreen', 'source', 'undo', 'redo', 'print', 'cut', 'copy', 'paste',
                'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
                'superscript', '|', 'selectall', '-',
                'title', 'fontname', 'fontsize', '|', 'textcolor', 'bgcolor', 'bold',
                'italic', 'underline', 'strikethrough', 'removeformat', '|', 'advtable', 'hr', 'image', 'emoticons', 'link', 'unlink']
        });
    });


    //添加关注时自动回复图文
    function addSubscribeArticle(){
//        //验证标题最大长度
//        var titleValid = validateChineseText(60,
//                document.getElementById("title").value, "titleError");
//        //验证简介最大长度
//        var descriptionValid = validateChineseText(60,
//                document.getElementById("decription").value, "decriptionError");
//        //验证图文详细页内容最大长度
//        var detailContentValid = validateChineseText(2048,
//                document.getElementById("detailContent").value, "detailContentError");
        //检查图文外链网址和图文详细页内容是否同时填写了
        var urlDetailContentValid = checkUrlDetailContent();
        if(!urlDetailContentValid){
            return false;
        }
        return true;
    }


    //获取选择的图片
    function getSelectedPic(){
        var picurl = document.getElementById("picurl");
        var pics = document.getElementsByName("pic");
        for(var i=0; i<pics.length; i++){
            if(pics[i].checked){
                var hidPicUrl = document.getElementById("hidPic"+i);
                picurl.value = hidPicUrl.value;
                break;
            }
        }
        var modelCloseBtn = document.getElementById("modelCloseBtn");
        modelCloseBtn.click();
    }

    //图文外链网址和图文详细页内容不能同时填写
    function checkUrlDetailContent(){
        var url = document.getElementById("url").value.trim();
        //要获取值的时候使用sync函数
        window.editor.sync();
        var detailContent = document.getElementById("detailContent").value.trim();
        if(url.length>0 && detailContent.length>0){
            alert("'图文外链网址'和'图文详细页内容'不能同时填写！");
            return false;
        }
        return true;
    }

    //根据newsid查询article
    function searchArticleByNewsId(page){
        window.location.href = "<%=request.getContextPath()%>/admin/autoRep/addArticle?page=" + page+"&newsid=${newsid}";
    }

    function resubmitSearch(page){
        searchArticleByNewsId(page);
    }


</script>
</body>
</html>