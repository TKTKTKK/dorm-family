<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <%--<link href="${ctx}/static/admin/css/sweetalert.css" rel="stylesheet">--%>
        <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
</head>
<body class="">

<section id="content">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-lg">
                自动回复 / <span class="font-bold text-shallowred">关键词自动回复</span>
            </header>
            <div class="bg-white closel">
                <div class="col-sm-12 no-padder">
                    <c:if test="${not empty wechatBinding}">
                        <div style="margin-bottom: 5px">
                            <span class="text-success">${successMessage}</span>
                            <span class="text-danger">${errorMessage}</span>
                        </div>
                        <p>
                            <a href="${ctx}/admin/autoRep/keywordRepTxt" class="btn btn-default btn-s-xs">文本模式</a>
                            <a href="${ctx}/admin/autoRep/keywordRepArticle" class="btn btn-success btn-s-xs" style="color: #fff">图文模式</a>
                            <a href="${ctx}/admin/autoRep/keywordAutoRepImg" class="btn btn-info btn-s-xs" style="color: #fff">图片模式</a>
                            <a href="${ctx}/admin/autoRep/keywordNoMatchRepTxt" class="btn btn-submit btn-s-xs" style="color: #fff">无匹配回复</a>
                        </p>
                        <div class="table-responsive">
                            <table class="table table-striped b-t b-light b-b b-l b-r">
                                <thead>
                                <tr>
                                    <th data-toggle="class">关键词</th>
                                    <th>回复方式</th>
                                    <th>请求方式</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${respSettingList}" var="respSetting">
                                    <tr>
                                        <td>
                                            <c:if test="${respSetting.keywords == 'DEFAULT_RESP'}">
                                                <span class="text-warning-dker">无匹配时</span>
                                            </c:if>
                                            <c:if test="${respSetting.keywords != 'DEFAULT_RESP'}">
                                                ${respSetting.keywords}
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${respSetting.resptype == 'text'}">
                                                <span>回复文本</span>
                                            </c:if>
                                            <c:if test="${respSetting.resptype == 'news'}">
                                                <span>回复图文</span>
                                            </c:if>
                                            <c:if test="${respSetting.resptype == 'image'}">
                                                <span>回复图片</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${respSetting.reqtype == 'text'}">
                                                <span>文本</span>
                                            </c:if>
                                            <c:if test="${respSetting.reqtype == 'CLICK'}">
                                                <span>点击自定义菜单</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${respSetting.resptype == 'text'}">
                                                <c:if test="${respSetting.keywords != 'DEFAULT_RESP'}">
                                                    <a href="${ctx}/admin/autoRep/keywordRepTxt?settingUuid=${respSetting.uuid}"
                                                       class="btn btn-sm btn-submit" style="color:white">
                                                        查看详情</a>
                                                </c:if>
                                                <c:if test="${respSetting.keywords == 'DEFAULT_RESP'}">
                                                    <a href="${ctx}/admin/autoRep/keywordNoMatchRepTxt?settingUuid=${respSetting.uuid}"
                                                       class="btn btn-sm btn-submit" style="color:white">
                                                        查看详情</a>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${respSetting.resptype == 'news'}">
                                                <a href="${ctx}/admin/autoRep/keywordRepArticle?settingUuid=${respSetting.uuid}"
                                                   class="btn btn-sm btn-submit" style="color:white">
                                                    查看详情</a>
                                            </c:if>
                                            <c:if test="${respSetting.resptype == 'image'}">
                                                <a href="${ctx}/admin/autoRep/keywordAutoRepImg?settingUuid=${respSetting.uuid}"
                                                   class="btn btn-sm btn-submit" style="color:white">
                                                    查看详情</a>
                                            </c:if>

                                            <a class="btn btn-danger btn-sm a-noline"
                                               onclick="deleteKeywordAutoRep('${respSetting.uuid}')"
                                               style="color: #fff">删除</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <web:pagination pageList="${respSettingList}"/>
                        </div>
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

<%--<script src="${ctx}/static/admin/js/sweetalert.min.js"></script>--%>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">

    //验证关键词合法性
    function checkKeyword(){
        //验证关键词最大长度
        var keywordValid = validateChineseText(255,
                document.getElementById("keywords").value, "keywordsError");
        if(!keywordValid){
            return false;
        }
        var keywordsErrorSpan = document.getElementById("keywordsError");
        var keywords =  document.getElementById("keywords").value.trim();
        if(keywords !="" && keywords == 'DEFAULT_RESP'){
            keywordsErrorSpan.innerHTML = "该项不能为DEFAULT_RESP";
            return false;
        }
        return true;

    }

    //添加关键词自动回复文本
    function addKeywordTxt(){
        //验证关键词
        var keywordValid = checkKeyword();
        //验证自动回复文本最大长度
        var txtValid = validateChineseText(2048,
                document.getElementById("txtContent").value, "txtContentError");
        if(!keywordValid || !txtValid){
            return false;
        }
        return true;
    }


    //删除关键词自动回复
    function deleteKeywordAutoRep(respSettingId){
        <%--swal({--%>
            <%--title: "确定删除?",--%>
            <%--text: "你将删除该关键词自动回复信息!",--%>
            <%--type: "warning",--%>
            <%--showCancelButton: true,--%>
            <%--confirmButtonColor: "#DD6B55",--%>
            <%--confirmButtonText: "确定",--%>
            <%--closeOnConfirm: false--%>
        <%--}, function () {--%>
            <%--window.location.href = "${ctx}/admin/autoRep/deleteKeywordAutoReply?respSettingId="+respSettingId;--%>
        <%--});--%>
        qikoo.dialog.confirm('确定删除？',function(){
            //确定
            window.location.href = "${ctx}/admin/autoRep/deleteKeywordAutoReply?respSettingId="+respSettingId;
        },function(){
            //取消
        });
    }
</script>
</body>
</html>