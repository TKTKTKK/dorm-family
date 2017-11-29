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
                自动回复 / <span class="font-bold  text-shallowred"> 图文集 </span>
            </header>
            <div class="bg-white closel">
                <div class="col-sm-12 no-padder">
                    <c:if test="${not empty wechatBinding}">
                        <div style="margin-bottom: 5px">
                            <button class="btn btn-sm btn-submit" onclick="toAddArticle()"> 添加图文</button>
                            <span class="text-success">${successMessage}</span>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-striped b-t b-light b-b b-l b-r">
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
                                <c:forEach items="${respNewsList}" var="respNews">
                                    <tr>
                                        <td style="word-wrap: break-word;word-break:break-all;">${respNews.firstRespArticle.title}</td>
                                        <td>
                                            <c:if test="${not empty respNews.firstRespArticle.picurl}">
                                                <img src="${web:getFileViewUrl(respNews.firstRespArticle.picurl)}" width="50" height="50">
                                            </c:if>
                                        </td>
                                        <td style="word-wrap: break-word;word-break:break-all;">${respNews.firstRespArticle.url}</td>
                                        <td style="word-wrap: break-word;word-break:break-all;">${respNews.firstRespArticle.decription}</td>
                                        <td>
                                            <a href="${ctx}/admin/autoRep/addArticle?newsid=${respNews.uuid}"
                                               class="btn btn-sm btn-submit" style="color:white">
                                                查看图文集详情</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <web:pagination pageList="${respNewsList}"/>
                    </c:if>
                    <c:if test="${empty wechatBinding}">
                        <span>您还没有添加公众号，请先去</span>
                        <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
                    </c:if>
                </div>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>


<script type="text/javascript">

    //添加关注时自动回复图文
    function addSubscribeArticle(){
        //验证标题最大长度
        var titleValid = validateChineseText(60,
                document.getElementById("title").value, "titleError");
        //验证简介最大长度
        var descriptionValid = validateChineseText(60,
                document.getElementById("title").value, "titleError");
        if(!titleValid && !descriptionValid){
            return false;
        }
        return true;
    }

    //添加图文界面
    function toAddArticle(){
        window.location.href = "<%=request.getContextPath()%>/admin/autoRep/addArticle";
        <%--window.location.href = "<%=request.getContextPath()%>/admin/autoRep/addArticle2";--%>
    }
</script>
</body>
</html>