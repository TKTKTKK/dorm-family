<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                公众号 / <span class="font-bold text-shallowred">授权设置</span>
            </header>
                <div class="col-sm-12 pos">
                    <c:if test="${not empty wechatBinding}">
                            <div>
                                <span class="text-success">${successMessage}</span>
                                <span class="text-danger">${errorMessage}</span>
                            </div>
                            <form class="form-horizontal form-bordered" data-validate="parsley" action="${ctx}/admin/account/authorizationSetting" method="POST">
                                <section class="panel panel-default m-n">
                                    <header class="panel-heading mintgreen">
                                        <i class="fa fa-gift"></i>
                                        <span class="text-lg">请填写如下信息：</span>
                                    </header>
                                    <div class="panel-body p-0-15">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label"><span class="text-danger">*</span>应用id：</label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <c:if test="${not empty wechatBinding.appid}">
                                                    <input type="text" data-type="alphanum" class="form-control" data-required="true" name="appid" value="${wechatBinding.appid}" readonly="true">
                                                </c:if>
                                                <c:if test="${empty wechatBinding.appid}">
                                                    <input type="text" data-type="alphanum" class="form-control" data-required="true" name="appid" value="${wechatBinding.appid}" onblur="trimText(this)">
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">应用秘钥：</label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <input type="text" data-type="alphanum" class="form-control" name="appsecret" data-maxlength="32" value="${wechatBinding.appsecret}" onblur="trimText(this)">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">微信支付商户号：</label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <input type="text" data-type="alphanum" class="form-control" name="wechatpayid" data-maxlength="15" value="${wechatBinding.wechatpayid}" onblur="trimText(this)">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">微信支付加密Key：</label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <input type="text" data-type="alphanum" class="form-control" name="wechatpaykey" data-maxlength="64" value="${wechatBinding.wechatpaykey}" onblur="trimText(this)">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">支付平台ID：</label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <input type="text" data-type="alphanum" class="form-control" name="phpayapiid" data-maxlength="64" value="${wechatBinding.phpayapiid}" onblur="trimText(this)">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">支付平台加密Key：</label>
                                            <div class="col-sm-9 b-l bg-white">
                                                <input type="text" data-type="alphanum" class="form-control" name="phpayapikey" data-maxlength="64" value="${wechatBinding.phpayapikey}" onblur="trimText(this)">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <input type="hidden" name="versionno" value="${wechatBinding.versionno}">
                                            <input type="hidden" name="uuid" value="${wechatBinding.uuid}">
                                        </div>
                                    </div>
                                    <div class="panel-footer text-left bg-light lter">
                                        <button type="submit" class="btn btn-submit btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                                    </div>
                                </section>
                            </form>
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