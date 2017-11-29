<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>

</head>
<body class="">

<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-md b-b">
                自动回复 / <span class="font-bold  text-shallowred">关注时自动回复</span>
            </header>
                <div class="col-sm-12 pos">
                    <c:if test="${not empty wechatBinding}">
                            <div>
                                <span class="text-success">${successMessage}</span>
                                <span class="text-danger">${errorMessage}</span>
                            </div>
                            <form class="form-horizontal form-bordered" data-validate="parsley" action="${ctx}/admin/autoRep/subscribeRepTxt" method="POST">
                                <section class="panel panel-default m-n">
                                    <header class="panel-heading mintgreen">
                                        <i class="fa fa-gift"></i>
                                        <span class="text-lg">关注时自动回复文本：</span>
                                    </header>
                                    <div class="panel-body p-0-15">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label"><span class="text-danger">*</span>自动回复内容：</label>
                                            <div class="col-sm-9  b-l bg-white">
                                                <textarea class="form-control" rows="6" name="content" data-required="true" id="txtContent" data-maxlength="600" onblur="trimText(this)">${respSetting.content}</textarea>
                                                <span id="txtContentError" class="text-danger"></span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <input type="hidden" name="versionno" value="${respSetting.versionno}">
                                            <input type="hidden" name="resptype" value="text">
                                        </div>
                                    </div>
                                    <div class="panel-footer text-left bg-light lter">
                                        <button type="submit" class="btn btn-submit btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                                        <a href="${ctx}/admin/autoRep/subscribeRepArticle" class="btn btn-default btn-s-xs">切换到图文模式</a>
                                        <a href="${ctx}/admin/autoRep/subscribeRepImg" class="btn btn-info btn-s-xs">切换到图片模式</a>
                                    </div>
                                </section>
                            </form>
                            <p class="warningword line-lg"><i class="fa fa-warning"></i>关注时自动回复：指粉丝关注微信公众号后推送的第一条信息，可以是文本、图文、图片，如果需要图文回复，点击“切换到图文模式”。</p>
                            <p style="text-indent: 2em"><span class="font-bold text-black"></span></p>
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


</body>
</html>