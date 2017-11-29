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
                自动回复 / <span class="font-bold  text-shallowred">关键词自动回复</span>
            </header>
                <div class="col-sm-12 pos">
                    <div  style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <form class="form-horizontal  form-bordered" data-validate="parsley" action="${ctx}/admin/autoRep/keywordNoMatchRepTxt" method="POST" style="margin-top: 20px" >
                        <section class="panel panel-default m-n">
                            <header class="panel-heading mintgreen">
                                <i class="fa fa-gift"></i>
                                <span class="text-lg">关键词无匹配自动回复文本：</span>
                            </header>
                            <div class="panel-body p-0-15">
                                <div class="checkbox i-checks form-group no-padder">
                                    <label class="col-sm-3"></label>
                                    <label class="col-sm-9  b-l bg-white">
                                        <c:if test="${respSetting.reqtype == 'CLICK'}">
                                            <input type="checkbox" name="reqClick" checked style="margin-left: 7px"><i></i> 自定义菜单回复？
                                        </c:if>
                                        <c:if test="${respSetting.reqtype != 'CLICK'}">
                                            <input type="checkbox" name="reqClick" style="margin-left: 7px"><i></i> 自定义菜单回复？
                                        </c:if>
                                    </label>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>自动回复内容：</label>
                                    <div class="col-sm-9  b-l bg-white">
                                        <textarea class="form-control" rows="6" name="content" data-required="true" id="txtContent" data-maxlength="300" onblur="trimText(this)">${respSetting.content}</textarea>
                                        <span id="txtContentError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="hidden" name="uuid" value="${respSetting.uuid}">
                                    <input type="hidden" name="versionno" value="${respSetting.versionno}">
                                </div>
                            </div>
                            <div class="panel-footer text-left bg-light lter">
                                <button type="submit" class="btn btn-submit btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                                <c:if test="${empty respSetting.uuid}">
                                    <a href="${ctx}/admin/autoRep/keywordRepTxt" class="btn btn-default btn-s-xs">切换到文本模式</a>
                                    <a href="${ctx}/admin/autoRep/keywordRepArticle" class="btn btn-info btn-s-xs">切换到图文模式</a>
                                    <a href="${ctx}/admin/autoRep/keywordAutoRepImg" class="btn btn-success btn-s-xs">切换到图片模式</a>
                                </c:if>
                            </div>
                        </section>
                    </form>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>


</body>
</html>