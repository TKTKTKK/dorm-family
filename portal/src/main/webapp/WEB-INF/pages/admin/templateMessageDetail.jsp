<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                系统 /
                <a href="${ctx}/admin/account/templateMessageSetting">模板消息</a> /
                <span class="font-bold text-shallowred">模板详情</span>
            </header>
                <div class="col-sm-12  pos">
                    <div style="margin-bottom: 5px">
                        <span class="text-success">${successMessage}</span>
                        <span class="text-danger">${errorMessage}</span>
                    </div>
                    <form class="form-horizontal form-bordered" data-validate="parsley" action="${ctx}/admin/account/templateMessageDetail" method="POST"
                          id="frm">
                        <section class="panel panel-default m-n">
                            <header class="panel-heading mintgreen">
                                <i class="fa fa-gift"></i>
                                <span class="text-lg">模板详情：</span>
                            </header>
                            <div class="panel-body p-0-15">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>模板名称：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <input type="text" class="form-control" id="tmname" name="tmname"
                                               value="${wechatTm.tmname}" readonly/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><span class="text-danger">*</span>模板ID：</label>
                                    <div class="col-sm-9 b-l bg-white">
                                        <input type="text" name="tmid" value="${wechatTm.tmid}"
                                               data-maxlength="60"
                                               data-required="true"
                                               class="form-control"
                                               onblur="trimText(this)"
                                               id="tmid">
                                        <span id="tmidError" class="text-danger"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input type="hidden" id="uuid" name="uuid" value="${wechatTm.uuid}">
                                        <input type="hidden" id="tmtype" name="tmtype" value="${wechatTm.tmtype}">
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer text-left bg-light lter">
                                <button type="submit" class="btn btn-submit btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                            </div>
                        </section>
                    </form>
                </div>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<script type="text/javascript">
    //显示父菜单
    showParentMenu('公众号');

</script>

</body>
</html>