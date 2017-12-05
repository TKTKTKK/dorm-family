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
            <header class="panel-heading bg-white text-lg">
                满田星 / <span class="font-bold  text-shallowred"> 订单信息</span>
            </header>
            <div class="col-sm-12 pos">
                <div style="margin-bottom: 5px">
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley"
                      action="${ctx}/admin/wefamily/orderInfo" method="POST"
                      onsubmit="return checkIfValid()" enctype="multipart/form-data" id="frm">
                    <section class="panel panel-default">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">订单信息：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>订单编号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="snno" id="snno"
                                           data-maxlength="32"
                                           onblur="trimText(this)"
                                           value="${order.snno}">
                                    <span id="snnoError" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>机器型号：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input type="text" class="form-control" data-required="true" name="machinemodel" id="machinemodel"
                                           data-maxlength="32"
                                           onblur="trimText(this)"
                                           value="${order.machinemodel}">
                                    <span id="machinemodelError" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3  control-label"><span class="text-danger">*</span>订购数量：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <input class="form-control" size="1" data-required="true"
                                           data-type="digits" name="quantity" value="${order.quantity}"
                                           data-maxlength="11"
                                           data-min="1"
                                    >
                                    <span id="quantitylError" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="hidden" name="uuid" class="form-control" value="${order.uuid}">
                                    <input type="hidden" name="versionno" class="form-control"
                                           value="${order.versionno}">
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer text-left bg-light lter">
                                <button type="submit" class="btn btn-submit btn-s-xs ">
                                    <i class="fa fa-check"></i>&nbsp;提&nbsp;交
                                </button>
                        </div>
                    </section>
                </form>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<script type="text/javascript" src="${ctx}/static/admin/geo.js"></script>
<script type="text/javascript">

    window.onload = function () {
        //显示父菜单
        showParentMenu('满田星');
    }



</script>

</body>
</html>