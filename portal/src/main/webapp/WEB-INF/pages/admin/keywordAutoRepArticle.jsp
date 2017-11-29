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
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <form class="form-horizontal form-bordered" data-validate="parsley" action="${ctx}/admin/autoRep/keywordRepArticle" method="POST" onsubmit="return checkKeyword()">
                        <section class="panel panel-default m-n">
                            <header class="panel-heading mintgreen">
                                <i class="fa fa-gift"></i>
                                <span class="text-lg">关键词自动回复图文：</span>
                            </header>
                            <div class="panel-body p-0-15">
                                <div class="checkbox i-checks form-group no-padder">
                                    <label class="col-sm-3"></label>
                                    <label class="col-sm-9 b-l bg-white">
                                        <c:if test="${respSetting.reqtype == 'CLICK'}">
                                            <input type="checkbox" name="reqClick" checked style="margin-left: 7px"><i></i> 自定义菜单回复？
                                        </c:if>
                                        <c:if test="${respSetting.reqtype != 'CLICK'}">
                                            <input type="checkbox" name="reqClick" style="margin-left: 7px"><i></i> 自定义菜单回复？
                                        </c:if>
                                    </label>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>关键词：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <c:if test="${changePage == 1}">
                                            <textarea class="form-control" rows="6" name="keywords" data-required="true" id="keywords" data-maxlength="30" onblur="checkKeyword()">${keyword}</textarea>
                                        </c:if>
                                        <c:if test="${changePage != 1}">
                                            <textarea class="form-control" rows="6" name="keywords" data-required="true" id="keywords" data-maxlength="30" onblur="checkKeyword()">${respSetting.keywords}</textarea>
                                        </c:if>
                                        <span id="keywordsError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="hidden" name="uuid" value="${respSetting.uuid}">
                                    <input type="hidden" name="versionno" value="${respSetting.versionno}">
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>图文：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <table class="table table-striped b-t b-light b-l b-r">
                                            <thead>
                                            <tr>
                                                <th style="width:20px;">&nbsp;</th>
                                                <th data-toggle="class" style="width: 20%">标题</th>
                                                <th style="width: 10%">图片</th>
                                                <th style="width: 30%;">图文外连接网址</th>
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
                                                                <label class="radio m-n"><input type="radio" name="newsid" value="${respNews.uuid}" checked><i></i></label>
                                                            </c:if>
                                                            <c:if test="${stat.index != 0}">
                                                                <label class="radio m-n"><input type="radio" name="newsid" value="${respNews.uuid}"><i></i></label>
                                                            </c:if>
                                                        </c:if>
                                                        <c:if test="${not empty currentNewsId}">
                                                            <c:if test="${currentNewsId == respNews.uuid}">
                                                                <label class="radio m-n"><input type="radio" name="newsid" value="${respNews.uuid}" checked><i></i></label>
                                                            </c:if>
                                                            <c:if test="${currentNewsId != respNews.uuid}">
                                                                <label class="radio m-n"><input type="radio" name="newsid" value="${respNews.uuid}"><i></i></label>
                                                            </c:if>
                                                        </c:if>
                                                    </td>
                                                    <td style="word-wrap: break-word;word-break:break-all;">${respNews.firstRespArticle.title}</td>
                                                    <td>
                                                        <c:if test="${not empty respNews.firstRespArticle.picurl}">
                                                            <img src="${web:getFileViewUrl(respNews.firstRespArticle.picurl)}" width="50" height="50">
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
                                        <web:pagination pageList="${respNewsList}" postParam="true"/>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer text-left bg-light lter">
                                <button type="submit" class="btn btn-submit btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                                <c:if test="${empty respSetting.uuid}">
                                    <a href="${ctx}/admin/autoRep/keywordRepTxt" class="btn btn-default btn-s-xs">切换到文本模式</a>
                                    <a href="${ctx}/admin/autoRep/keywordNoMatchRepTxt" class="btn btn-info btn-s-xs">无匹配回复</a>
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

<script type="text/javascript">

    //图文集界面
    function toArticleSet(){
        window.location.href = "<%=request.getContextPath()%>/admin/autoRep/showArticleSet";
    }

    //验证关键词合法性
    function checkKeyword(){
        //清空错误信息
        var keywordsErrorSpan = document.getElementById("keywordsError");
        keywordsErrorSpan.innerHTML = "";

        var keywords =  document.getElementById("keywords").value;
        document.getElementById("keywords").value =  keywords.trim();
        if(keywords !="" && keywords == 'DEFAULT_RESP'){
            keywordsErrorSpan.innerHTML = "该项不能为DEFAULT_RESP";
            return false;
        }
        return true;

    }

    //根据settingId查询
    function searchBySettingId(page){
        var keyword = document.getElementById("keywords").value;
        window.location.href = "<%=request.getContextPath()%>/admin/autoRep/keywordRepArticle?page=" + page+"&settingUuid=${respSetting.uuid}&keyword="+keyword+"&changePage=1";
    }

    function resubmitSearch(page){
        searchBySettingId(page);
    }

</script>
</body>
</html>