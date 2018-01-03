<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>

</head>
<body class="">

<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable padder">
            <header class="panel-heading bg-white text-md b-b">
                公众号 /
                <a href="${ctx}/admin/account/search">公众号管理</a> /
                <span class="font-bold  text-shallowred"> 添加公众号</span>
            </header>
                <div class="col-sm-12 pos">
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <form class="form-horizontal form-bordered" data-validate="parsley" action="${ctx}/admin/account/addPublicAccount" method="POST"
                            onsubmit="return checkPubAcc()">
                        <section class="panel panel-default m-n">
                            <header class="panel-heading mintgreen">
                                <i class="fa fa-gift"></i>
                            <span class="text-lg">请填写如下信息：</span>
                            </header>
                            <div class="panel-body p-0-15">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>公众号名称：</label>
                                    <div class="col-sm-9  b-l bg-white">
                                        <input type="text" class="form-control" data-required="true" name="wechatname" id="wechatname" data-maxlength="48"
                                               onblur="trimText(this),validateChineseText(48, this.value, 'wechatnameError')"
                                                value="${wechatBinding.wechatname}">
                                        <span id="wechatnameError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>公众号原始Id：</label>
                                    <div class="col-sm-9  b-l bg-white">
                                        <c:if test="${empty wechatBinding.wechatorigid}">
                                            <input type="text" data-type="alphanum" class="form-control" data-required="true" name="wechatorigid" data-maxlength="32"
                                                   onblur="trimText(this)"
                                                   value="${wechatBinding.wechatorigid}">
                                            <span class="text-muted">请认真填写，错了不能修改。</span>
                                        </c:if>
                                        <c:if test="${not empty wechatBinding.wechatorigid}">
                                            <input type="text" data-type="alphanum" class="form-control" data-required="true" name="wechatorigid" data-maxlength="32"
                                                   onblur="trimText(this)"
                                                   value="${wechatBinding.wechatorigid}"
                                                    readonly>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">微信号：</label>
                                    <div class="col-sm-9  b-l bg-white">
                                            <input type="text" class="form-control"  name="wechatid" data-maxlength="16" onblur="trimText(this)"
                                                   value="${wechatBinding.wechatid}">
                                    </div>
                                </div>
                                <%--<div class="form-group">
                                    <label class="col-sm-3 control-label">社区总称：</label>
                                    <div class="col-sm-9  b-l bg-white">
                                        <input type="text" class="form-control" name="brand_name" id="brand_name" data-maxlength="60"
                                               onblur="trimText(this),validateChineseText(60, this.value, 'brand_nameError')"
                                               value="${wechatBinding.brand_name}">
                                        <span id="brand_nameError" class="text-danger"></span>
                                    </div>
                                </div>--%>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input type="hidden" name="uuid" class="form-control" value="${wechatBinding.uuid}">
                                        <input type="hidden" name="versionno" class="form-control" value="${wechatBinding.versionno}">
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer text-left bg-light lter">
                                <button type="submit" class="btn btn-submit btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                            </div>
                        </section>
                    </form>
                    <div>
                        <p class="warningword"><i class="fa fa-warning">：</i>1. 公众号名称与微信公众平台公众号名称保存一致。</p>
                        <p class="warningword" style="text-indent:2em">2. 公众号原始id，这个很重要，公众平台进行通讯就靠这个ID，所以不能填错。</p>
                    </div>

                </div>
                <div class="col-sm-2">
                </div>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<script>
    //验证公众号信息合法性
    function checkPubAcc(){
        //公众号名称
        var wechatnameValid = validateChineseText(48, document.getElementById('wechatname').value, 'wechatnameError');
        /*//社区总称
        var brand_nameValid = validateChineseText(60, document.getElementById('brand_name').value, 'brand_nameError');*/
        return wechatnameValid;
    }
</script>
</body>
</html>