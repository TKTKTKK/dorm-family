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
                <div class="col-sm-12">
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <form class="form-horizontal form-bordered" data-validate="parsley" action="${ctx}/admin/autoRep/subscribeRepArticle" method="POST">
                        <section class="panel panel-default m-n">
                            <header class="panel-heading mintgreen">
                                <i class="fa fa-gift"></i>
                                <span class="text-lg">关注时自动回复图文：</span>
                            </header>
                            <div class="panel-body table-responsive">
                                <table class="table table-striped b-t b-light b-l b-r b-b" style="margin:0">
                                    <thead>
                                    <tr>
                                        <th style="width:20px;">&nbsp;</th>
                                        <th data-toggle="class" style="width: 20%">标题</th>
                                        <th style="width: 10%">图片</th>
                                        <th style="width: 30%">图文外连接网址</th>
                                        <th style="width: 20%">简介</th>
                                        <th style="width: 20%">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${respNewsList}" var="respNews" varStatus="stat">
                                        <tr>
                                            <td>
                                                <c:if test="${empty currentNewsId}">
                                                    <c:if test="${stat.index == 0}">
                                                        <label class="radio m-n"><input type="radio" name="newsUuid" value="${respNews.uuid}" checked><i></i></label>
                                                    </c:if>
                                                    <c:if test="${stat.index != 0}">
                                                        <label class="radio m-n"><input type="radio" name="newsUuid" value="${respNews.uuid}"><i></i></label>
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${not empty currentNewsId}">
                                                    <c:if test="${currentNewsId == respNews.uuid}">
                                                        <label class="radio m-n"><input type="radio" name="newsUuid" value="${respNews.uuid}" checked><i></i></label>
                                                    </c:if>
                                                    <c:if test="${currentNewsId != respNews.uuid}">
                                                        <label class="radio m-n"><input type="radio" name="newsUuid" value="${respNews.uuid}"><i></i></label>
                                                    </c:if>
                                                </c:if>
                                            </td>
                                            <td style="word-wrap: break-word;word-break:break-all;">${respNews.firstRespArticle.title}</td>
                                            <td>
                                                <c:if test="${not empty respNews.firstRespArticle.picurl}">
                                                    <img src="${respNews.firstRespArticle.picurl}" width="50" height="50">
                                                </c:if>
                                            </td>
                                            <td style="word-wrap: break-word;word-break:break-all;">${respNews.firstRespArticle.url}</td>
                                            <td style="word-wrap: break-word;word-break:break-all;">${respNews.firstRespArticle.decription}</td>
                                            <td>
                                                <a href="${ctx}/admin/autoRep/addArticle?newsid=${respNews.uuid}">查看图文集详情</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <web:pagination pageList="${respNewsList}"/>
                            </div>
                            <div>
                                <input type="hidden" name="versionno" value="${versionno}">
                            </div>
                            <div class="text-center panel-body">
                                <button type="submit" class="btn btn-submit btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                                <a href="${ctx}/admin/autoRep/subscribeRepTxt" class="btn btn-default btn-s-xs">切换到文本模式</a>
                                <a href="${ctx}/admin/autoRep/subscribeRepImg" class="btn btn-info btn-s-xs">切换到图片模式</a>
                            </div>
                        </section>
                    </form>
                </div>
                <div class="col-sm-3">
                </div>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<script type="text/javascript">


    //图文集界面
    function toArticleSet(){
        window.location.href = "<%=request.getContextPath()%>/admin/autoRep/showArticleSet";
    }



</script>
</body>
</html>