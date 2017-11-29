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
                卡券 》 <span class="font-bold  text-black"> 查询卡券</span>
            </header>
            <c:if test="${not empty wechatBinding && not empty wechatBinding.appid && not empty wechatBinding.appsecret && not empty wechatBinding.brand_name && not empty wechatBinding.logo_url}">
                <div class="row">
                    <div class="col-sm-12">
                        <div style="margin-bottom: 5px">
                            <span class="text-success">${successMessage}</span>
                            <span class="text-danger">${errorMessage}</span>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-striped b-t b-light b-b">
                                <thead>
                                <tr>
                                    <th width="10%">商家LOGO</th>
                                    <th width="20%">商家名称</th>
                                    <th width="20%">卡券类型</th>
                                    <th width="20%">卡券标题</th>
                                    <th width="10%">销券方式</th>
                                    <th width="10%">状态</th>
                                    <th width="10%">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${wechatBaseCardList}" var="card" varStatus="stat">
                                    <tr>
                                        <td>
                                            <%--<img src="${ctx}/static/admin/img/logo.png" width="50" height="50">--%>
                                                <img src="${web:getFileViewUrl(card.logo_url)}" width="50" height="50">
                                        </td>
                                        <td>
                                                ${card.brand_name}
                                        </td>
                                        <td>
                                            <c:if test="${card.card_type == 'MEMBER_CARD'}">
                                                会员卡
                                            </c:if>
                                            <c:if test="${card.card_type == 'GENERAL_COUPON'}">
                                                优惠券
                                            </c:if>
                                        </td>
                                        <td>
                                                ${card.title}
                                        </td>
                                        <td>
                                            <c:if test="${card.code_type == 'CODE_TYPE_QRCODE'}">
                                                <c:if test="${not empty card.ticket}">
                                                    <div class="col-sm-2" style="padding-bottom: 30px; cursor: pointer;" data-toggle="modal" data-target=".bs-example-modal-lg${stat.index}">
                                                        <img src="https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=${card.ticket}" width="50" height="50">
                                                    </div>
                                                    <!-- /.modal -->
                                                    <div class="modal fade bs-example-modal-lg${stat.index}" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog modal-lg">
                                                            <div class="modal-content">

                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal" id="modelCloseBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                                    <h4 class="modal-title" id="myLargeModalLabel">${card.title} 二维码</h4>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <div class="row">
                                                                        <div class="col-sm-12" style="text-align: center">
                                                                            <img src="https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=${card.ticket}" width="50%" height="50%"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div><!-- /.modal-content -->
                                                        </div><!-- /.modal-dialog -->
                                                    </div>
                                                    <!-- /.modal -->
                                                </c:if>
                                            </c:if>
                                            <c:if test="${card.code_type == 'CODE_TYPE_TEXT'}">
                                                仅卡券号
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${card.status == 'INIT'}">
                                                待审核
                                            </c:if>
                                            <c:if test="${card.status == 'APP'}">
                                                审核通过
                                            </c:if>

                                            <c:if test="${card.status == 'REJ'}">
                                                审核拒绝
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${empty card.ticket}">
                                                <div>
                                                    <a href="${ctx}/admin/card/creaetQrCode?baseCardId=${card.uuid}">生成二维码</a>
                                                </div>
                                            </c:if>
                                            <div>
                                                <a href="${ctx}/admin/card/cardInfo?baseCardId=${card.uuid}">卡券详情</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <p><span class="font-bold">注：</span>点击二维码可查看大图，供扫描。</p>
            </c:if>
            <c:if test="${empty wechatBinding}">
                <span>您还没有添加公众号，请先去</span>
                <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
            </c:if>
            <c:if test="${not empty wechatBinding && (empty wechatBinding.appid || empty wechatBinding.appsecret)}">
                <span>您尚未被授权，请先进行 <a href="${ctx}/admin/account/authorizationSetting"  class="text-info">授权设置</a> 。</span>
            </c:if>
            <c:if test="${not empty wechatBinding && not empty wechatBinding.appid && not empty wechatBinding.appsecret && (empty wechatBinding.brand_name || empty wechatBinding.logo_url)}">
                <span>商家信息不完整，请完善 <a href="${ctx}/admin/card/brandInfo"  class="text-info">商家信息</a> 。</span>
            </c:if>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<script type="text/javascript">


</script>
</body>
</html>